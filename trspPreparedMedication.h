//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 23-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class trspPrescription;
@class trspPatient;
@class medicationState;
#import "trspMedication.h"
#import "RequestResultHandler.h"
#import "DDXML.h"



@interface trspPreparedMedication : trspMedication <ISerializableObject>


@property (retain,nonatomic,getter=getBasedOnPrescription) trspPrescription* basedOnPrescription;

@property (retain,nonatomic,getter=getBatchLot) NSString* batchLot;

@property (retain,nonatomic,getter=getExpiryDate) NSString* expiryDate;

@property (retain,nonatomic,getter=getForPatient) trspPatient* forPatient;

@property (retain,nonatomic,getter=getGtinFromAssignedItem) NSString* gtinFromAssignedItem;

@property (nonatomic,getter=getIsReserve) BOOL isReserve;

@property (retain,nonatomic,getter=getPreparationTime) NSString* preparationTime;

@property (nonatomic,getter=getPreparedMedicationId) int preparedMedicationId;

@property (retain,nonatomic,getter=getSerial) NSString* serial;

@property (retain,nonatomic,getter=getStaffGln) NSString* staffGln;

@property (retain,nonatomic,getter=getState) medicationState* state;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(RequestResultHandler*) __request;
+(trspPreparedMedication*) createWithXml:(DDXMLElement*)__node __request:(RequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request;
@end