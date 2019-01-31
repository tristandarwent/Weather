//
//  WeatherBuilder.h
//  Weather
//
//  Created by Tristan Darwent on 2019-01-31.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherBuilder : NSObject

- (NSMutableArray<Weather *> *)buildWeatherArrayWithResponseDict:(NSDictionary *)responseDict;
- (Weather *)buildWeatherWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
