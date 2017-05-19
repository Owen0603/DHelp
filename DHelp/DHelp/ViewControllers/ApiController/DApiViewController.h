//
//  DApiViewController.h
//  DHelp
//
//  Created by 姚凤 on 2017/3/7.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol DApiViewControllerDelegate <NSObject>

- (void)apiRequestSuccessResult:(DRequest *)requestModel;

@end

@interface DApiViewController : NSViewController

@property (weak) IBOutlet NSTextField *urlTextField;
@property (weak) IBOutlet NSTextFieldCell *urlTextFieldCell;
@property (weak) IBOutlet NSMatrix *httpMethodRadioButtons;


@property (weak) IBOutlet NSTextField *paramsKeyField;
@property (weak) IBOutlet NSTextField *paramsValueField;
@property (weak) IBOutlet NSTableView *paramsTableView;


@property (weak) IBOutlet NSTextField *headerKeyField;
@property (weak) IBOutlet NSTextField *headerValueField;
@property (weak) IBOutlet NSTableView *headerTableView;


@property(nonatomic, assign) id<DApiViewControllerDelegate>delegate;

@end
