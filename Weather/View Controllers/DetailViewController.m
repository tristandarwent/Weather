//
//  DetailViewController.m
//  Weather
//
//  Created by Tristan Darwent on 2019-01-30.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.city != nil) {
        [self setUpCurrentWeatherUI];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setUpCurrentWeatherUI {
    self.cityNameLbl.text = self.city.name;
    self.currentTempLbl.text = [NSString stringWithFormat:@"%.0f°C", self.city.currentTemp];
    [self.currentWeatherIconImgView sd_setImageWithURL:[NSURL URLWithString:self.city.currentWeatherIconPath]];
    self.currentHumidityLbl.text = [NSString stringWithFormat:@"%ld%%", (long)self.city.currentHumidity];
    self.currentPressureLbl.text = [NSString stringWithFormat:@"%ld hPa", (long)self.city.currentPressure];
}

@end