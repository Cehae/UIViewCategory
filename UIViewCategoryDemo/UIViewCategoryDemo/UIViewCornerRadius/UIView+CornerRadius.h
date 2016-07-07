//
//  UIView+CornerRadius.h
//  UIViewCategoriesDemo
//
//  Created by Wdong on 16/7/7.
//  Copyright © 2016年 Wdong. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (CornerRadius)

@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;
@property (nonatomic, strong)IBInspectable UIColor *borderColor;
@end
