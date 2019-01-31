//
//  City.m
//  Weather
//
//  Created by Tristan Darwent on 2019-01-29.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import "City.h"

@implementation City

#pragma mark - Initialization

- (id)initWithIdentifier:(NSInteger)identifier name:(NSString *)name currentTemp:(float)currentTemp currentWeatherIconPath:(NSString *)currentWeatherIconPath currentHumidity:(NSInteger)currentHumidity currentPressure:(NSInteger)currentPressure {
    self = [super init];
    
    if (self) {
        self.identifier = identifier;
        self.name = name;
        self.currentTemp = currentTemp;
        self.currentWeatherIconPath = currentWeatherIconPath;
        self.currentHumidity = currentHumidity;
        self.currentPressure = currentPressure;
        
        self.futureWeather = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark - NSCoding

#define kKeyIdentifier @"identifier"
#define kKeyName @"name"
#define kKeyCurrentTemp @"currentTemp"
#define kKeyCurrentWeatherIconPath @"currentWeatherIconPath"
#define kKeyCurrentHumidity @"currentHumidity"
#define kKeyCurrentPressure @"currentPressure"
#define kKeyFutureWeather @"futureWeather"

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[NSNumber numberWithInteger:self.identifier] forKey:kKeyIdentifier];
    [aCoder encodeObject:self.name forKey:kKeyName];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.currentTemp] forKey:kKeyCurrentTemp];
    [aCoder encodeObject:self.currentWeatherIconPath forKey:kKeyCurrentWeatherIconPath];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.currentHumidity] forKey:kKeyCurrentHumidity];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.currentPressure] forKey:kKeyCurrentPressure];
    [aCoder encodeObject:self.futureWeather forKey:kKeyFutureWeather];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSInteger identifier = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:kKeyIdentifier] integerValue];
    NSString *name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kKeyName];
    float currentTemp = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:kKeyCurrentTemp] floatValue];
    NSString *currentWeatherIconPath = [aDecoder decodeObjectOfClass:[NSString class] forKey:kKeyCurrentWeatherIconPath];
    float currentHumidity = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:kKeyCurrentHumidity] integerValue];
    float currentPressure = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:kKeyCurrentPressure] integerValue];
    
    NSSet *codedClasses = [NSSet setWithArray:@[
                                                   [NSMutableArray class],
                                                   [Weather class]
                                                   ]];
    NSMutableArray<Weather *> *futureWeather = [aDecoder decodeObjectOfClasses:codedClasses forKey:kKeyFutureWeather];
    
    City *city = [self initWithIdentifier:identifier name:name currentTemp:currentTemp currentWeatherIconPath:currentWeatherIconPath currentHumidity:currentHumidity currentPressure:currentPressure];
    city.futureWeather = futureWeather;
    
    return city;
}

@end
