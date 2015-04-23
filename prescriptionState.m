//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 23-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>
    
#import "prescriptionState.h"

@implementation prescriptionState

-(id) initWithEnum:(NSString*)itemName value:(int) itemValue
{
    if(self = [super init])
    {
        self->name=itemName;
        self->value=itemValue;
    }
    return self;
}

-(NSString*) stringValue
{
    return name;
}
    
-(NSString*) description
{
    return name;
}

-(int) getValue
{
    return value;
}

-(BOOL) isEqualTo:(prescriptionState *)item
{
    return [name isEqualToString:item->name];
}
   
-(void) serialize:(DDXMLNode*)parent
{
    [parent setStringValue:name];
}
     
+(prescriptionState*) open
{
    static prescriptionState* obj=nil;
    if(!obj)
    {
        obj=[[prescriptionState alloc] initWithEnum: @"open" value: 0];
    }
    return obj;
} 
+(prescriptionState*) paused
{
    static prescriptionState* obj=nil;
    if(!obj)
    {
        obj=[[prescriptionState alloc] initWithEnum: @"paused" value: 1];
    }
    return obj;
} 
+(prescriptionState*) stopped
{
    static prescriptionState* obj=nil;
    if(!obj)
    {
        obj=[[prescriptionState alloc] initWithEnum: @"stopped" value: 2];
    }
    return obj;
} 
+(prescriptionState*) doseChanged
{
    static prescriptionState* obj=nil;
    if(!obj)
    {
        obj=[[prescriptionState alloc] initWithEnum: @"doseChanged" value: 3];
    }
    return obj;
} 
    
+ (prescriptionState *)createWithXml:(DDXMLNode *)node
{
    return [prescriptionState createWithString:[node stringValue]];
}
    
+ (prescriptionState *)createWithString:(NSString *)value
{
    if([value isEqualToString:@"paused"])
    {
        return [prescriptionState paused];
    }
    if([value isEqualToString:@"stopped"])
    {
        return [prescriptionState stopped];
    }
    if([value isEqualToString:@"doseChanged"])
    {
        return [prescriptionState doseChanged];
    }
    return [prescriptionState open];   
}
    

@end
