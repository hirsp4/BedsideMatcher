//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 14-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

#import "RequestResultHandler.h"
#import "DDXML.h"



@interface quantity : NSObject <ISerializableObject>


@property (retain,nonatomic,getter=getDescription) NSString* description;

@property (retain,nonatomic,getter=getGtin) NSString* gtin;

@property (nonatomic,getter=getMinQuantity) int minQuantity;

@property (nonatomic,getter=getOptQuantity) int optQuantity;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(RequestResultHandler*) __request;
+(quantity*) createWithXml:(DDXMLElement*)__node __request:(RequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request;
@end