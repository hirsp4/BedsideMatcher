//
//  TableViewCellVerordnung.m
//  BedsideMatcher
//
//  Cell to display a patient with corresponding open prescriptions count. Inherits from UITableViewCell.
//
//  Created by Patrizia Zehnder on 02.04.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "TableViewCellVerordnung.h"

@implementation TableViewCellVerordnung

@synthesize nameLabel=_nameLabel;
@synthesize patientImage=_patientImage;
@synthesize birthdateLabel=_birthdateLabel;
@synthesize prescriptionNbLabel=_prescriptionNbLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
