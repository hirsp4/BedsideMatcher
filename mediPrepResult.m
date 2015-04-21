//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 21-04-2015
//
//---------------------------------------------------


#import "Helper.h"
#import "mediPrepResult.h"


@implementation mediPrepResult
@synthesize errorCode;
@synthesize result;

+ (mediPrepResult *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
        self.errorCode =0;
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(RequestResultHandler*) __request{
    if(self = [self init])
    {
        if([Helper hasValue:__node name:@"errorCode" index:0])
        {
            self.errorCode = [[[Helper getNode:__node name:@"errorCode" index:0] stringValue] intValue];
        }
        if([Helper hasValue:__node name:@"result" index:0])
        {
            self.result = [[[Helper getNode:__node name:@"result" index:0] stringValue] boolValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request
{

             
    DDXMLElement* __errorCodeItemElement=[__request writeElement:@"errorCode" URI:@"" parent:__parent];
    [__errorCodeItemElement setStringValue: [NSString stringWithFormat:@"%i", self.errorCode]];
             
    DDXMLElement* __resultItemElement=[__request writeElement:@"result" URI:@"" parent:__parent];
    [__resultItemElement setStringValue:[Helper toBoolStringFromBool:self.result]];


}
@end
