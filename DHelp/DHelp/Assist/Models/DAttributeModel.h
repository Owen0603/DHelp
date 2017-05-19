//
//  DAttributeModel.h
//  DHelp
//
//  Created by 姚凤 on 2017/3/13.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAttributeModel : NSObject
+(NSAttributedString*)attributedString:(NSString*)str color:(NSColor*)color fontSize:(CGFloat)fontSize bold:(BOOL)bold;
@end
