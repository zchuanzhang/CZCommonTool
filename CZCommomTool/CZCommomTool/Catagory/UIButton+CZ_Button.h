//
//  UIButton+CZ_Button.h
//  CZCommomTool
//
//  Created by chuanzhang on 2020/10/29.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CZSpecialButtonType) {
    CZSpecialButtonType_Default = 0, //默认图片在左文字在右
    CZSpecialButtonType_ImgUpTitleDown, //图上字下
    CZSpecialButtonType_imgRightTitleLeft, //图右字左
    CZSpecialButtonType_ImgDownTitleUp //图下字上
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CZ_Button)

- (void)cz_makeSpecialButtonWithSpecialType:(CZSpecialButtonType)specialType Space:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
