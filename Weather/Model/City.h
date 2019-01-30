//
//  City.h
//  Weather
//
//  Created by Tristan Darwent on 2019-01-29.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface City : NSObject <NSSecureCoding>

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) float currentTemp;
@property (nonatomic, assign) float currentTempHigh;
@property (nonatomic, assign) float currentTempLow;

- (id)initWithIdentifier:(NSInteger)identifier name:(NSString *)name currentTemp:(float)currentTemp currentTempHigh:(float)currentTempHigh currentTempLow:(float)currentTempLow ;

@end

NS_ASSUME_NONNULL_END
