//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 23-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

#import "RequestResultHandler.h"
#import "DDXML.h"



@interface mediPrepResult : NSObject <ISerializableObject>


@property (nonatomic,getter=getErrorCode) int errorCode;

@property (nonatomic,getter=getResult) BOOL result;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(RequestResultHandler*) __request;
+(mediPrepResult*) createWithXml:(DDXMLElement*)__node __request:(RequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request;
@end