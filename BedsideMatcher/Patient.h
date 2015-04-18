//
//  Patient.h
//  BedsideMatcher
//
//  Managed object class for a patient to store in core data.
//
//  Created by Fresh Prince on 07.04.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Patient : NSManagedObject
@property NSString *gender;
@property NSString *polypointPID;
@property NSString *name;
@property NSString *firstname;
@property NSString *minorid;
@property NSString *birthdate;
@property NSString *station;
@end
