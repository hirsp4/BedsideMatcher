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



@interface getProductForSecondaryPackage : NSObject <ISerializableObject>


@property (retain,nonatomic,getter=getArg0) NSString* arg0;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(RequestResultHandler*) __request;
+(getProductForSecondaryPackage*) createWithXml:(DDXMLElement*)__node __request:(RequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request;
@end