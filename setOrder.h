//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 23-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class order;
#import "RequestResultHandler.h"
#import "DDXML.h"



@interface setOrder : NSObject <ISerializableObject>


@property (retain,nonatomic,getter=getArg0) order* arg0;

@property (retain,nonatomic,getter=getArg1) NSString* arg1;

@property (retain,nonatomic,getter=getArg2) NSString* arg2;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(RequestResultHandler*) __request;
+(setOrder*) createWithXml:(DDXMLElement*)__node __request:(RequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request;
@end