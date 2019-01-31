//
//  CitiesManager.m
//  Weather
//
//  Created by Tristan Darwent on 2019-01-29.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import "CitiesManager.h"
#import "WebServices.h"

@implementation CitiesManager

#pragma mark - Initialization

+ (CitiesManager *)sharedManager {
    static CitiesManager *sharedManager = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[CitiesManager alloc] init];
    });
    return sharedManager;
}

- (id)init {
    if ((self = [super init])) {
        [self loadCities];
    }
    return self;
}

#pragma mark - Saving/Loading

#define kKeyCities @"cities"

// Save the cities array locally
- (void)saveCities {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:_cities requiringSecureCoding:YES error:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:kKeyCities];
    [defaults synchronize];
}

// Load cities array stored locally
- (void)loadCities {
    NSSet *archivedClasses = [NSSet setWithArray:@[
                                       [NSMutableArray class],
                                       [City class]
    ]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:kKeyCities];
    NSMutableArray *cities = [NSKeyedUnarchiver unarchivedObjectOfClasses:archivedClasses fromData:encodedObject error:nil];
    
    // If no cities array exists saved locally, initialize an empty cities array
    if (cities != nil) {
        self.cities = cities;
    } else {
        self.cities = [[NSMutableArray alloc] init];
    }
}

#pragma mark - Functions

// Add a city to the cities array
- (void)addCity:(City *)city {
    [self.cities addObject:city];
    [self saveCities];
}

// Checks to see if a city with the passed identifier already exists in the array
- (BOOL)doesCityExistInCities:(NSInteger)identifier {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %ld", (long)identifier];
    NSArray *filteredArray = [self.cities filteredArrayUsingPredicate:predicate];
    
    if (filteredArray.count > 0) {
        return YES;
    } else {
        return NO;
    }
}

// Runs through all the existing cities in the array and updates their data from the API (not including future weather data)
- (void)updateCities:(void (^)(void))completion {
    __block int completed = 0;
    
    for (City *oldCity in self.cities) {
        [[WebServices sharedManager] fetchCityCurrentWeatherWithIdentifier:oldCity.identifier name:oldCity.name success:^(City *city) {
            
            // Replace the old city data with the updated one, making sure to keep any future weather data from the old one
            NSUInteger index = [self.cities indexOfObjectIdenticalTo:oldCity];
            if (index != NSNotFound) {
                City *updatedCity = city;
                city.futureWeather = oldCity.futureWeather;
                [self.cities replaceObjectAtIndex:index withObject:updatedCity];
            }
            
            // If all cities are updated, save the array locally
            completed++;
            if (completed == self.cities.count) {
                [self saveCities];
                completion();
            }
        } failure:^{
            // If all cities are updated, even if some failed, save the array locally
            completed++;
            if (completed == self.cities.count) {
                [self saveCities];
                completion();
            }
        }];
    }
}

// Download any future weather forecast data from the API and update it into the city object.
- (void)updateCityWithFutureWeatherWithCity:(City *)city completion:(void (^)(City *city))completion {
    [[WebServices sharedManager] fetchCityFutureWeatherWithCity:city success:^(City * _Nonnull updatedCity) {
        
        // Replace the old city data with the updated one with new future weather data and save the cities array
        NSUInteger index = [self.cities indexOfObjectIdenticalTo:city];
        if (index != NSNotFound) {
            [self.cities replaceObjectAtIndex:index withObject:updatedCity];
            [self saveCities];
        }
        completion(updatedCity);
    } failure:^{
        // Send the old city data on completion if something went wrong
        completion(city);
    }];
}

@end
