//
//  AppDelegate.m
//  AppInfo
//
//  Created by 杨晴贺 on 08/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}
/// 3DTouch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    if([shortcutItem.type isEqualToString:@"Share"]){
        NSArray *items = @[[NSURL URLWithString:@"https://github.com/silence0201/AppInfo"], [UIImage imageNamed:@"AppIcon60x60@3x.png"] ];
        UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil] ;
        [[[[UIApplication sharedApplication]keyWindow]rootViewController ] presentViewController:controller animated:YES completion:nil] ;
    }else if([shortcutItem.type isEqualToString:@"GitHub"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/silence0201/AppInfo"]] ;
    }
}

@end
