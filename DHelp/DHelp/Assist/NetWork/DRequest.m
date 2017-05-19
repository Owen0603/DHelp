//
//  DRequest.m
//  DHelp
//
//  Created by 姚凤 on 2017/3/13.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import "DRequest.h"
#import "NSArray+DKeyValueModel.h"

@interface DRequest ()

@property(nonatomic, copy) NSString *dbaseUrl;
@property(nonatomic, copy) NSString *drequestUrl;
@property(nonatomic, assign) YTKRequestMethod method;
@property(nonatomic, strong) NSDictionary *params;
@property(nonatomic, strong) NSDictionary *headers;
@end

@implementation DRequest

- (instancetype)initWithBaseUrl:(NSString *)dRequestUrl params:(NSArray<DKeyValueModel *>*)params Header:(NSArray<DKeyValueModel *>*)header httpMethod:(YTKRequestMethod)method{
    if (self = [super init]) {
        self.params = [params keyValue];
        self.headers = [header keyValue];
        self.drequestUrl = dRequestUrl;
        self.method = method;
        self.requestState = APIRequestStateStart;
        
        if (self.method == YTKRequestMethodGET) {
            self.drequestUrl = [self requestUrlWithBase:dRequestUrl parmas:params];
        }
    }
    return self;
}

- (NSString *)requestUrlWithBase:(NSString *)base parmas:(NSArray *)params{
    NSString *variables = @"";
    NSString *headerValue = nil;
    NSString *keyValue = nil;
    
    // Build the request string
    for (DKeyValueModel *model in params) {
        if (![variables isEqualToString:@""]) {
            variables = [variables stringByAppendingString:@"&"];
        }
        headerValue = model.valueString;
        keyValue = model.keyString;
        
        headerValue = [headerValue stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        keyValue = [keyValue stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        variables = [variables stringByAppendingString:[NSString stringWithFormat:@"%@=%@", keyValue, headerValue]];
    }
    
    NSArray *array = [base componentsSeparatedByString:@"?"];
    if (array.count == 1) {
        // There are no post parameters
        base = [NSString stringWithFormat:@"%@?%@", base, variables];
    } else if (array.count == 2) {
        if ([array[1] isEqualToString:@""]) {
            // Try to fake me out with a fake url? How dare you
            base = [NSString stringWithFormat:@"%@%@", base, variables];
        } else {
            // Let's just keep appending stuff
            base = [NSString stringWithFormat:@"%@&%@", base, variables];
        }
    }
    return base;
}

-(void)dRequestStart:(void(^)(void))start end:(void(^)(YTKBaseRequest * result))resultBlock{
    
    struct timeval startTime;
    gettimeofday( &startTime, NULL);
    self.beginDate = startTime;
    
    start();
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self requestActionEnd:true];
        resultBlock(request);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self requestActionEnd:false];
        resultBlock(request);
    }];
}

- (void)requestActionEnd:(BOOL)success{
    struct timeval end;
    gettimeofday( &end, NULL);
    self.endDate = end;
    self.requestState = APIRequestStateEnd;
    self.requestSuccess = success;
}

- (NSString *)requestUrl{
    return self.drequestUrl;
}

- (YTKRequestMethod)requestMethod{
    
    return self.method;
}

- (id)requestArgument{
    
    return self.method == YTKRequestMethodPOST?nil:@{@"header":self.headers,@"body":self.params};
}

@end
