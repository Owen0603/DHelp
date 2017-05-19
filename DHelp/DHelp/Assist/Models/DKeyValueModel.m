//
//  DKeyValueModel.m
//  DHelp
//
//  Created by 姚凤 on 2017/3/11.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import "DKeyValueModel.h"

@implementation DKeyValueModel

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value{
    if (self = [super init]) {
        _keyString = key;
        _valueString = value;
    }
    return self;
}

- (BOOL)isEmpty{
    if (!self.keyString || !self.valueString) {
        return true;
    }else if([self.keyString isEqualToString:@""]||[self.valueString isEqualToString:@""]){
        return true;
    }
    return false;
}
@end
