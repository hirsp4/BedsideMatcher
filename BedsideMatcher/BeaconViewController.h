//
//  BeaconViewController.h
//  BedsideMatcher
//
//  Created by Fresh Prince on 11.03.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "ViewController.h"

@interface BeaconViewController : ViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableViewBeacon;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBarBeacon;

@end
