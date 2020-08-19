//
//  LEIAlert.m
//  zmwMall
//
//  Created by yanglei on 2020/5/19.
//  Copyright © 2020 Our Home Network Technology (Beijing) Co., Ltd. All rights reserved.
//

#import "LEIAlert.h"

#define LEI_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define LEI_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface LEIAlert ()

@property (nonatomic , strong ) UIWindow *alertWindow;
@property (nonatomic , strong ) UIView *backView;

@property (nonatomic , assign ) CGFloat modelCornerRadius;
@property (nonatomic , assign ) CGFloat modelShadowOpacity;
@property (nonatomic , assign ) CGFloat modelOpenAnimationDuration;
@property (nonatomic , assign ) CGFloat modelCloseAnimationDuration;
@property (nonatomic , assign ) CGFloat modelActionSheetBottomMargin;

@property (nonatomic , assign ) BOOL modelIsClickBackgroundClose;

@property (nonatomic , assign ) LEICustomViewPositionType positionType;

@property (nonatomic , strong ) UIView *customView;
@property (nonatomic , strong ) UIView *shadowView;

@property (nonatomic , assign ) LEIAnimationStyle modelOpenAnimationStyle;
@property (nonatomic , assign ) LEIAnimationStyle modelCloseAnimationStyle;

@property (nonatomic , assign ) BOOL isAnimation;//正在动画

@end

@implementation LEIAlert

- (void)dealloc {
    NSLog(@"LEIAlert dealloc");
}

- (void)closeWithCompletionBlock:(void (^)(void))completionBlock {
    [self performSelector:@selector(close)];
    completionBlock();
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 初始化默认值
        _modelCornerRadius = 10.0f; //默认圆角半径
        _modelShadowOpacity = 0.3f; //默认阴影不透明度
        _modelOpenAnimationDuration = 0.3f; //默认打开动画时长
        _modelCloseAnimationDuration = 0.2f; //默认关闭动画时长
        _modelIsClickBackgroundClose = YES; //默认点击背景关闭
        _modelActionSheetBottomMargin = 10.0f; //默认actionsheet距离屏幕底部距离
        _positionType = LEICustomViewPositionTypeBottom; //默认靠底部
        _modelOpenAnimationStyle = LEIAnimationStyleOrientationBottom;
        _modelCloseAnimationStyle = LEIAnimationStyleOrientationBottom;
    }
    return self;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        [self.alertWindow addSubview:_backView];
        _backView.frame = self.alertWindow.bounds;
    }
    return _backView;
}

- (LEIConfigToView)LeiCustomView {
    
    __weak typeof(self) weakSelf = self;
    
    return ^(UIView *view){
        
        if (weakSelf)  weakSelf.customView = view;

        return weakSelf;
    };
    
}

- (LEIConfigToFloat)LeiCornerRadius {
    
    __weak typeof(self) weakSelf = self;
    
    return ^(CGFloat number){
        
        if (weakSelf) weakSelf.modelCornerRadius = number;
        
        return weakSelf;
    };
    
}

- (LEIConfigToFloat)LeiShadowOpacity {
    
    __weak typeof(self) weakSelf = self;
    
    return ^(CGFloat number){
        
        if (weakSelf) weakSelf.modelShadowOpacity = number;
        
        return weakSelf;
    };
    
}

- (LEIConfigToFloat)LeiOpenAnimationDuration {
    
    __weak typeof(self) weakSelf = self;
    
    return ^(CGFloat number){
        
        if (weakSelf) weakSelf.modelOpenAnimationDuration = number;
        
        return weakSelf;
    };
    
}

- (LEIConfigToFloat)LeiCloseAnimationDuration {
    
    __weak typeof(self) weakSelf = self;
    
    return ^(CGFloat number){
        
        if (weakSelf) weakSelf.modelCloseAnimationDuration = number;
        
        return weakSelf;
    };
    
}

- (LEIConfigToFloat)LeiActionSheetBottomMargin {
    
    __weak typeof(self) weakSelf = self;
    
    return ^(CGFloat number){
        
        if (weakSelf) weakSelf.modelActionSheetBottomMargin = number;
        
        return weakSelf;
    };
    
}

- (LEIConfigToBool)LeiClickBackgroundClose {
    
    __weak typeof(self) weakSelf = self;
    
    return ^(BOOL is){
        
        if (weakSelf) weakSelf.modelIsClickBackgroundClose = is;
        
        return weakSelf;
    };
    
}

- (LEIConfigToPositionStyle)LeiPositionType {
    
    __weak typeof(self) weakSelf = self;
    
    return ^(LEICustomViewPositionType style){
        
        if (weakSelf) weakSelf.positionType = style;
        
        return weakSelf;
    };
    
}

- (LEIConfigToAnimationStyle)LeiOpenAnimationStyle {
    
    __weak typeof(self) weakSelf = self;
    
    return ^(LEIAnimationStyle style){
        
        if (weakSelf) weakSelf.modelOpenAnimationStyle = style;
        
        return weakSelf;
    };
    
}

