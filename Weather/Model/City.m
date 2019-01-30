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

- (id)initWithIdentifier:(NSInteger)identifier name:(NSString *)name currentTemp:(float)currentTemp {
    self = [super init];
    
    if (self) {
        self.identifier = identifier;
        self.name = name;
        self.currentTemp = currentTemp;
    }
    
    return self;
}

#pragma mark - NSCoding

#define kKeyIdentifier @"identifier"
#define kKeyName @"name"
#define kKeyCurrentTemp @"currentTemp"

+ (BOOL)supportsSecureCoding{
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[NSNumber numberWithInteger:self.identifier] forKey:kKeyIdentifier];
    [aCoder encodeObject:self.name forKey:kKeyName];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.currentTemp] forKey:kKeyCurrentTemp];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSInteger identifier = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:kKeyIdentifier] integerValue];
    NSString *name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kKeyName];
    float currentTemp = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:kKeyCurrentTemp] floatValue];
    
    return [self initWithIdentifier:identifier name:name currentTemp:currentTemp];
}

@end
