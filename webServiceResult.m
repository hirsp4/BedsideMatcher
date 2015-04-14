//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 14-04-2015
//
//---------------------------------------------------


#import "item.h"
#import "Helper.h"
#import "webServiceResult.h"


@implementation webServiceResult
@synthesize items;
@synthesize result;

+ (webServiceResult *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
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

- (id) initWithXml: (DDXMLElement*) __node __request:(RequestResultHandler*) __request{
    if(self = [self init])
    {
        if([Helper hasValue:__node name:@"items"])
        {
            NSArray* __items=[__node elementsForName:@"items"];
            for (DDXMLElement* __item in __items) {
                [self.items addObject:(item*)[__request createObject:__item type:[item class]]];
            }
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

             
    if(self.items!=nil)
    {
        for (item* __item in self.items) {
            DDXMLElement* __itemsItemElement=[__request writeElement:items type:[item class] name:@"items" URI:@"" parent:__parent skipNullProperty:NO];
            if(__itemsItemElement!=nil)
            {
                [__item serialize:__itemsItemElement __request: __request];
            }
        }
    }
             
    DDXMLElement* __resultItemElement=[__request writeElement:@"result" URI:@"" parent:__parent];
    [__resultItemElement setStringValue:[Helper toBoolStringFromBool:self.result]];


}
@end
