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
#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailViewController.h"
@import GooglePlaces;

@interface HomeTableViewController () <GMSAutocompleteViewControllerDelegate>

@property (weak, nonatomic) City *selectedCity;

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Remove any empty cells in the tableview
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // Update current weather city data whene app opens
    if ([[CitiesManager sharedManager] cities].count > 0) {
        [self hideTableHeaderView:YES];
        [[CitiesManager sharedManager] updateCities:^{
            [self.tableView reloadData];
        }];
    }
}

// Fetch city data and add it to the CitiesManager
- (void)fetchCityDataWithCoordinates:(CLLocationCoordinate2D)coordinates name:(NSString *)name {
    [[WebServices sharedManager] fetchCityCurrentWeatherWithCoordinates:coordinates name:name success:^(City * _Nonnull city) {
        
        // Make sure city doesn't exist in array already before adding it and reloading data
        if (![[CitiesManager sharedManager] doesCityExistInCities:city.identifier]) {
            [[CitiesManager sharedManager] addCity: city];
            [self.tableView reloadData];
            [self hideTableHeaderView:YES];
        }
    } failure:^{
        UIAlertController *alert = [UIAlertController
                                     alertControllerWithTitle:@"City Not Found"
                                     message:@"We had an issue retrieving weather data for that city."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okayButton = [UIAlertAction
                                    actionWithTitle:@"Okay"
                                    style:UIAlertActionStyleDefault
                                    handler:nil];
        
        [alert addAction:okayButton];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

// Hides/unhides the tableheaderview
- (void)hideTableHeaderView:(BOOL)hide {
    if (hide) {
        self.tableView.tableHeaderView = nil;
    } else {
        self.tableView.tableHeaderView = self.tableHeaderView;
    }
}

#pragma mark - IBActions

// Opens up the Google Places Autocomplete Modal
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
    [cell.currentWeatherIconImgView sd_setImageWithURL:[NSURL URLWithString:city.currentWeatherIconPath]];
    cell.currentHumidityLbl.text = [NSString stringWithFormat:@"%ld%%", (long)city.currentHumidity];
    cell.currentPressureLbl.text = [NSString stringWithFormat:@"%ld hPa", (long)city.currentPressure];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedCity = [[CitiesManager sharedManager] cities][indexPath.row];
    [self performSegueWithIdentifier: @"toDetail" sender: self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toDetail"]) {
        DetailViewController *vc = [segue destinationViewController];
        vc.city = self.selectedCity;
    }
}

#pragma mark - Google Places Autocomplete Delegate

- (void)viewController:(nonnull GMSAutocompleteViewController *)viewController didAutocompleteWithPlace:(nonnull GMSPlace *)place {
    [self fetchCityDataWithCoordinates:place.coordinate name:place.name];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewController:(nonnull GMSAutocompleteViewController *)viewController didFailAutocompleteWithError:(nonnull NSError *)error {
    NSLog(@"Google Places Autocomplete FAILED: %@", error);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)wasCancelled:(nonnull GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
