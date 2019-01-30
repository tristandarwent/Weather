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

- (id)initWithIdentifier:(NSInteger)identifier name:(NSString *)name currentTemp:(float)currentTemp currentTempHigh:(float)currentTempHigh currentTempLow:(float)currentTempLow {
    self = [super init];
    
    if (self) {
        
        NSLog(@"NAME6: %@", name);
        self.identifier = identifier;
        self.name = name;
        self.currentTemp = currentTemp;
        self.currentTempHigh = currentTempHigh;
        self.currentTempLow = currentTempLow;
        NSLog(@"NAME7: %@", self.name);
    }
    
    return self;
}

#pragma mark - NSCoding

#define kKeyIdentifier @"identifier"
#define kKeyName @"name"
#define kKeyCurrentTemp @"currentTemp"
#define kKeyCurrentTempHigh @"currentTempHigh"
#define kKeyCurrentTempLow @"currentTempLow"

+ (BOOL)supportsSecureCoding{
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSLog(@"NAME8: %@", self.name);
    [aCoder encodeObject:[NSNumber numberWithInteger:self.identifier] forKey:kKeyIdentifier];
    [aCoder encodeObject:self.name forKey:kKeyName];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.currentTemp] forKey:kKeyCurrentTemp];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.currentTempHigh] forKey:kKeyCurrentTempHigh];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.currentTempLow] forKey:kKeyCurrentTempLow];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSInteger identifier = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:kKeyIdentifier] integerValue];
    NSString *name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kKeyName];
    float currentTemp = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:kKeyCurrentTemp] floatValue];
    float currentTempHigh = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:kKeyCurrentTempHigh] floatValue];
    float currentTempLow = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:kKeyCurrentTempLow] floatValue];
    
    NSLog(@"NAME9: %@", name);
    
    return [self initWithIdentifier:identifier name:name currentTemp:currentTemp currentTempHigh:currentTempHigh currentTempLow:currentTempLow];
}

@end
