//
//  CurrentWeatherTableViewCell.h
//  Weather
//
//  Created by Tristan Darwent on 2019-01-30.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CurrentWeatherTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLbl;

@end

NS_ASSUME_NONNULL_END
