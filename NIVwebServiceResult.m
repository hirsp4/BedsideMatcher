//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.2
//
// Created by Quasar Development at 10-03-2015
//
//---------------------------------------------------


#import "NIVitem.h"
#import "NIVHelper.h"
#import "NIVwebServiceResult.h"


@implementation NIVwebServiceResult
@synthesize items;
@synthesize result;

+ (NIVwebServiceResult *)createWithXml:(DDXMLElement *)__node __request:(NIVRequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
        self.items =[NSMutableArray array];
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(NIVRequestResultHandler*) __request{
    if(self = [self init])
    {
        if([NIVHelper hasValue:__node name:@"items"])
        {
            NSArray* __items=[__node elementsForName:@"items"];
            for (DDXMLElement* __item in __items) {
                [self.items addObject:(NIVitem*)[__request createObject:__item type:[NIVitem class]]];
            }
        }
        if([NIVHelper hasValue:__node name:@"result" index:0])
        {
            self.result = [[[NIVHelper getNode:__node name:@"result" index:0] stringValue] boolValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(NIVRequestResultHandler*) __request
{

             
    if(self.items!=nil)
    {
        for (NIVitem* __item in self.items) {
            DDXMLElement* __itemsItemElement=[__request writeElement:items type:[NIVitem class] name:@"items" URI:@"" parent:__parent skipNullProperty:NO];
            if(__itemsItemElement!=nil)
            {
                [__item serialize:__itemsItemElement __request: __request];
            }
        }
    }
             
    DDXMLElement* __resultItemElement=[__request writeElement:@"result" URI:@"" parent:__parent];
    [__resultItemElement setStringValue:[NIVHelper toBoolStringFromBool:self.result]];


}
@end
