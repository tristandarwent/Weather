//
//  AppDelegate.m
//  Weather
//
//  Created by Tristan Darwent on 2019-01-29.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import "AppDelegate.h"
//#import "WebServices.h"
#import "CitiesManager.h"
#import "City.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [[WebServices sharedManager] fetchCityDataWithCoordinates:CLLocationCoordinate2DMake(43.6382846, -79.4161529) name:@"Toronto" success:^(City * _Nonnull city) {
//        NSLog(@"%@", city);
//    } failure:^{
//        // Do nothing
//    }];
    
//    [[CitiesManager sharedManager] clearCities];
    
    City *city1 = [[City alloc] initWithIdentifier:1 name:@"Toronto" currentTemp: 32.3];
    [[[CitiesManager sharedManager] cities] addObject:city1];

    NSLog(@"%ld", [[CitiesManager sharedManager] cities].count);

    [[CitiesManager sharedManager] saveCities];

    for (City *city in [[CitiesManager sharedManager] cities]) {
        NSLog(@"%ld", (long)city.identifier);
        NSLog(@"%@", city.name);
        NSLog(@"%f", city.currentTemp);
    }
    
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
