//
//  UITextView+WDPlaceholder.m
//  Cehae
//
//  Created by Cehae on 16/11/14.
//  Copyright © 2016年 Cehae. All rights reserved.
//

#import "UITextView+WDPlaceholder.h"
#import <objc/runtime.h>

/// 默认的间距
static CGFloat const WD_Default_Padding = 8;

@implementation UITextView (WDPlaceholder)

@dynamic  WD_placeholder,WD_placeholderColor,WD_placeholderTopPadding,WD_placeholderLeftPadding;

#pragma mark - 利用runtime动态添加set/get方法来添加属性
- (CGFloat )WD_placeholderLeftPadding{
    id placeholderLeftPadding = objc_getAssociatedObject(self, _cmd);
    return placeholderLeftPadding ? [placeholderLeftPadding doubleValue] : WD_Default_Padding;
}

- (CGFloat)WD_placeholderTopPadding{
    id placeholderTopPadding = objc_getAssociatedObject(self, _cmd);
    return placeholderTopPadding ? [placeholderTopPadding doubleValue] : WD_Default_Padding;
}

- (void)setWD_placeholderLeftPadding:(CGFloat)WD_placeholderLeftPadding{
    objc_setAssociatedObject(self, @selector(WD_placeholderLeftPadding), @(WD_placeholderLeftPadding), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setWD_placeholderTopPadding:(CGFloat)WD_placeholderTopPadding{
    objc_setAssociatedObject(self, @selector(WD_placeholderTopPadding), @(WD_placeholderTopPadding), OBJC_ASSOCIATION_ASSIGN);
}

- (UIColor *)WD_placeholderColor{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWD_placeholderColor:(UIColor *)WD_placeholderColor{
    if ([self WD_placeholderLabel]) {
        [self WD_placeholderLabel].textColor = WD_placeholderColor;
    }
    objc_setAssociatedObject(self, @selector(WD_placeholderColor), WD_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)WD_placeholder{
    return [self WD_placeholderLabel].text;
}

- (void)setWD_placeholder:(NSString *)WD_placeholder{
    if (self.delegate) { // 设置了代理对象
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class delegateClass = [self.delegate class];
            Class swizzleClass = [self class];
            
            SEL originalSelector = @selector(textViewDidChange:);
            SEL swizzleSelector = @selector(WD_textViewDidChange:);
            
            Method originalMethod = class_getInstanceMethod(delegateClass, originalSelector);
            Method swizzleMethod = class_getInstanceMethod(swizzleClass, swizzleSelector);
            
            if (class_addMethod(delegateClass, swizzleSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))) {
                BOOL isAddMethod = class_addMethod(delegateClass, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
                if (isAddMethod) { // 添加了原来没有的方法 ， 替换添加的方法
                    Method newSwizzleMethod = class_getInstanceMethod(swizzleClass, originalSelector);
                    class_replaceMethod(delegateClass, originalSelector, method_getImplementation(newSwizzleMethod), method_getTypeEncoding(newSwizzleMethod));
                } else{ // 原来已经存在这个方法,交换实现方法
                    Method newSwizzleMethod = class_getInstanceMethod(delegateClass, swizzleSelector);
                    method_exchangeImplementations(originalMethod, newSwizzleMethod);
                }
            }
            
        });
    }else{
        self.delegate = self;
    }
    
    UILabel *placeholderLabel = [self WD_placeholderLabel];
    if (!placeholderLabel) {
        placeholderLabel = [UILabel new];
        placeholderLabel.textColor = self.WD_placeholderColor ?: [UIColor lightGrayColor];
        placeholderLabel.font = self.font;
        placeholderLabel.frame = CGRectMake(self.WD_placeholderLeftPadding, self.WD_placeholderTopPadding, 10, 10);
        [self addSubview:placeholderLabel];
        [self setWD_placeholderLabel:placeholderLabel];
    }
    placeholderLabel.text = WD_placeholder;
    [placeholderLabel sizeToFit];
}
#pragma mark - 私有方法
- (UILabel *)WD_placeholderLabel{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWD_placeholderLabel:(UILabel *)WD_placeholderLabel{
    objc_setAssociatedObject(self, @selector(WD_placeholderLabel), WD_placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 输入文字取消占位
- (void)WD_textViewDidChange:(UITextView *)textView{
    [self WD_textViewDidChange:textView];
    [self WD_placeholderLabel].hidden = (textView.text.length > 0);
}

- (void)textViewDidChange:(UITextView *)textView{ // 当输入文字长度大于0时，隐藏占位文字
    [self WD_placeholderLabel].hidden = (textView.text.length > 0);
}
@end

