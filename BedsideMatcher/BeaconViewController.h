//
//  BeaconViewController.h
//  BedsideMatcher
//
//  Created by Fresh Prince on 11.03.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "ViewController.h"

@import CoreLocation;
@import CoreBluetooth;

@interface BeaconViewController : UIViewController <CLLocationManagerDelegate, CBPeripheralManagerDelegate,
UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *beaconTableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBarBeacon;

@end
