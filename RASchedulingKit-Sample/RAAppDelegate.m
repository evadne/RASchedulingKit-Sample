//
//  RAAppDelegate.m
//  RASchedulingKit-Sample
//
//  Created by Evadne Wu on 10/11/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import "RAAppDelegate.h"
#import "RAViewController.h"

@implementation RAAppDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.backgroundColor = [UIColor whiteColor];
	
	UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:[RAViewController new]];
	
	[navC setToolbarHidden:NO	animated:NO];
	
	self.window.rootViewController = navC;
	
	[self.window makeKeyAndVisible];
	
	return YES;
	
}

@end
