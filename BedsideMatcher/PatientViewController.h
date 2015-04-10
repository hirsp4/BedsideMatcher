//
//  PatientViewController.h
//  BedsideMatcher
//
//  Created by Fresh Prince on 09.04.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingObjC.h"

@interface PatientViewController : UIViewController <ZXCaptureDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *patientImage;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *birthdate;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIView *utilityView;
@property (weak, nonatomic) IBOutlet UIView *scanView;
@property (weak, nonatomic) IBOutlet UIView *scanRectView;
@property (nonatomic, strong) ZXCapture *capture;

@property (strong, nonatomic) IBOutlet UIView *mainView;

@end
