//
//  BeaconTableViewCell.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 02.04.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "BeaconTableViewCell.h"

@implementation BeaconTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
