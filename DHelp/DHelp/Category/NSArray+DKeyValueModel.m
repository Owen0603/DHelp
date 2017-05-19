//
//  NSArray+DKeyValueModel.m
//  DHelp
//
//  Created by 姚凤 on 2017/3/13.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import "NSArray+DKeyValueModel.h"

@implementation NSArray (DKeyValueModel)

- (NSDictionary *)keyValue{
    if (self.count==0) {
        return @{};
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (id obj in self) {
        if ([obj isKindOfClass:[DKeyValueModel class]]) {
            DKeyValueModel *model = (DKeyValueModel *)obj;
            [dict setObject:model.valueString forKey:model.keyString];
        }
    }
    return [dict copy];
}

@end
