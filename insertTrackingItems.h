//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 21-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class item;
#import "RequestResultHandler.h"
#import "DDXML.h"



@interface insertTrackingItems : NSObject <ISerializableObject>


@property (retain,nonatomic,getter=getArg0) NSMutableArray* arg0;

@property (retain,nonatomic,getter=getArg1) NSString* arg1;

@property (retain,nonatomic,getter=getArg2) NSNumber* arg2;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(RequestResultHandler*) __request;
+(insertTrackingItems*) createWithXml:(DDXMLElement*)__node __request:(RequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request;
@end