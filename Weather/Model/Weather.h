//
//  Weather.h
//  Weather
//
//  Created by Tristan Darwent on 2019-01-30.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Weather : NSObject <NSSecureCoding>

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) float temp;
@property (nonatomic, strong) NSString *weatherIconPath;

- (id)initWithDate:(NSDate *)date temp:(float)temp weatherIconPath:(NSString *)weatherIconPath;

@end

NS_ASSUME_NONNULL_END
