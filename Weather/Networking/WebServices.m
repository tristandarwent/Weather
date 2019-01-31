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
//        [self.httpSessionManager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
//        [_httpSessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", openWeatherMapApiKey] forHTTPHeaderField:@"Authorization"];
    }
    return self;
}

#pragma mark - Requests

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
            NSLog(@"%@", responseObject);
            
            NSDictionary *responseDict = responseObject;
            CityBuilder *builder = [CityBuilder new];
            City *city = [builder buildCityWithName:name responseDict:responseDict];
            success(city);
        } else {
            failure();
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
}

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
        NSLog(@"%@", error);
        failure();
    }];
}

@end
