//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 16-04-2015
//
//---------------------------------------------------


#import "Helper.h"
#import "getCheckedInItems.h"


@implementation getCheckedInItems
@synthesize arg0;

+ (getCheckedInItems *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
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
        if([Helper hasValue:__node name:@"arg0" index:0])
        {
            self.arg0 = [[Helper getNode:__node name:@"arg0" index:0] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request
{

             
    DDXMLElement* __arg0ItemElement=[__request writeElement:arg0 type:[NSString class] name:@"arg0" URI:@"" parent:__parent skipNullProperty:YES];
    if(__arg0ItemElement!=nil)
    {
        [__arg0ItemElement setStringValue:self.arg0];
    }


}
@end