- (LEIConfigToAnimationStyle)LeiCloseAnimationStyle{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(LEIAnimationStyle style){
        
        if (weakSelf) weakSelf.modelCloseAnimationStyle = style;
        
        return weakSelf;
    };
    
}

- (LEIConfig)LeiShow{
    
    __weak typeof(self) weakSelf = self;
    
    return ^{
        
        if (weakSelf) {
            [self show];
        }
        
        return weakSelf;
    };
    
}

- (UIWindow *)alertWindow {
    if (!_alertWindow) {
        _alertWindow = [UIApplication sharedApplication].windows[0];
    }
    return _alertWindow;
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = [UIColor blackColor];
        _shadowView.hidden = true;
        _shadowView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeShadow)];
        [_shadowView addGestureRecognizer:tap];
        [self.backView addSubview:_shadowView];
        _shadowView.frame = self.backView.bounds;
    }
    return _shadowView;
}

- (void)closeShadow {
    if (!self.modelIsClickBackgroundClose) {
        return;
    }
    [self close];
}

- (void)close {
    if (_isAnimation) {
        return;
    }
    _isAnimation = true;
    _shadowView.hidden = true;
    
    CGRect rect = self.customView.frame;
    __weak typeof(self) weakSelf = self;
        
    switch (self.modelCloseAnimationStyle) {
        case LEIAnimationStyleOrientationNone:
            [self removeAllViews];
            break;
        case LEIAnimationStyleOrientationTop: {
                self.customView.frame = rect;
                [UIView animateWithDuration:self.modelCloseAnimationDuration animations:^{
                    CGRect frame = rect;
                    frame.origin.y -= LEI_SCREEN_HEIGHT;
                    weakSelf.customView.frame = frame;
                } completion:^(BOOL finished) {
                    [weakSelf removeAllViews];
                }];
            }
            break;
        case LEIAnimationStyleOrientationBottom: {
                self.customView.frame = rect;
                [UIView animateWithDuration:self.modelCloseAnimationDuration animations:^{
                    CGRect frame = rect;
                    frame.origin.y += LEI_SCREEN_HEIGHT;
                    weakSelf.customView.frame = frame;
                }completion:^(BOOL finished) {
                    [weakSelf removeAllViews];
                }];
            }
            break;
        default:
            break;
    }
}

- (void)removeAllViews {
    self.isAnimation = false;
    for (id view in _backView.subviews) {
        [view removeFromSuperview];
    }
    _shadowView = nil;
    
    [_backView removeFromSuperview];
    _backView = nil;
}

- (void)show {
    if (_isAnimation) {
        return;
    }
    _isAnimation = true;
        
    self.shadowView.alpha = self.modelShadowOpacity;
    self.customView.clipsToBounds = true;
    self.customView.layer.cornerRadius = self.modelCornerRadius;
    [self.backView addSubview:self.customView];
    [self.backView bringSubviewToFront:self.customView];
    CGRect rect = self.customView.frame;
    
    switch (self.positionType) {
        case LEICustomViewPositionTypeTop:
            rect.origin.x = (LEI_SCREEN_WIDTH - rect.size.width)/2.f;
            rect.origin.y = 0;
            break;
        case LEICustomViewPositionTypeCenter:
            rect.origin.x = (LEI_SCREEN_WIDTH - rect.size.width)/2.f;
            rect.origin.y = (LEI_SCREEN_HEIGHT - rect.size.height)/2.f;
            break;
        case LEICustomViewPositionTypeBottom:
            rect.origin.x = (LEI_SCREEN_WIDTH - rect.size.width)/2.f;
            rect.origin.y = LEI_SCREEN_HEIGHT - rect.size.height - self.modelActionSheetBottomMargin;
            break;
        default:
            break;
    }
    __weak typeof(self) weakSelf = self;
        
    switch (self.modelOpenAnimationStyle) {
        case LEIAnimationStyleOrientationNone:
            self.customView.frame = rect;
            self.shadowView.hidden = false;
            self.isAnimation = false;
            break;
        case LEIAnimationStyleOrientationTop: {
                rect.origin.y -= rect.size.height + 20;
                self.customView.frame = rect;
                [UIView animateWithDuration:self.modelOpenAnimationDuration animations:^{
                    CGRect frame = rect;
                    frame.origin.y += rect.size.height + 20;
                    weakSelf.customView.frame = frame;
                } completion:^(BOOL finished) {
                    weakSelf.shadowView.hidden = false;
                    weakSelf.isAnimation = false;
                }];
            }
            break;
        case LEIAnimationStyleOrientationBottom: {
                rect.origin.y += rect.size.height + 20;
                self.customView.frame = rect;
                [UIView animateWithDuration:self.modelOpenAnimationDuration animations:^{
                    CGRect frame = rect;
                    frame.origin.y -= rect.size.height + 20;
                    weakSelf.customView.frame = frame;
                }completion:^(BOOL finished) {
                    weakSelf.shadowView.hidden = false;
                    NSLog(@"shadowView%@",weakSelf.shadowView);
                    weakSelf.isAnimation = false;
                }];
            }
            break;
        default:
            break;
    }
    
}

@end
