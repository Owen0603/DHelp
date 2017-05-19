//
//  DRequest.h
//  DHelp
//
//  Created by 姚凤 on 2017/3/13.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "YTKBaseRequest.h"
#import <sys/time.h>

typedef NS_ENUM(NSUInteger, APIRequestState) {
    APIRequestStateStart,
    APIRequestStateEnd,
};

@interface DRequest : YTKRequest

@property(nonatomic, assign) struct timeval beginDate;
@property(nonatomic, assign) struct timeval endDate;
@property(nonatomic, assign) BOOL requestSuccess;
@property(nonatomic, assign) APIRequestState requestState;

- (instancetype)initWithBaseUrl:(NSString *)dRequestUrl params:(NSArray<DKeyValueModel *>*)params Header:(NSArray<DKeyValueModel *>*)header httpMethod:(YTKRequestMethod)method;


-(void)dRequestStart:(void(^)(void))start end:(void(^)(YTKBaseRequest * result))resultBlock;

@end
