//
//  CityBuilder.m
//  Weather
//
//  Created by Tristan Darwent on 2019-01-29.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import "CityBuilder.h"

@implementation CityBuilder

#pragma mark - Keys

#define kKeyIdentifier @"id"
#define kKeyCurrentTemp @"temp"
#define kKeyCurrentWeatherIconPath @"icon"
#define kKeyCurrentHumidity @"humidity"
#define kKeyCurrentPressure @"pressure"

#pragma mark - Functions

- (City *)buildCityWithName:(NSString *)name responseDict:(NSDictionary *)responseDict {
    
    NSInteger identifier = [[responseDict objectForKey:kKeyIdentifier] integerValue];
    float currentTemp = [[[responseDict objectForKey:@"main"] objectForKey:kKeyCurrentTemp] floatValue];
    NSString *currentWeatherIconPath = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", [[responseDict objectForKey:@"weather"][0] objectForKey:kKeyCurrentWeatherIconPath]];
    float currentHumidity = [[[responseDict objectForKey:@"main"] objectForKey:kKeyCurrentHumidity] integerValue];
    float currentPressure = [[[responseDict objectForKey:@"main"] objectForKey:kKeyCurrentPressure] integerValue];
    
    City *city = [[City alloc] initWithIdentifier:identifier name:name currentTemp:currentTemp currentWeatherIconPath:currentWeatherIconPath currentHumidity:currentHumidity currentPressure:currentPressure];

    return city;
}

@end
