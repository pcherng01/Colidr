//
//  LocationAppDelegate.m
//  Location
//
//  Created by Rick
//  Copyright (c) 2014 Location. All rights reserved.
//

#import "ColidrAppDelegate.h"
#import "CollidrProfileViewController.h"
#import "ColidrLogInViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation ColidrAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
   
   ColidrLogInViewController *logInVC = [[ColidrLogInViewController alloc]init];
   UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:logInVC];
   
   self.window.rootViewController = navController;
   
   self.window.backgroundColor = [UIColor whiteColor];
   [self.window makeKeyAndVisible];
     UIAlertView * alert;
    
    //We have to make sure that the Background App Refresh is enable for the Location updates to work in the background.
    if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied){
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The app doesn't work without the Background App Refresh enabled. To turn it on, go to Settings > General > Background App Refresh"
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    }else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted){
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The functions of this app are limited because the Background App Refresh is disable."
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    } else{
        
        self.locationTracker = [[LocationTracker alloc]init];
        [self.locationTracker startLocationTracking];
        
        //Send the best location to server every 60 seconds
        //You may adjust the time interval depends on the need of your app.
        NSTimeInterval time = 30.0;
        self.locationUpdateTimer =
        [NSTimer scheduledTimerWithTimeInterval:time
                                         target:self
                                       selector:@selector(updateLocation)
                                       userInfo:nil
                                        repeats:YES];
    }
    
   return [[FBSDKApplicationDelegate sharedInstance]application:application didFinishLaunchingWithOptions:launchOptions];
}

-(void)updateLocation {
    NSLog(@"updateLocation");
    
   [self.locationTracker updateLocationToServer:nil];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
   return [[FBSDKApplicationDelegate sharedInstance]application:application
                                                        openURL:url
                                              sourceApplication:sourceApplication
                                                     annotation:annotation];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
