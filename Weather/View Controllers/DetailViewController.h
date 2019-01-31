//
//  DetailViewController.h
//  Weather
//
//  Created by Tristan Darwent on 2019-01-30.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (weak, nonatomic) City *city;

@property (weak, nonatomic) IBOutlet UILabel *cityNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLbl;
@property (weak, nonatomic) IBOutlet UIImageView *currentWeatherIconImgView;
@property (weak, nonatomic) IBOutlet UILabel *currentHumidityLbl;
@property (weak, nonatomic) IBOutlet UILabel *currentPressureLbl;

@end

NS_ASSUME_NONNULL_END
