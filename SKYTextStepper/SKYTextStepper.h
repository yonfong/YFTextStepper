//
//  SKYTextStepper.h
//  SKYTextStepper
//
//  Created by sky on 15/4/24.
//  Copyright (c) 2015年 bluesky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKYTextStepper;
// called when value is changed
typedef void (^SKYTextStepperValueChangedCallback)(SKYTextStepper *stepper, float aValue);

typedef enum {
    TextStepperChangeTypeNegative = -1, // event means one step down
    TextStepperChangeTypePositive = 1 // event means one step up
} TextStepperChangeType;


IB_DESIGNABLE
@interface SKYTextStepper : UIControl

@property (nonatomic, assign, readonly) TextStepperChangeType changeType;

@property(nonatomic, assign) float currentValue;        // 当前值
@property(nonatomic, assign) float stepInterval;        // default: 1.0
@property(nonatomic, assign) float minimum;             // default: 0.0
@property(nonatomic, assign) float maximum;             // default: INFINITY
@property(nonatomic, assign) int numDecimals;           // 小数点位数 default: 0
@property(nonatomic, assign) BOOL editableText;         // 文本数值是否可编辑 default: NO;

@property(nonatomic, assign) IBInspectable CGFloat buttonWidth;       // default: 44.0f

@property(nonatomic, copy) SKYTextStepperValueChangedCallback valueChangedCallback;

// view customization
/**
 *  设置边框颜色
 *
 *  @param color 边框颜色
 */
- (void)setBorderColor:(UIColor *)color;

/**
 *  设置边框宽带
 *
 *  @param width 边框宽度
 */
- (void)setBorderWidth:(CGFloat)width;

/**
 *  设置边框圆角
 *
 *  @param radius 圆角值
 */
- (void)setCornerRadius:(CGFloat)radius;

/**
 *  设置中间数值的颜色
 *
 *  @param color 文字颜色
 */
- (void)setTextColor:(UIColor *)color;

/**
 *  设置中间文字字体
 *
 *  @param font 文字字体
 */
- (void)setTextFont:(UIFont *)font;

/**
 *  设置按钮字体颜色
 *
 *  @param color 字体颜色
 *  @param state 按钮状态
 */
- (void)setButtonTextColor:(UIColor *)color forState:(UIControlState)state;

/**
 *  设置按钮字体
 *
 *  @param font 按钮字体
 */
- (void)setButtonFont:(UIFont *)font;


@end
