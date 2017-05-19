//
//  PAWindowController.m
//  DTPowerApi
//
//  Created by leks on 12-12-27.
//  Copyright (c) 2012年 leks. All rights reserved.
//

#import "DWindowController.h"
#import "AppDelegate.h"
#import "DMainGgController.h"
#import "DApiViewController.h"

@interface DWindowController ()<DApiViewControllerDelegate>

@property(nonatomic, strong) DMainGgController *mainGgController;
@property(nonatomic, strong) DApiViewController *apiController;

@end

@implementation DWindowController

- (void)windowDidLoad{
    
    [super windowDidLoad];

    self.mainGgController.view.frame = self.leftView.bounds;
    [self.leftView addSubview:self.mainGgController.view];
    
   
    self.apiController.view.frame = self.rightView.bounds;
    [self.rightView addSubview:self.apiController.view];

}


#pragma mark - apiViewController代理

- (void)apiRequestSuccessResult:(DRequest *)requestModel{
    [self.mainGgController dAPIControllerDelegateRequestResult:requestModel];
}

#pragma mark - splitView 代理
- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex
{
    if (dividerIndex == 0) {
        return 250;
    }
    return 250;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex
{
    if (dividerIndex == 0) {
        return 400;
    }
    return 300;
}

- (BOOL)splitView:(NSSplitView *)splitView shouldAdjustSizeOfSubview:(NSView *)view
{
    if (view == self.leftView)
    {
        if (view.frame.size.width <= 200) {
            return NO;
        }
    }
    
    return false;
}


#pragma mark - get

- (DMainGgController *)mainGgController{
    if (_mainGgController==nil) {
        _mainGgController = [[DMainGgController alloc] init];
    }
    return _mainGgController;
}

- (DApiViewController *)apiController{
    if (_apiController == nil) {
        _apiController = [[DApiViewController alloc] init];
        _apiController.delegate = self;
    }
    return _apiController;
}


@end
