//
//  WebServices.h
//  Weather
//
//  Created by Tristan Darwent on 2019-01-29.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebServices : NSObject

@property AFHTTPSessionManager *httpSessionManager;

+ (id)sharedManager;

- (void)fetchWeatherData:(CLLocationCoordinate2D)coordinates;

@end

NS_ASSUME_NONNULL_END
