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
@property (weak, nonatomic) NSString *name;
@property (nonatomic, assign) float currentTemp;

- (id)initWithIdentifier:(NSInteger)identifier name:(NSString *)name currentTemp:(float)currentTemp;

@end

NS_ASSUME_NONNULL_END
