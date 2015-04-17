//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 16-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

#import "RequestResultHandler.h"
#import "DDXML.h"



@interface shipment : NSObject <ISerializableObject>


@property (retain,nonatomic,getter=getDescDestination) NSString* descDestination;

@property (retain,nonatomic,getter=getDescOrigin) NSString* descOrigin;

@property (retain,nonatomic,getter=getGlnDestination) NSString* glnDestination;

@property (retain,nonatomic,getter=getGlnOrigin) NSString* glnOrigin;

@property (retain,nonatomic,getter=getGsin) NSString* gsin;

@property (retain,nonatomic,getter=getOrderNr) NSString* orderNr;

@property (retain,nonatomic,getter=getSscc) NSString* sscc;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(RequestResultHandler*) __request;
+(shipment*) createWithXml:(DDXMLElement*)__node __request:(RequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request;
@end