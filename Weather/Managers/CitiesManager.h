//
//  CitiesManager.h
//  Weather
//
//  Created by Tristan Darwent on 2019-01-29.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"

NS_ASSUME_NONNULL_BEGIN

@interface CitiesManager : NSObject

@property (strong, nonatomic) NSMutableArray<City *> *cities;

+ (id)sharedManager;

- (void)saveCities;
- (void)clearCities;
- (void)addCity:(City *)city;
- (void)updateCities:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
