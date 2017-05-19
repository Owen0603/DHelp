//
//  PAWindowController.h
//  DTPowerApi
//
//  Created by leks on 12-12-27.
//  Copyright (c) 2012年 leks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DTextViewController.h"
#import "PASplitView.h"

@interface DWindowController : NSWindowController<NSWindowDelegate, NSSplitViewDelegate, NSToolbarDelegate>
@property (weak) IBOutlet DRootSubview *leftView;
@property (weak) IBOutlet DRootSubview *rightView;



-(BOOL)openFile:(NSString*)filepath;
@end
