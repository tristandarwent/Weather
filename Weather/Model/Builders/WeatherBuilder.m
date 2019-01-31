//
//  WeatherBuilder.m
//  Weather
//
//  Created by Tristan Darwent on 2019-01-31.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import "WeatherBuilder.h"

@implementation WeatherBuilder

#pragma mark - Keys

#define kKeyDate @"dt"
#define kKeyTemp @"temp"
#define kKeyWeatherIconPath @"icon"

#pragma mark - Functions

- (NSMutableArray<Weather *> *)buildWeatherArrayWithResponseDict:(NSDictionary *)responseDict {
    NSMutableArray<Weather *> *weatherArray = [[NSMutableArray alloc] init];
    
    NSArray *listArray = [responseDict objectForKey:@"list"];
    
    for (NSDictionary *listItem in listArray) {
        Weather *weather = [self buildWeatherWithDictionary:listItem];
        if (weather != nil) {
            [weatherArray addObject:weather];
        }
    }
    
    return weatherArray;
}

- (Weather *)buildWeatherWithDictionary:(NSDictionary *)dictionary {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[dictionary objectForKey:kKeyDate] integerValue]];
    float temp = [[[dictionary objectForKey:@"main"] objectForKey:kKeyTemp] floatValue];
    NSString *weatherIconPath = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", [[dictionary objectForKey:@"weather"][0] objectForKey:kKeyWeatherIconPath]];
    
    Weather *weather = [[Weather alloc] initWithDate:date temp:temp weatherIconPath:weatherIconPath];
    
    return weather;
}

@end
