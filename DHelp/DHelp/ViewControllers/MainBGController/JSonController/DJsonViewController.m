//
//  DJsonViewController.m
//  DHelp
//
//  Created by 姚凤 on 2017/3/8.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import "DJsonViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface DJsonViewController ()

@end

@implementation DJsonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self loadJsonEditor];
}


- (void)loadJsonEditor{
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"index"
                                                         ofType:@"html"
                                                    inDirectory:@"web"];
    NSURL* fileURL = [NSURL fileURLWithPath:filePath];
    NSURLRequest* request = [NSURLRequest requestWithURL:fileURL];
    [[self.webView mainFrame] loadRequest:request];
}

- (void)refreshJsonString:(NSString *)json{
    
    JSContext* context = [[self.webView mainFrame] javaScriptContext];
    NSString *text = [NSString stringWithFormat:@"refreshDocument(%@)",json];
    [context evaluateScript:text];
}

- (NSString *)jsonStringFromJSonEditor{
    JSContext *context = [[self.webView mainFrame] javaScriptContext];
    return  [[context evaluateScript:@"saveToString()"] toString];
}

@end
