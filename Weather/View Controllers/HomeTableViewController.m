//
//  HomeTableViewController.m
//  Weather
//
//  Created by Tristan Darwent on 2019-01-30.
//  Copyright © 2019 Tristan Darwent. All rights reserved.
//

#import "HomeTableViewController.h"
#import "CitiesManager.h"
#import "CurrentWeatherTableViewCell.h"
#import "WebServices.h"
#import <CoreLocation/CoreLocation.h>
@import GooglePlaces;

@interface HomeTableViewController () <GMSAutocompleteViewControllerDelegate>

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [[CitiesManager sharedManager] updateCities:^{
        [self.tableView reloadData];
    }];
}

- (void)fetchCityDataWithCoordinates:(CLLocationCoordinate2D)coordinates name:(NSString *)name {
    [[WebServices sharedManager] fetchCityCurrentWeatherWithCoordinates:coordinates name:name success:^(City * _Nonnull city) {
        [[CitiesManager sharedManager] addCity: city];
        [self.tableView reloadData];
    } failure:^{
        // Do something
    }];
}

#pragma mark - IBActions

- (IBAction)addCityBtnTapped:(id)sender {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterCity;
    acController.autocompleteFilter = filter;
    
    [self presentViewController:acController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[CitiesManager sharedManager] cities].count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *currentWeatherCellIdentifier = @"Current Weather Cell";
    City *city = [[CitiesManager sharedManager] cities][indexPath.row];
    
    CurrentWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:currentWeatherCellIdentifier forIndexPath:indexPath];
    
    cell.cityNameLbl.text = city.name;
    cell.currentTempLbl.text = [NSString stringWithFormat:@"%.0f°C", city.currentTemp];
    cell.currentTempHighLbl.text = [NSString stringWithFormat:@"%.0f°C", city.currentTempHigh];
    cell.currentTempLowLbl.text = [NSString stringWithFormat:@"%.0f°C", city.currentTempLow];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Google Places Autocomplete Delegate

- (void)viewController:(nonnull GMSAutocompleteViewController *)viewController didAutocompleteWithPlace:(nonnull GMSPlace *)place {
    NSLog(@"DIDAUTOCOMPLETE: %@", place);
    [self fetchCityDataWithCoordinates:place.coordinate name:place.name];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewController:(nonnull GMSAutocompleteViewController *)viewController didFailAutocompleteWithError:(nonnull NSError *)error {
    NSLog(@"DIDFAIL: %@", error);
}

- (void)wasCancelled:(nonnull GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
