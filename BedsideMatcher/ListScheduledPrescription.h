//
//  ListScheduledPrescription.h
//  BedsideMatcher
//
//  Created by Fresh Prince on 22.04.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"
#import "trspPrescription.h"

@interface ListScheduledPrescription : NSObject
@property Patient *patient;
@property trspPrescription *presc;
@end
