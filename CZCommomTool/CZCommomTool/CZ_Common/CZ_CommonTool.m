//
//  CZ_CommonTool.m
//  CZCommomTool
//
//  Created by chuanzhang on 2020/10/30.
//

#import "CZ_CommonTool.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

@implementation CZ_CommonTool

//修改图片尺寸
+ (UIImage *)resizeImage:(UIImage*)img andResizeTo:(CGSize)newSize {
    CGFloat scale = [[UIScreen mainScreen] scale];
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//设置毛玻璃效果
+ (void)virtualBackgroundWithView:(UIView *)view rect:(CGRect)viewRect lightNum:(CGFloat)lightNum {
    lightNum = 0.9;
    for (NSInteger i = 0; i<view.subviews.count; i++) {
        UIView *tempView = view.subviews[i];
        if (tempView.tag == 10010) {
            [tempView removeFromSuperview];
            tempView = nil;
            break;
        }
    }
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.tag = 10010;
    effectView.frame = viewRect;
    [view addSubview:effectView];
    UIView *maskView = [[UIView alloc] initWithFrame:viewRect];
    maskView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:lightNum];
    [effectView.contentView addSubview:maskView];
}

//移除毛玻璃父视图
+ (void)removeVirtualView:(UIView *)superView {
    if(superView.subviews.count>0) {
        for (NSInteger i = 0; i<superView.subviews.count; i++) {
            UIView *tempView = superView.subviews[i];
            if (tempView.tag == 10010) {
                [tempView removeFromSuperview];
                tempView = nil;
                break;
            }
        }
    }
}

+ (UIImage *)gainImageWithColor:(UIColor *)color {
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

+ (UIViewController *)gainCurrentViewController {
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    UIViewController* currentViewController = window.rootViewController;

    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else {
                break;
            }
        }
    }
    
    return currentViewController;
}

+ (UIFont *)gainFontWithName:(NSString *)fontName size:(CGFloat)fontSize {
    
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    
    if (!font || [font isKindOfClass:[NSNull class]]) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
    return font;
}

+ (CZ_NetWorkState)getNetWorkStatesWithHostName:(NSString *)hostName {
    
    
    CZ_NetWorkState netWorkState = CZ_NetWorkState_None;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
    SCNetworkReachabilityFlags flags;
    
    if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
        
        BOOL isLocalW = NO;
        struct sockaddr_in localWifiAddress;
        bzero(&localWifiAddress, sizeof(localWifiAddress));
        localWifiAddress.sin_len = sizeof(localWifiAddress);
        localWifiAddress.sin_family = AF_INET;
        // IN_LINKLOCALNETNUM is defined in <netinet/in.h> as 169.254.0.0.
        localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);
        
        
        if ((flags & kSCNetworkReachabilityFlagsReachable) && (flags & kSCNetworkReachabilityFlagsIsDirect))
        {
            netWorkState = CZ_NetWorkState_WiFi;
        }
        
        
        
        
        if (isLocalW) {
            
        }else{
            
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0) {
                return CZ_NetWorkState_None;
            }
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0) {
                netWorkState = CZ_NetWorkState_WiFi;
            }
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)) {
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0) {
                    netWorkState = CZ_NetWorkState_WiFi;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
                /*
                 ... but WWAN connections are OK if the calling application is using the CFNetwork APIs.
                 */
                netWorkState = CZ_NetWorkState_WWAN;
            }
        }
    }
    
    return netWorkState;
}

@end
