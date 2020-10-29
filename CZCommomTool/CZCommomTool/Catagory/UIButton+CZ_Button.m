//
//  UIButton+CZ_Button.m
//  CZCommomTool
//
//  Created by chuanzhang on 2020/10/29.
//

#import "UIButton+CZ_Button.h"

@implementation UIButton (CZ_Button)

- (void)cz_makeSpecialButtonWithSpecialType:(CZSpecialButtonType)specialType Space:(CGFloat)space {
    UIImage *img = self.imageView.image;
    NSString *title = self.titleLabel.text;
    
    CGFloat imgW = img.size.width;
    CGFloat imgH = img.size.height;
    UIFont *font = self.titleLabel.font;
    
    NSDictionary *atticDic = @{NSFontAttributeName:font};
    CGSize titleSize = [title sizeWithAttributes:atticDic];
    CGFloat titleW = titleSize.width;
    CGFloat titleH = titleSize.height;
    
    CGFloat selfW = self.bounds.size.width;
//    CGFloat selfH = self.bounds.size.height;
    
    if ((titleW >= (selfW - imgW - space))) {
        titleW = selfW - imgW - space;
    }
    
    switch (specialType) {
        case CZSpecialButtonType_Default:{
            NSLog(@"按钮走了默认状态 ---- 0 ---- ");
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case CZSpecialButtonType_imgRightTitleLeft:{
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW + space/2.0, 0, -(titleW + space/2.0));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imgW + space/2.0), 0, imgW + space/2.0);
        }
            break;
        case CZSpecialButtonType_ImgDownTitleUp:{
                self.imageEdgeInsets = UIEdgeInsetsMake((imgH + space)/2.0, titleW/2.0, -(imgH+space)/2.0, -titleW/2.0);
                self.titleEdgeInsets = UIEdgeInsetsMake(-(titleH + space)/2.0, -imgW/2.0, (titleH + space)/2.0, imgW/2.0);
        }
            break;
        case CZSpecialButtonType_ImgUpTitleDown:{
                self.imageEdgeInsets = UIEdgeInsetsMake(-(imgH + space)/2.0, titleW/2.0, (imgH+space)/2.0, -titleW/2.0);
                self.titleEdgeInsets = UIEdgeInsetsMake((titleH + space)/2.0, -imgW/2.0, -(titleH + space)/2.0, imgW/2.0);
        }
            break;
            
        default:
            break;
    }
    
}


@end
