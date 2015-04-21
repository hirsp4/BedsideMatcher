//
//  TableViewCellVerordnung.h
//  BedsideMatcher
//
//  Created by Patrizia Zehnder on 02/04/15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellVerordnung : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *patientImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *birthdateLabel;

@property (weak, nonatomic) IBOutlet UILabel *prescriptionNbLabel;

@end
