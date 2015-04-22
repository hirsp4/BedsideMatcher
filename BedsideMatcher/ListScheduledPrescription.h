//
//  ListScheduledPrescriptions.h
//  BedsideMatcher
//
//  Object class for a scheduled prescription with corresponding Patient object and trspPrescription
//  object.
//
//  Created by Patrick Hirschi on 22.04.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"
#import "trspPrescription.h"

@interface ListScheduledPrescription : NSObject
@property Patient *patient;
@property trspPrescription *presc;
@end
