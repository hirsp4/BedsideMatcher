//
//  ScheduledPrescriptionCell.h
//  BedsideMatcher
//
//  Cell to display a scheduled prescription for a patient. Inherits from UITableViewCell.
//
//  Created by Patrick Hirschi on 21.04.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduledPrescriptionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schemeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *patientImage;
@property (weak, nonatomic) IBOutlet UILabel *medicationLabel;

@end
