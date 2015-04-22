//
//  PrescriptionTableViewCell.m
//  BedsideMatcher
//
//  Cell to display a prescription of a patient. Inherits from UITableViewCell.
//
//  Created by Patrick Hirschi on 17.04.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "PrescriptionTableViewCell.h"

@implementation PrescriptionTableViewCell
@synthesize cellNumberLabel=_cellNumberLabel;
@synthesize nameLabel=_nameLabel;
@synthesize descriptionLabel=_descriptionLabel;
@synthesize dateLabel=_dateLabel;
@synthesize infoButton=_infoButton;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
