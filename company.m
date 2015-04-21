//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 21-04-2015
//
//---------------------------------------------------


#import "Helper.h"
#import "company.h"


@implementation company
@synthesize abteilung;
@synthesize GLN;
@synthesize name;

+ (company *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
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
        if([Helper hasValue:__node name:@"abteilung" index:0])
        {
            self.abteilung = [[Helper getNode:__node name:@"abteilung" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"GLN" index:0])
        {
            self.GLN = [[Helper getNode:__node name:@"GLN" index:0] stringValue];
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

             
    DDXMLElement* __abteilungItemElement=[__request writeElement:abteilung type:[NSString class] name:@"abteilung" URI:@"" parent:__parent skipNullProperty:YES];
    if(__abteilungItemElement!=nil)
    {
        [__abteilungItemElement setStringValue:self.abteilung];
    }
             
    DDXMLElement* __GLNItemElement=[__request writeElement:GLN type:[NSString class] name:@"GLN" URI:@"" parent:__parent skipNullProperty:YES];
    if(__GLNItemElement!=nil)
    {
        [__GLNItemElement setStringValue:self.GLN];
    }
             
    DDXMLElement* __nameItemElement=[__request writeElement:name type:[NSString class] name:@"name" URI:@"" parent:__parent skipNullProperty:YES];
    if(__nameItemElement!=nil)
    {
        [__nameItemElement setStringValue:self.name];
    }


}
@end
