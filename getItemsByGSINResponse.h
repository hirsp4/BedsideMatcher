//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 23-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class webServiceResult;
#import "RequestResultHandler.h"
#import "DDXML.h"



@interface getItemsByGSINResponse : NSObject <ISerializableObject>


@property (retain,nonatomic,getter=get_return) webServiceResult* _return;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(RequestResultHandler*) __request;
+(getItemsByGSINResponse*) createWithXml:(DDXMLElement*)__node __request:(RequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request;
@end