//
//  Weather.m
//  Weather
//
//  Created by Tristan Darwent on 2019-01-30.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import "Weather.h"

@implementation Weather

#pragma mark - Initialization

- (id)initWithDate:(NSDate *)date temp:(float)temp weatherIconPath:(NSString *)weatherIconPath {
    self = [super init];
    
    if (self) {
        self.date = date;
        self.temp = temp;
        self.weatherIconPath = weatherIconPath;
    }
    
    return self;
}

#pragma mark - NSCoding

#define kKeyDate @"date"
#define kKeyTemp @"temp"
#define kKeyWeatherIconPath @"weatherIconPath"

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.date forKey:kKeyDate];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.temp] forKey:kKeyTemp];
    [aCoder encodeObject:self.weatherIconPath forKey:kKeyWeatherIconPath];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSDate *date = [aDecoder decodeObjectOfClass:[NSDate class] forKey:kKeyDate];
    float temp = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:kKeyTemp] floatValue];
    NSString *weatherIconPath = [aDecoder decodeObjectOfClass:[NSString class] forKey:kKeyWeatherIconPath];
    

    return [self initWithDate:date temp:temp weatherIconPath:weatherIconPath];
}

@end
