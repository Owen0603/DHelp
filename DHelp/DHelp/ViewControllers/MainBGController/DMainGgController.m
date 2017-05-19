//
//  DMainGgController.m
//  DHelp
//
//  Created by 姚凤 on 2017/3/9.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import "DMainGgController.h"
#import "DJsonViewController.h"
#import "DTextViewController.h"
#import "DAttributeModel.h"


@interface DMainGgController ()

@property(nonatomic, strong) DJsonViewController *jsonViewController;
@property(nonatomic, strong) DTextViewController *textViewController;

@property(nonatomic, assign) int currentTabIndex;

@end

@implementation DMainGgController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dataView addSubview:self.textViewController.view];
    self.textViewController.view.frame = self.dataView.bounds;
    self.textViewController.view.hidden = true;
    
    
    [self.dataView addSubview:self.jsonViewController.view];
    self.jsonViewController.view.frame = self.dataView.bounds;
}



- (void)dAPIControllerDelegateRequestResult:(DRequest *)resultRequest{
    
    if (resultRequest.requestState==APIRequestStateStart) {
        [self start:resultRequest];
    }else if (resultRequest.requestState==APIRequestStateEnd){
        [self end:resultRequest];
    }

}

- (void)start:(DRequest *)resultRequest{
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:resultRequest.beginDate.tv_sec];
    
    NSString *startString = [NSString stringWithFormat:@"【%@】:Starting...\n",date];
    [self.logsAttributeString appendAttributedString:[DAttributeModel attributedString:startString color:[NSColor blackColor] fontSize:17 bold:YES]];
    [self.logsView insertText:self.logsAttributeString replacementRange:NSMakeRange(0, self.logsView.string.length)];
}

- (void)end:(DRequest *)resultRequest{
    
    
    long endTime = resultRequest.endDate.tv_sec*1000+resultRequest.endDate.tv_usec;
    long beginTime = resultRequest.beginDate.tv_sec*1000+resultRequest.beginDate.tv_usec;
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:resultRequest.endDate.tv_sec];
    NSString *endString = [NSString stringWithFormat:@"【%@】:Request End...\n",date];
    NSString *totalTime = [NSString stringWithFormat:@"【%@】:Total Time -- %ld ms\n\n",date,endTime-beginTime];
    [self.logsAttributeString appendAttributedString:[DAttributeModel attributedString:endString color:[NSColor redColor] fontSize:17 bold:YES]];
    [self.logsAttributeString appendAttributedString:[DAttributeModel attributedString:totalTime color:[NSColor redColor] fontSize:17 bold:YES]];
    
    [self.logsView insertText:self.logsAttributeString replacementRange:NSMakeRange(0, self.logsView.string.length)];
    
    
    if (resultRequest.requestSuccess) {
        NSError *error;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:resultRequest.responseData options:NSJSONReadingMutableContainers error:&error];
        
        if (error == nil) {
            id output = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:&error];
            NSString *outputString = [[NSString alloc] initWithData:output encoding:NSUTF8StringEncoding];
            self.textViewController.textView.string = outputString;
            [self.jsonViewController refreshJsonString:outputString];
            [self jsonAction:nil];
        }else {
            self.textViewController.textView.string = resultRequest.responseString;
            [self textAction:nil];
        }
        
    }else{
        
        NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] init];
        [mas appendAttributedString:[DAttributeModel attributedString:@"\nResponse Body:\n\n" color:[NSColor blackColor] fontSize:17 bold:YES]];
        
        [mas appendAttributedString:[DAttributeModel attributedString:resultRequest.responseString?:@"" color:[NSColor blueColor] fontSize:13 bold:NO]];
        
        [mas appendAttributedString:[DAttributeModel attributedString:@"\n\nResponse Headers:\n\n" color:[NSColor blackColor] fontSize:17 bold:YES]];
        
        [mas appendAttributedString:[DAttributeModel attributedString:[resultRequest.responseHeaders JSONString] color:[NSColor darkGrayColor] fontSize:13 bold:NO]];
        
        [self.textViewController.textView insertText:mas replacementRange:NSMakeRange(0, self.textViewController.textView.string.length)];
    }

    [[self.logsView textStorage] appendAttributedString:self.logsAttributeString];
    self.logsAttributeString = nil;
}


#pragma mark - action

- (IBAction)jsonAction:(id)sender {
    self.textViewController.view.hidden = true;
    self.jsonViewController.view.hidden = false;
}
- (IBAction)textAction:(id)sender {
    NSString *json = [[self.jsonViewController jsonStringFromJSonEditor] JSONString];
    [self.textViewController.textView insertText:json replacementRange:NSMakeRange(0, self.textViewController.textView.string.length)];
    
    self.textViewController.view.hidden = false;
    self.jsonViewController.view.hidden = true;
}


#pragma mark - get

- (DJsonViewController *)jsonViewController{
    if (_jsonViewController==nil) {
        _jsonViewController = [[DJsonViewController alloc] init];
    }
    return _jsonViewController;
}

- (DTextViewController *)textViewController{
    if (_textViewController==nil) {
        _textViewController = [[DTextViewController alloc] init];
    }
    return _textViewController;
}

- (NSMutableAttributedString *)logsAttributeString{
    if (_logsAttributeString==nil) {
        _logsAttributeString = [[NSMutableAttributedString alloc] init];
    }
    return _logsAttributeString;
}

@end
