//
//  AppDelegate.m
//  AtrributedString
//
//  Created by Admin on 27/07/16.
//  Copyright © 2016 Paymate. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeNewsstandContentAvailability| UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewanimatio = [[SelectControlViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:self.viewanimatio];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

// Delegation methods
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    NSString * deviceTokenString = [[[[devToken description]
                                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                                    stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"The generated device token string is : %@",deviceTokenString);
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"]; // This appsInfo set by your server while sending push
    
   // NSString *alert = [apsInfo objectForKey:@"alert"];
    NSString *controller=[apsInfo objectForKey:@"controller"];
    UIApplicationState state = [application applicationState];
    
    if (state == UIApplicationStateActive || state == UIApplicationStateInactive || state == UIApplicationStateBackground ) {
        application.applicationIconBadgeNumber = 0;
        
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.viewanimatio = [[SelectControlViewController alloc]init];
        self.viewanimatio.fromNotification=@"yes";
        self.viewanimatio.viewController=controller;
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:self.viewanimatio];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
        
        
//        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Push Notification"
//                                                            message:alert
//                                                           delegate:self
//                                                  cancelButtonTitle:@"NO"
//                                                  otherButtonTitles:@"YES", nil];
//        [alertview show];
        
    }
    else
    {
        
    }
}


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
        // User pressed YES, do your stuffs
    }
}- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
