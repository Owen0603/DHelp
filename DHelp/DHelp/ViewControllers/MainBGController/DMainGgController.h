//
//  DMainGgController.h
//  DHelp
//
//  Created by 姚凤 on 2017/3/9.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RichTextEditor.h"

@interface DMainGgController : NSViewController

@property (weak) IBOutlet DRootSubview *dataView;
@property (unsafe_unretained) IBOutlet RichTextEditor *logsView;


@property (nonatomic, copy) NSMutableAttributedString *logsAttributeString;


- (void)dAPIControllerDelegateRequestResult:(DRequest *)resultRequest;

@end
