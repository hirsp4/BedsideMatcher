//
//  ListPatient.h
//  BedsideMatcher
//
//  Object class for a patient with corresponding number of open prescriptions.
//
//  Created by Patrick Hirschi on 07.04.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@interface ListPatient : NSObject
@property NSNumber *openPrescriptions;
@property Patient *patient;
@end
