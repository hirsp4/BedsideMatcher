//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 21-04-2015
//
//---------------------------------------------------


#import "Helper.h"
#import "sayHelloWorldFromResponse.h"


@implementation sayHelloWorldFromResponse
@synthesize _return;

+ (sayHelloWorldFromResponse *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
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
        if([Helper hasValue:__node name:@"return" index:0])
        {
            self._return = [[Helper getNode:__node name:@"return" index:0] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request
{

             
    DDXMLElement* ___returnItemElement=[__request writeElement:_return type:[NSString class] name:@"return" URI:@"" parent:__parent skipNullProperty:YES];
    if(___returnItemElement!=nil)
    {
        [___returnItemElement setStringValue:self._return];
    }


}
@end
