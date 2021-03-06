//
//  CityBuilder.h
//  Weather
//
//  Created by Tristan Darwent on 2019-01-29.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityBuilder : NSObject

- (City *)buildCityWithName:(NSString *)name responseDict:(NSDictionary *)responseDict;

@end

NS_ASSUME_NONNULL_END
