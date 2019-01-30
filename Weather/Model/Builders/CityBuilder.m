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
#define kKeyCurrentTempHigh @"temp_max"
#define kKeyCurrentTempLow @"temp_min"


- (City *)buildCityWithName:(NSString *)name responseDict:(NSDictionary *)responseDict {
    
    NSInteger identifier = [[responseDict objectForKey:kKeyIdentifier] integerValue];
    float currentTemp = [[[responseDict objectForKey:@"main"] objectForKey:kKeyCurrentTemp] floatValue];
    float currentTempHigh = [[[responseDict objectForKey:@"main"] objectForKey:kKeyCurrentTempHigh] floatValue];
    float currentTempLow = [[[responseDict objectForKey:@"main"] objectForKey:kKeyCurrentTempLow] floatValue];
    
    City *city = [[City alloc] initWithIdentifier:identifier name:name currentTemp:currentTemp currentTempHigh:currentTempHigh currentTempLow:currentTempLow];

    return city;
}

@end
