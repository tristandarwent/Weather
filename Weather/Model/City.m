//
//  City.m
//  Weather
//
//  Created by Tristan Darwent on 2019-01-29.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import "City.h"

@implementation City

- (id)initWithIdentifier:(NSInteger)identifier name:(NSString *)name currentTemp:(float)currentTemp {
    self = [super init];
    
    if (self) {
        self.identifier = identifier;
        self.name = name;
        self.currentTemp = currentTemp;
    }
    
    return self;
}

@end
