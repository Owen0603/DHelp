//
//  NSView+Frame.m
//  DHelp
//
//  Created by 姚凤 on 2017/3/11.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import "NSView+Frame.h"

@implementation NSView (Frame)


- (CGPoint)center{
    return CGPointMake(self.frame.origin.x+self.frame.size.width/2, self.frame.origin.y+self.frame.size.height/2);
}
@end
