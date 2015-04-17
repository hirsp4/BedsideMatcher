//
//  PrescriptionTableViewCell.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 17.04.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "PrescriptionTableViewCell.h"

@implementation PrescriptionTableViewCell
@synthesize cellNumberLabel=_cellNumberLabel;
@synthesize nameLabel=_nameLabel;
@synthesize descriptionLabel=_descriptionLabel;
@synthesize dateLabel=_dateLabel;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
