//
//  FutureWeatherTableViewCell.h
//  Weather
//
//  Created by Tristan Darwent on 2019-01-31.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FutureWeatherTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIconImgView;
@property (weak, nonatomic) IBOutlet UILabel *tempLbl;

@end

NS_ASSUME_NONNULL_END
