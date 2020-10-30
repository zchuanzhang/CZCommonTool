//
//  CZ_CommonTool.m
//  CZCommomTool
//
//  Created by chuanzhang on 2020/10/30.
//

#import "CZ_CommonTool.h"

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
@end
