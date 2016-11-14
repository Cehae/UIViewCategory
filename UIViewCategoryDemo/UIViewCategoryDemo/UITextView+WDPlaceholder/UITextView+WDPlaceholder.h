//
//  UITextView+WDPlaceholder.h
//  Cehae
//
//  Created by Cehae on 16/11/14.
//  Copyright © 2016年 Cehae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (WDPlaceholder)
/** 占位文字左间距 */
@property (nonatomic,assign) CGFloat WD_placeholderLeftPadding;
/** 占位文字上间距 */
@property (nonatomic,assign) CGFloat WD_placeholderTopPadding;
/** 占位文字颜色 */
@property (nonatomic,strong) IBInspectable UIColor * WD_placeholderColor;
/** 占位文字 */
@property (nonatomic,strong) IBInspectable NSString * WD_placeholder;
@end
