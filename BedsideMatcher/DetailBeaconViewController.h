//
//  DetailBeaconViewController.h
//  BedsideMatcher
//
//  Created by Fresh Prince on 02.04.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeSnfDevice;

@interface DetailBeaconViewController : UIViewController

@property (strong, nonatomic) LeSnfDevice *theDevice;
- (IBAction)showBeaconTab:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UIButton *cntBtn;
- (IBAction)connectOrDisconnect:(id)sender;
- (IBAction)pageBeacon:(id)sender;
@end
