//
//  AppDelegate.h
//  DHelp
//
//  Created by 姚凤 on 2017/3/8.
//  Copyright © 2017年 姚凤. All rights reserved.
//


#import "AppDelegate.h"
#import "DWindowController.h"
void UncaughtExceptionHandler(NSException *exception);

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{

    if (!window) {
        window = [[DWindowController alloc] initWithWindowNibName:@"DWindowController"];
    }
    
    [window showWindow:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
    
	return YES;
}

- (void)application:(NSApplication *)sender openFiles:(NSArray *)filenames{
    
    if (filenames.count > 0) {
        NSString *path = [filenames objectAtIndex:0];
        if (!window) {
            window = [[DWindowController alloc] initWithWindowNibName:@"DWindowController"];
        }

        [window openFile:path];
    }
}

- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename{
    
    if (!window) {
        window = [[DWindowController alloc] initWithWindowNibName:@"DWindowController"];
    }
    [window openFile:filename];
    return YES;
}


@end

void UncaughtExceptionHandler(NSException *exception){
    
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *urlStr = [NSString stringWithFormat:@"Error Details:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@",
                        name,reason,[arr componentsJoinedByString:@"<br>"]];
    
    //    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"$$$$$$$$$$$$$$$$$$$$$$$\n\n%@\n\n",urlStr);
    NSLog(@"Log write success.");
    //    [[UIApplication sharedApplication] openURL:url];
}
