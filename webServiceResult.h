//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 23-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class item;
#import "RequestResultHandler.h"
#import "DDXML.h"



@interface webServiceResult : NSObject <ISerializableObject>


@property (retain,nonatomic,getter=getItems) NSMutableArray* items;

@property (nonatomic,getter=getResult) BOOL result;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(RequestResultHandler*) __request;
+(webServiceResult*) createWithXml:(DDXMLElement*)__node __request:(RequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request;
@end