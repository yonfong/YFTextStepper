//
//  SKYTextStepper.m
//  SKYTextStepper
//
//  Created by sky on 15/4/24.
//  Copyright (c) 2015年 bluesky. All rights reserved.
//

#import "SKYTextStepper.h"

static const float kButtonWidth = 44.0f;

@interface SKYTextStepper ()

@property (nonatomic, retain, readonly) UIButton *plusButton;
@property (nonatomic, retain, readonly) UIButton *minusButton;
@property (nonatomic, retain, readonly) UITextField  *textField;

- (NSString*) getPlaceholderText;
- (void)      didChangeTextField;
@end


@implementation SKYTextStepper
#pragma mark initialization
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.numDecimals = 0;
//    _currentValue = 0.0f;
    _stepInterval = 1.0f;
    _minimum = 0.0f;
    _maximum = INFINITY;
//    _hidesDecrementWhenMinimum = NO;
//    _hidesIncrementWhenMaximum = NO;
    _buttonWidth = kButtonWidth;
    
    self.clipsToBounds = YES;
    [self setBorderWidth:1.0f];
    [self setCornerRadius:3.0];
    
    _textField = [[UITextField alloc] init];
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.layer.borderWidth = 1.0f;
    self.textField.placeholder = [self getPlaceholderText];
    [self.textField setKeyboardType:UIKeyboardTypeDecimalPad];
    [self.textField addTarget:self action:@selector(didChangeTextField) forControlEvents: UIControlEventEditingChanged];
    [self addSubview:self.textField];
    
    _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.plusButton setTitle:@"+" forState:UIControlStateNormal];
    [self.plusButton addTarget:self action:@selector(incrementButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.plusButton];
    
    _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.minusButton setTitle:@"−" forState:UIControlStateNormal];
    [self.minusButton addTarget:self action:@selector(decrementButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.minusButton];
    
    UIColor *defaultColor = [UIColor colorWithRed:(79/255.0) green:(161/255.0) blue:(210/255.0) alpha:1.0];
    [self setBorderColor:defaultColor];
    [self setTextColor:defaultColor];
    [self setButtonTextColor:defaultColor forState:UIControlStateNormal];
    
    [self setTextFont:[UIFont fontWithName:@"Avernir-Roman" size:14.0f]];
    [self setButtonFont:[UIFont fontWithName:@"Avenir-Black" size:24.0f]];
}

#pragma mark render
- (void)layoutSubviews
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    self.textField.frame = CGRectMake(self.buttonWidth, 0, width - (self.buttonWidth * 2), height);
    self.plusButton.frame = CGRectMake(width - self.buttonWidth, 0, self.buttonWidth, height);
    self.minusButton.frame = CGRectMake(0, 0, self.buttonWidth, height);
    
//    self.incrementButton.hidden = (self.hidesIncrementWhenMaximum && [self isMaximum]);
//    self.decrementButton.hidden = (self.hidesDecrementWhenMinimum && [self isMinimum]);
}

//- (void)setup
//{
//    if (self.valueChangedCallback)
//    {
//        self.valueChangedCallback(self, self.value);
//    }
//}

- (CGSize)sizeThatFits:(CGSize)size
{
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        // if CGSizeZero, return ideal size
        CGSize textFieldSize = [self.textField sizeThatFits:size];
        return CGSizeMake(textFieldSize.width + (self.buttonWidth * 2), textFieldSize.height);
    }
    return size;
}


#pragma mark view customization
#pragma mark setter
- (void)setBorderColor:(UIColor *)color
{
    self.layer.borderColor = color.CGColor;
    self.textField.layer.borderColor = color.CGColor;
}

- (void)setBorderWidth:(CGFloat)width
{
    self.layer.borderWidth = width;
}

- (void)setCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
}

- (void)setTextColor:(UIColor *)color
{
    self.textField.textColor = color;
}

- (void)setTextFont:(UIFont *)font
{
    self.textField.font = font;
}

- (void)setButtonTextColor:(UIColor *)color forState:(UIControlState)state
{
    [self.plusButton setTitleColor:color forState:state];
    [self.minusButton setTitleColor:color forState:state];
}

- (void)setButtonFont:(UIFont *)font
{
    self.plusButton.titleLabel.font = font;
    self.minusButton.titleLabel.font = font;
}

-(float)currentValue {
    return [self.textField.text floatValue];
}

- (void)setCurrentValue:(float)currentValue
{
//    _currentValue = currentValue;
    self.textField.text = [NSString stringWithFormat:[@"%.Xf" stringByReplacingOccurrencesOfString:@"X" withString:[NSString stringWithFormat:@"%d", self.numDecimals]], currentValue];
//    if (self.hidesDecrementWhenMinimum)
//    {
//        self.decrementButton.hidden = [self isMinimum];
//    }
//    
//    if (self.hidesIncrementWhenMaximum)
//    {
//        self.incrementButton.hidden = [self isMaximum];
//    }
//    
//    if (self.valueChangedCallback)
//    {
//        self.valueChangedCallback(self, _value);
//    }
}

-(void)setNumDecimals:(int)numDecimals {
    _numDecimals = numDecimals;
    if (_numDecimals<0) {
        _numDecimals =0;
    }
    
    self.textField.placeholder = [self getPlaceholderText]; // to correctly display the decimal number when deleting all charaters
    
    self.currentValue = self.currentValue; // to re-display it correctly
}

- (NSString*)getPlaceholderText
{
    NSMutableString *lstrDato = [NSMutableString stringWithString: @"0"];
    for (int i=0; i<self.numDecimals; i++)
    {
        if (lstrDato.length ==1) // is first time
        {
            [lstrDato appendString:@"."];
        }
        [lstrDato appendString:@"0"];
    }
    return lstrDato;
}

-(void) didChangeTextField
{
    if ( self.currentValue < self.minimum)
        self.currentValue = self.minimum;
    
    if ( self.currentValue > self.maximum)
        self.currentValue = self.maximum;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark event handler
- (void)incrementButtonTapped:(id)sender
{
    if (self.currentValue < self.maximum)
    {
        self.currentValue += self.stepInterval;
//        if (self.incrementCallback)
//        {
//            self.incrementCallback(self, self.value);
//        }
    }
}

- (void)decrementButtonTapped:(id)sender
{
    if (self.currentValue > self.minimum)
    {
        self.currentValue -= self.stepInterval;
//        if (self.decrementCallback)
//        {
//            self.decrementCallback(self, self.value);
//        }
    }
}


#pragma mark private helpers
- (BOOL)isMinimum
{
    return self.currentValue == self.minimum;
}

- (BOOL)isMaximum
{
    return self.currentValue == self.maximum;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
