//
//  WebServices.m
//  Weather
//
//  Created by Tristan Darwent on 2019-01-29.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import "WebServices.h"

@implementation WebServices

#pragma mark - Variables

static NSString * const openWeatherMapApiKey = @"4b0f1660a6c76013436a53a221591b23";
static NSString * const openWeatherBaseUrl = @"http://api.openweathermap.org/data/2.5/";

#pragma mark - Initialization

+ (WebServices*)sharedManager {
    static WebServices *sharedManager = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[WebServices alloc] init];
    });
    return sharedManager;
}

- (id)init {
    if ((self = [super init])) {
        self.httpSessionManager = [AFHTTPSessionManager manager];
    }
    return self;
}

#pragma mark - Requests

// Get current weather data using coordinates and build a City object with it. (Name from GooglePlaces search being passed and used for sake of consistency.
- (void)fetchCityCurrentWeatherWithCoordinates:(CLLocationCoordinate2D)coordinates name:(NSString *)name success:(void (^)(City *city))success failure:(void (^)(void))failure {
    
    NSString *url = [NSString stringWithFormat:@"%@weather", openWeatherBaseUrl];
    
    NSString *latString = [NSString stringWithFormat:@"%f", coordinates.latitude];
    NSString *longString = [NSString stringWithFormat:@"%f", coordinates.longitude];

    NSDictionary *params = @{
                             @"lat":latString,
                             @"lon":longString,
                             @"units":@"metric",
                             @"appid":openWeatherMapApiKey
                             };

    [self.httpSessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = responseObject;
            CityBuilder *builder = [CityBuilder new];
            City *city = [builder buildCityWithName:name responseDict:responseDict];
            success(city);
        } else {
            failure();
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"WebServices FAILED: fetchCityCurrentWeatherWithCoordinates: %@", error);
        failure();
    }];
}

// Get current weather data using city identifier and create a city object with it.
- (void)fetchCityCurrentWeatherWithIdentifier:(NSInteger)identifier name:(NSString *)name success:(void (^)(City *city))success failure:(void (^)(void))failure {
    
    NSString *url = [NSString stringWithFormat:@"%@weather", openWeatherBaseUrl];
    
    NSDictionary *params = @{
                             @"id":[NSNumber numberWithInteger:identifier],
                             @"units":@"metric",
                             @"appid":openWeatherMapApiKey
                             };
    
    [self.httpSessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = responseObject;
            CityBuilder *builder = [CityBuilder new];
            City *city = [builder buildCityWithName:name responseDict:responseDict];
            success(city);
        } else {
            failure();
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"WebServices FAILED: fetchCityCurrentWeatherWithIdentifier: %@", error);
        failure();
    }];
}

// Get the future weather forecast data for a city and return it within it's city object.
- (void)fetchCityFutureWeatherWithCity:(City *)city success:(void (^)(City *city))success failure:(void (^)(void))failure {
    
    NSString *url = [NSString stringWithFormat:@"%@forecast", openWeatherBaseUrl];
    
    NSDictionary *params = @{
                             @"id":[NSNumber numberWithInteger:city.identifier],
                             @"units":@"metric",
                             @"appid":openWeatherMapApiKey
                             };
    
    [self.httpSessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = responseObject;
            WeatherBuilder *builder = [WeatherBuilder new];
            NSMutableArray<Weather *> *futureWeather = [builder buildWeatherArrayWithResponseDict:responseDict];
            
            City *updatedCity = city;
            updatedCity.futureWeather = futureWeather;
            
            success(city);
        } else {
            failure();
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"WebServices FAILED: fetchCityFutureWeatherWithCity: %@", error);
        failure();
    }];
}

@end
