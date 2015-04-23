//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 23-04-2015
//
//---------------------------------------------------


#import "production.h"
#import "Helper.h"
#import "processOrderResponse.h"


@implementation processOrderResponse
@synthesize _return;

+ (processOrderResponse *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
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
            self._return = (production*)[__request createObject:[Helper getNode:__node name:@"return" index:0] type:[production class]];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request
{

             
    DDXMLElement* ___returnItemElement=[__request writeElement:_return type:[production class] name:@"return" URI:@"" parent:__parent skipNullProperty:YES];
    if(___returnItemElement!=nil)
    {
        [self._return serialize:___returnItemElement __request: __request];
    }


}
@end
