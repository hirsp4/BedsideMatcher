//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.2
//
// Created by Quasar Development at 10-03-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class NIVitem;
#import "NIVRequestResultHandler.h"
#import "DDXML.h"



@interface NIVinsertTrackingItems : NSObject <NIVISerializableObject>


@property (retain,nonatomic,getter=getArg0) NSMutableArray* arg0;

@property (retain,nonatomic,getter=getArg1) NSString* arg1;

@property (retain,nonatomic,getter=getArg2) NSNumber* arg2;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(NIVRequestResultHandler*) __request;
+(NIVinsertTrackingItems*) createWithXml:(DDXMLElement*)__node __request:(NIVRequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(NIVRequestResultHandler*) __request;
@end