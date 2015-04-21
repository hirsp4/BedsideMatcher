//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 21-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class trspPrescription;
#import "RequestResultHandler.h"
#import "DDXML.h"



@interface toDoListPrescriptions : NSObject <ISerializableObject>


@property (retain,nonatomic,getter=getScheduldedPrescriptionsEvening) NSMutableArray* scheduldedPrescriptionsEvening;

@property (retain,nonatomic,getter=getScheduldedPrescriptionsMorning) NSMutableArray* scheduldedPrescriptionsMorning;

@property (retain,nonatomic,getter=getScheduldedPrescriptionsNight) NSMutableArray* scheduldedPrescriptionsNight;

@property (retain,nonatomic,getter=getScheduldedPrescriptionsNoon) NSMutableArray* scheduldedPrescriptionsNoon;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(RequestResultHandler*) __request;
+(toDoListPrescriptions*) createWithXml:(DDXMLElement*)__node __request:(RequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request;
@end