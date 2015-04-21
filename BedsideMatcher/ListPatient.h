//
//  ListPatient.h
//  BedsideMatcher
//
//  Created by Fresh Prince on 21.04.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@interface ListPatient : NSObject
@property NSNumber *openPrescriptions;
@property Patient *patient;
@end
