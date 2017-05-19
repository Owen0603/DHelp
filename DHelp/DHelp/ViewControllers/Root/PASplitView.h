//
//  PASplitView.h
//  DHelp
//
//  Created by 姚凤 on 2017/3/8.
//  Copyright © 2017年 姚凤. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@interface PASplitView : NSSplitView
{
    BOOL isSplitterAnimating;
}
- (void)setSplitterPosition:(float)newSplitterPosition animate:(BOOL)animate;
- (BOOL)isSplitterAnimating;
@end
