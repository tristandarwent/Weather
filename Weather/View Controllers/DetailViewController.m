//
//  DetailViewController.m
//  Weather
//
//  Created by Tristan Darwent on 2019-01-30.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FutureWeatherTableViewCell.h"

@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property NSDateFormatter *dateFormatter;
@property NSDateFormatter *timeFormatter;

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

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.timeFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"EEE d"];
    [self.timeFormatter setDateFormat:@"h:mm a"];
    
    [[CitiesManager sharedManager] updateCityWithFutureWeatherWithCity:self.city completion:^(City * _Nonnull city) {
        self.city = city;
        [self.tableView reloadData];
    }];
}

- (void)setUpCurrentWeatherUI {
    self.cityNameLbl.text = self.city.name;
    self.currentTempLbl.text = [NSString stringWithFormat:@"%.0f°C", self.city.currentTemp];
    [self.currentWeatherIconImgView sd_setImageWithURL:[NSURL URLWithString:self.city.currentWeatherIconPath]];
    self.currentHumidityLbl.text = [NSString stringWithFormat:@"%ld%%", (long)self.city.currentHumidity];
    self.currentPressureLbl.text = [NSString stringWithFormat:@"%ld hPa", (long)self.city.currentPressure];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.city.futureWeather.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    static NSString *futureWeatherCellIdentifier = @"Future Weather Cell";
    Weather *weather = self.city.futureWeather[indexPath.row];
    FutureWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:futureWeatherCellIdentifier forIndexPath:indexPath];
    
    cell.dateLbl.text = [self.dateFormatter stringFromDate:weather.date];
    cell.timeLbl.text = [self.timeFormatter stringFromDate:weather.date];
    
    [cell.weatherIconImgView sd_setImageWithURL:[NSURL URLWithString:weather.weatherIconPath]];
    cell.tempLbl.text = [NSString stringWithFormat:@"%.0f°C", weather.temp];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
