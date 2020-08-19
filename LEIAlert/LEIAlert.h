//
//  LEIAlert.h
//  zmwMall
//
//  Created by yanglei on 2020/5/19.
//  Copyright © 2020 Our Home Network Technology (Beijing) Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 使用示例
 @property (nonatomic, strong) LEIAlert *leiAlert;

 - (LEIAlert *)leiAlert {
     if (!_leiAlert) {
         _leiAlert = [[LEIAlert alloc] init];
     }
     return _leiAlert;
 }
 
 UIView *view = [[UIView alloc] init];
 view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
 view.backgroundColor = [UIColor redColor];
 
 self.leiAlert
 .LeiCustomView(view)
 .LeiCornerRadius(5)
 .LeiPositionType(LEICustomViewPositionTypeTop)
 .LeiOpenAnimationStyle(LEIAnimationStyleOrientationTop)
 .LeiCloseAnimationStyle(LEIAnimationStyleOrientationTop)
 .LeiShadowOpacity(0.3)
 .LeiOpenAnimationDuration(0.3)
 .LeiCloseAnimationDuration(0.3)
 .LeiActionSheetBottomMargin(-5)
 .LeiClickBackgroundClose(true)
 .LeiShow();
 */
NS_ASSUME_NONNULL_BEGIN

@class LEIAlert;

typedef NS_ENUM(NSInteger, LEICustomViewPositionType) {
    /** 靠上 */
    LEICustomViewPositionTypeTop,
    /** 居中 */
    LEICustomViewPositionTypeCenter,
    /** 靠下 */
    LEICustomViewPositionTypeBottom
};

typedef NS_OPTIONS(NSInteger, LEIAnimationStyle) {
    /** 动画样式方向 默认 */
    LEIAnimationStyleOrientationNone    = 1 << 0,
    /** 动画样式方向 上 */
    LEIAnimationStyleOrientationTop     = 1 << 1,
    /** 动画样式方向 下 */
    LEIAnimationStyleOrientationBottom  = 1 << 2,
};

typedef LEIAlert *_Nullable(^LEIConfig)(void);
typedef LEIAlert *_Nullable(^LEIConfigToView)(UIView *view);
typedef LEIAlert *_Nullable(^LEIConfigToFloat)(CGFloat number);
typedef LEIAlert *_Nullable(^LEIConfigToBool)(BOOL is);
typedef LEIAlert *_Nullable(^LEIConfigToAnimationStyle)(LEIAnimationStyle style);
typedef LEIAlert *_Nullable(^LEIConfigToPositionStyle)(LEICustomViewPositionType style);

@interface LEIAlert : NSObject

/** ✨通用设置 */

/** 设置 自定义视图 -> 格式: .LeiCustomView(UIView) */
@property (nonatomic , copy , readonly ) LEIConfigToView LeiCustomView;

/** 自定义视图位置类型默认在底部LEICustomViewPositionTypeBottom  -> 格式: .LeiPositionType()*/
@property (nonatomic , copy , readonly ) LEIConfigToPositionStyle LeiPositionType;

/** 设置 圆角半径默认10.f  -> 格式: .LeiCornerRadius(13.0f) */
@property (nonatomic , copy , readonly ) LEIConfigToFloat LeiCornerRadius;

/** 设置 阴影不透明度 默认0.3f -> 格式: .LeiShadowOpacity(0.3f) */
@property (nonatomic , copy , readonly ) LEIConfigToFloat LeiShadowOpacity;

/** 设置 开启动画时长默认0.3s -> 格式: .LeiOpenAnimationDuration(0.3f) */
@property (nonatomic , copy , readonly ) LEIConfigToFloat LeiOpenAnimationDuration;

/** 设置 关闭动画时长默认0.2s -> 格式: .LeiCloseAnimationDuration(0.2f) */
@property (nonatomic , copy , readonly ) LEIConfigToFloat LeiCloseAnimationDuration;

/** 设置 点击背景关闭 默认YES -> 格式: .LeiClickBackgroundClose(YES) */
@property (nonatomic , copy , readonly ) LEIConfigToBool LeiClickBackgroundClose;

/** 设置 ActionSheet距离屏幕底部的间距 默认0  -> 格式: .LeiActionSheetBottomMargin(10.0f) */
@property (nonatomic , copy , readonly ) LEIConfigToFloat LeiActionSheetBottomMargin;

/** 设置 打开动画样式 默认从底部出现LEIAnimationStyleOrientationBottom -> 格式: .LeiOpenAnimationStyle() */
@property (nonatomic , copy , readonly ) LEIConfigToAnimationStyle LeiOpenAnimationStyle;

/** 设置 关闭动画样式 默认从底部消失LEIAnimationStyleOrientationBottom -> 格式: .LeiCloseAnimationStyle() */
@property (nonatomic , copy , readonly ) LEIConfigToAnimationStyle LeiCloseAnimationStyle;

/** 显示  -> 格式: .LeiShow() */
@property (nonatomic , copy , readonly ) LEIConfig LeiShow;

/** 关闭 */
- (void)closeWithCompletionBlock:(void (^)(void))completionBlock;

@end

NS_ASSUME_NONNULL_END
