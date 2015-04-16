//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 16-04-2015
//
//---------------------------------------------------


#import "Helper.h"
#import "station.h"


@implementation station
@synthesize gln;
@synthesize name;

+ (station *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(RequestResultHandler*) __request{
    if(self = [self init])
    {
        if([Helper hasValue:__node name:@"gln" index:0])
        {
            self.gln = [[Helper getNode:__node name:@"gln" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"name" index:0])
        {
            self.name = [[Helper getNode:__node name:@"name" index:0] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request
{

             
    DDXMLElement* __glnItemElement=[__request writeElement:gln type:[NSString class] name:@"gln" URI:@"" parent:__parent skipNullProperty:YES];
    if(__glnItemElement!=nil)
    {
        [__glnItemElement setStringValue:self.gln];
    }
             
    DDXMLElement* __nameItemElement=[__request writeElement:name type:[NSString class] name:@"name" URI:@"" parent:__parent skipNullProperty:YES];
    if(__nameItemElement!=nil)
    {
        [__nameItemElement setStringValue:self.name];
    }


}
@end
