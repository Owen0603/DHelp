//
//  DJsonViewController.h
//  DHelp
//
//  Created by 姚凤 on 2017/3/8.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface DJsonViewController : NSViewController
@property (weak) IBOutlet WebView *webView;

- (void)refreshJsonString:(NSString *)json;

- (NSString *)jsonStringFromJSonEditor;

@end
