//
//  PrescriptionTableViewCell.h
//  BedsideMatcher
//
//  Cell to display a prescription of a patient. Inherits from UITableViewCell.
//
//  Created by Patrick Hirschi on 17.04.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrescriptionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@end
