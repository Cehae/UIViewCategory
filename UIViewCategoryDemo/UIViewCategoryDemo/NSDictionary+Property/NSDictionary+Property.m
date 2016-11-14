//
//  NSDictionary+Property.m
//  自动生成模型属性代码
//
//  Created by Cehae on 16/3/4.
//  Copyright © 2016年 Cehae. All rights reserved.
//

#import "NSDictionary+Property.h"

@implementation NSDictionary (Property)
// 根据字典中的key生成属性代码
- (void)createPropertyCode
{
    NSMutableString *codes = [NSMutableString string];
    // 遍历字典
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        
        NSString *code;
        if ([value isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        } else if ([value isKindOfClass:[NSNumber class]]) {
             code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        } else if ([value isKindOfClass:[NSArray class]]) {
             code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
             code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
        }

        [codes appendFormat:@"\n/** <#content#> */\n%@\n",code];
        
    }];
    
    SLog(@"%@",codes);
}

@end
