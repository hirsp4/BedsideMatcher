//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 16-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class trspPatient;
#import "RequestResultHandler.h"
#import "DDXML.h"



@interface getPatientByPidResponse : NSObject <ISerializableObject>


@property (retain,nonatomic,getter=get_return) trspPatient* _return;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(RequestResultHandler*) __request;
+(getPatientByPidResponse*) createWithXml:(DDXMLElement*)__node __request:(RequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request;
@end