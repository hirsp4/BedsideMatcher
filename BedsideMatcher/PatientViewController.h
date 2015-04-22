//
//  PatientViewController.h
//  BedsideMatcher
//
//  View controller for the visualization of patient information. The view consists of
//  a segmented controler (general patient information and prescription informations / scanning).
//
//  Created by Patrick Hirschi on 09.04.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingObjC.h"

@interface PatientViewController : UIViewController <ZXCaptureDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *pidLabel;
@property (weak, nonatomic) IBOutlet UILabel *fidLabel;
@property (weak, nonatomic) IBOutlet UILabel *bloodgroupLabel;
@property (weak, nonatomic) IBOutlet UILabel *reaLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;

@property (weak, nonatomic) IBOutlet UIImageView *patientImage;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *birthdate;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *station;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *reastate;
@property (nonatomic, strong) NSString *bloodgroup;
@property (nonatomic, strong) NSString *room;
@property (nonatomic, strong) NSString *caseid;
@property (nonatomic, strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIView *utilityView;
@property (weak, nonatomic) IBOutlet UIView *scanView;
@property (weak, nonatomic) IBOutlet UIView *scanRectView;
@property (nonatomic, strong) ZXCapture *capture;
@property (weak, nonatomic) IBOutlet UILabel *stationLabel;
@property (nonatomic, assign) BOOL hasScannedResult;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *patientView;
@property (weak, nonatomic) IBOutlet UIView *prescriptionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)segmentedValueChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *prescriptionTable;

@end
