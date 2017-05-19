//
//  DKeyValueModel.h
//  DHelp
//
//  Created by 姚凤 on 2017/3/11.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKeyValueModel : NSObject

@property(nonatomic, copy) NSString *keyString;
@property(nonatomic, copy) NSString *valueString;

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value;


- (BOOL)isEmpty;
@end
