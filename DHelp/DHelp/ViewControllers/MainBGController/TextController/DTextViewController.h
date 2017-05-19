//
//  DTextViewController.h
//  DHelp
//
//  Created by 姚凤 on 2017/3/7.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JSONTextView.h"

@interface DTextViewController : NSViewController
@property (unsafe_unretained) IBOutlet JSONTextView *textView;
@property (weak) IBOutlet NSScrollView *scrollView;

@end
