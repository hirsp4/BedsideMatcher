//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 16-04-2015
//
//---------------------------------------------------


#import "item.h"
#import "Helper.h"
#import "insertTrackingItems.h"


@implementation insertTrackingItems
@synthesize arg0;
@synthesize arg1;
@synthesize arg2;

+ (insertTrackingItems *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
        self.arg0 =[NSMutableArray array];
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(RequestResultHandler*) __request{
    if(self = [self init])
    {
        if([Helper hasValue:__node name:@"arg0"])
        {
            NSArray* __items=[__node elementsForName:@"arg0"];
            for (DDXMLElement* __item in __items) {
                [self.arg0 addObject:(item*)[__request createObject:__item type:[item class]]];
            }
        }
        if([Helper hasValue:__node name:@"arg1" index:0])
        {
            self.arg1 = [[Helper getNode:__node name:@"arg1" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"arg2" index:0])
        {
            self.arg2 = [NSNumber numberWithInt:[[[Helper getNode:__node name:@"arg2" index:0] stringValue] intValue]];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request
{

             
    if(self.arg0!=nil)
    {
        for (item* __item in self.arg0) {
            DDXMLElement* __arg0ItemElement=[__request writeElement:arg0 type:[item class] name:@"arg0" URI:@"" parent:__parent skipNullProperty:NO];
            if(__arg0ItemElement!=nil)
            {
                [__item serialize:__arg0ItemElement __request: __request];
            }
        }
    }
             
    DDXMLElement* __arg1ItemElement=[__request writeElement:arg1 type:[NSString class] name:@"arg1" URI:@"" parent:__parent skipNullProperty:YES];
    if(__arg1ItemElement!=nil)
    {
        [__arg1ItemElement setStringValue:self.arg1];
    }
             
    DDXMLElement* __arg2ItemElement=[__request writeElement:arg2 type:[NSNumber class] name:@"arg2" URI:@"" parent:__parent skipNullProperty:YES];
    if(__arg2ItemElement!=nil)
    {
        [__arg2ItemElement setStringValue:[self.arg2 stringValue]];
    }


}
@end
