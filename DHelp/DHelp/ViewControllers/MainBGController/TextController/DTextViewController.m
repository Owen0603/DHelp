//
//  DTextViewController.m
//  DHelp
//
//  Created by 姚凤 on 2017/3/7.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import "DTextViewController.h"
#import "MarkerLineNumberView.h"

@interface DTextViewController ()

@property(nonatomic, strong) MarkerLineNumberView *lineNumberView;

@end

@implementation DTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self initsubViews];
}


- (void)initsubViews{
    _lineNumberView = [[MarkerLineNumberView alloc] initWithScrollView:self.scrollView];
    CGFloat lineNumberColor = 42.0 / 255.0;
    
    _lineNumberView.backgroundColor = [NSColor colorWithCalibratedRed:lineNumberColor green:lineNumberColor blue:lineNumberColor alpha:1.0f];
    (self.scrollView).verticalRulerView = _lineNumberView;
    [self.scrollView setHasHorizontalRuler:NO];
    [self.scrollView setHasVerticalRuler:YES];
    [self.scrollView setRulersVisible:YES];
}

@end
