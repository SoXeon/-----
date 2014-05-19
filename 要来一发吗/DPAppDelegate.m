//
//  DPAppDelegate.m
//  要来一发吗
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "DPAppDelegate.h"
#import "DPMainViewController.h"

@implementation DPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    DPMainViewController *controller = [[DPMainViewController alloc]init];
    [self.window setRootViewController:controller];
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
