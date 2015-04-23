//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 23-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>
#import "DDXMLElement.h"


@interface bloodGroup : NSObject
{
    int value;
    NSString* name;
}

+(bloodGroup*) createWithXml:(DDXMLNode*)node;
+(bloodGroup *)createWithString:(NSString *)value;
-(NSString*) stringValue;
-(NSString*) description;
-(int)getValue;
-(BOOL)isEqualTo:(bloodGroup *)item;
-(void) serialize:(DDXMLNode*)parent;
        
+(bloodGroup *) Apositive;    
+(bloodGroup *) Bpositive;    
+(bloodGroup *) AB;    
+(bloodGroup *) ZeroNegative;    
+(bloodGroup *) ZeroPositive;    
@end