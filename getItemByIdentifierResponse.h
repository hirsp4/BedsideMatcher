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



@interface getItemByIdentifierResponse : NSObject <ISerializableObject>


@property (retain,nonatomic,getter=get_return) item* _return;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(RequestResultHandler*) __request;
+(getItemByIdentifierResponse*) createWithXml:(DDXMLElement*)__node __request:(RequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request;
@end