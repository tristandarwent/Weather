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
//        self.httpSessionManager = [AFHTTPSessionManager manager];
//        self.cities = [[NSMutableArray alloc] init];
        [self loadCities];
    }
    return self;
}

#pragma mark - Saving/Loading

#define kKeyCities @"cities"

- (void)saveCities {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:_cities requiringSecureCoding:YES error:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:kKeyCities];
    [defaults synchronize];
}

- (void)loadCities {
    NSSet *archivedClasses = [NSSet setWithArray:@[
                                       [NSMutableArray class],
                                       [City class]
    ]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:kKeyCities];
    NSMutableArray *cities = [NSKeyedUnarchiver unarchivedObjectOfClasses:archivedClasses fromData:encodedObject error:nil];
    
    if (cities != nil) {
        self.cities = cities;
    } else {
        self.cities = [[NSMutableArray alloc] init];
    }
}

- (void)clearCities {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kKeyCities];
    [defaults synchronize];
}

#pragma mark - Functions

- (void)addCity:(City *)city {
    [self.cities addObject:city];
    [self saveCities];
}

- (BOOL)doesCityExistInCities:(NSInteger)identifier {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %ld", (long)identifier];
    NSArray *filteredArray = [self.cities filteredArrayUsingPredicate:predicate];
    
    if (filteredArray.count > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)updateCities:(void (^)(void))completion {
    __block int completed = 0;
    
    for (City *oldCity in self.cities) {
        [[WebServices sharedManager] fetchCityCurrentWeatherWithIdentifier:oldCity.identifier name:oldCity.name success:^(City *city) {
            
            NSUInteger index = [self.cities indexOfObjectIdenticalTo:oldCity];
            if (index != NSNotFound) {
                [self.cities replaceObjectAtIndex:index withObject:city];
            }
            
            completed++;
            if (completed == self.cities.count) {
                [self saveCities];
                completion();
            }
        } failure:^{
            completed++;
            if (completed == self.cities.count) {
                [self saveCities];
                completion();
            }
        }];
    }
}

@end
