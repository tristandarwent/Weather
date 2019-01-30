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

- (City *)buildCityWithName:(NSString *)name responseDict:(NSDictionary *)responseDict {
    
    NSInteger identifier = [[responseDict objectForKey:kKeyIdentifier] integerValue];
    float currentTemp = [[[responseDict objectForKey:@"main"] objectForKey:kKeyCurrentTemp] floatValue];
    
    City *city = [[City alloc] initWithIdentifier:identifier name:name currentTemp:currentTemp];

    return city;
}

@end
