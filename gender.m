//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 23-04-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>
    
#import "gender.h"

@implementation gender

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

-(BOOL) isEqualTo:(gender *)item
{
    return [name isEqualToString:item->name];
}
   
-(void) serialize:(DDXMLNode*)parent
{
    [parent setStringValue:name];
}
     
+(gender*) male
{
    static gender* obj=nil;
    if(!obj)
    {
        obj=[[gender alloc] initWithEnum: @"male" value: 0];
    }
    return obj;
} 
+(gender*) female
{
    static gender* obj=nil;
    if(!obj)
    {
        obj=[[gender alloc] initWithEnum: @"female" value: 1];
    }
    return obj;
} 
+(gender*) undefined
{
    static gender* obj=nil;
    if(!obj)
    {
        obj=[[gender alloc] initWithEnum: @"undefined" value: 2];
    }
    return obj;
} 
    
+ (gender *)createWithXml:(DDXMLNode *)node
{
    return [gender createWithString:[node stringValue]];
}
    
+ (gender *)createWithString:(NSString *)value
{
    if([value isEqualToString:@"female"])
    {
        return [gender female];
    }
    if([value isEqualToString:@"undefined"])
    {
        return [gender undefined];
    }
    return [gender male];   
}
    

@end
