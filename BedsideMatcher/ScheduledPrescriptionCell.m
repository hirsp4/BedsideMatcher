//
//  ScheduledPrescriptionCell.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 21.04.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "ScheduledPrescriptionCell.h"

@implementation ScheduledPrescriptionCell
@synthesize nameLabel=_nameLabel;
@synthesize schemeLabel=_schemeLabel;
@synthesize birthdateLabel=_birthdateLabel;
@synthesize medicationLabel=_medicationLabel;
@synthesize descriptionLabel=_descriptionLabel;
@synthesize patientImage=_patientImage;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
