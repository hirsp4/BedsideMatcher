//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 16-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>
#import "DDXMLElement.h"


@interface gender : NSObject
{
    int value;
    NSString* name;
}

+(gender*) createWithXml:(DDXMLNode*)node;
+(gender *)createWithString:(NSString *)value;
-(NSString*) stringValue;
-(NSString*) description;
-(int)getValue;
-(BOOL)isEqualTo:(gender *)item;
-(void) serialize:(DDXMLNode*)parent;
        
+(gender *) male;    
+(gender *) female;    
+(gender *) undefined;    
@end