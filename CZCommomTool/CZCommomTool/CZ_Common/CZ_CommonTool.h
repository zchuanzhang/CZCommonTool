//
//  CZ_CommonTool.h
//  CZCommomTool
//
//  Created by chuanzhang on 2020/10/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CZ_NetWorkState) {
    CZ_NetWorkState_None,
    CZ_NetWorkState_WWAN,
    CZ_NetWorkState_WiFi //
};


NS_ASSUME_NONNULL_BEGIN

@interface CZ_CommonTool : NSObject

/**
 修改图片尺寸
 
 @param img 原始图片
 @param newSize 新图片Size
 @return 新图片
 */
+ (UIImage *)resizeImage:(UIImage*)img andResizeTo:(CGSize)newSize;

/**
 毛玻璃效果
 
 @param view 目标view
 @param viewRect 目标范围
 @param lightNum 亮度值
 */
+ (void)virtualBackgroundWithView:(UIView *)view rect:(CGRect)viewRect lightNum:(CGFloat)lightNum;

/**
 移除毛玻璃

 @param superView 毛玻璃父视图
 */
+ (void)removeVirtualView:(UIView *)superView;

/// 根据颜色获取图片
/// @param color 颜色
+ (UIImage *)gainImageWithColor:(UIColor *)color;

/// 获取当前控制器
+ (UIViewController *)gainCurrentViewController;


/// 获取字体
/// @param fontName 字体名称
/// @param fontSize 字体大小
+ (UIFont *)gainFontWithName:(NSString *)fontName size:(CGFloat)fontSize;


/// 获取网络状态
/// @param hostName 地址
+ (CZ_NetWorkState)getNetWorkStatesWithHostName:(NSString *)hostName;

@end

NS_ASSUME_NONNULL_END
