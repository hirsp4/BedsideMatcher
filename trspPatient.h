//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 16-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class bloodGroup;
@class gender;
#import "RequestResultHandler.h"
#import "DDXML.h"



@interface trspPatient : NSObject <ISerializableObject>


@property (retain,nonatomic,getter=getBeaconID) NSString* beaconID;

@property (retain,nonatomic,getter=getBirthDate) NSString* birthDate;

@property (retain,nonatomic,getter=getBloodGroup) bloodGroup* bloodGroup;

@property (nonatomic,getter=getFid) int fid;

@property (retain,nonatomic,getter=getFirstname) NSString* firstname;

@property (retain,nonatomic,getter=getGender) gender* gender;

@property (retain,nonatomic,getter=getLastname) NSString* lastname;

@property (nonatomic,getter=getPid) int pid;

@property (nonatomic,getter=getReaState) BOOL reaState;

@property (retain,nonatomic,getter=getRoom) NSString* room;

@property (retain,nonatomic,getter=getStationName) NSString* stationName;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(RequestResultHandler*) __request;
+(trspPatient*) createWithXml:(DDXMLElement*)__node __request:(RequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request;
@end