//
//  AppDelegate.m
//  ARTestTool
//
//  Created by 陈文娟 on 2017/5/4.
//  Copyright © 2017年 陈文娟. All rights reserved.
//

#import "AppDelegate.h"
#import <KudanAR/ARAPIKey.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[ARAPIKey sharedInstance] setAPIKey:@"PZUbLKkfpOOeVEIwbl57QW2GGRcJICMIhLOo2i1984uwB1VnYyCXqaxrXhIAhutLkN1J8bH3qPPOhcKo16wbLjXotarr6lzg25ELpwCoPSKK6GBXg2wdWpXnZc4GXiTqpXtOTjYAnqTRZ02oR015uIQd9uBr/kr3ZQWNl/kQDyEANTtMqVY8dp5UPRk5Xjf8vlvzGjp+bLJxuAKHCW57l6G9IyuhvTwoOyvvcTYGrl7cSE1177t1vtbJiCO5LjjCxMgVKabYz5G3mI5HLuGLJQujUSg2Ei5GRnS3kd8oFMeduAs6ZuvbQweEZYRZG1/em7bA46Le9L4SbJl+Qtd+MHIi/rL5o5JZdkhQ9zJViY/rkuxbYWvZ2qcMCgmaee5786vEWKraPTUgURh67+DYAlgX3O7m4h5KTCzh0YWYBajXxViLW5GWpEIfh1SO5suslNS0PUr3GkWG0Qp86qG0QTI1IEpFZsSnLHgW6ukSmJo57mcHQMhyQyjF/U2S07osU7CP1nMYsnQ4k8AHJXzpArCCOyrg19xiWHeiVbOuj/QKk+zGVPU2br1kuCZzl8yq544w1TfQGIIH7WrO1lZvAT4DNfayDbsxDCL9zXepcriDGCjeg9I80TL6NeyaMmnBOpCNlt5lvnFZkxFgnwYITsOlxUB3lxTCx5fW03WQ3Ww="];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
