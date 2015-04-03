//
//  BeaconTableViewCell.h
//  BedsideMatcher
//
//  Created by Fresh Prince on 02.04.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface BeaconTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *distLbl;
@property (weak, nonatomic) IBOutlet UILabel *rssiLbl;

@end
