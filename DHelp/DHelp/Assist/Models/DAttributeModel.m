//
//  DAttributeModel.m
//  DHelp
//
//  Created by 姚凤 on 2017/3/13.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import "DAttributeModel.h"

@implementation DAttributeModel
+(NSAttributedString*)attributedString:(NSString*)str color:(NSColor*)color fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
    NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:str];
    NSFont *font = nil;
    
    if (bold) {
        font = [NSFont boldSystemFontOfSize:fontSize];
    }
    else
    {
        font = [NSFont systemFontOfSize:fontSize];
    }
    
    NSRange r = NSMakeRange(0, str.length);
    
    [mas beginEditing];
    [mas addAttribute:NSFontAttributeName
                value:font
                range:r];
    
    if (color)
    {
        [mas addAttribute:NSForegroundColorAttributeName
                    value:color
                    range:r];
    }
    [mas endEditing];
    return mas;
}
@end
