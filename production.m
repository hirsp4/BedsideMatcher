//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 16-04-2015
//
//---------------------------------------------------


#import "item.h"
#import "position.h"
#import "shipment.h"
#import "Helper.h"
#import "production.h"


@implementation production
@synthesize items;
@synthesize positions;
@synthesize shipment;
@synthesize success;

+ (production *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
        self.items =[NSMutableArray array];
        self.positions =[NSMutableArray array];
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
        if([Helper hasValue:__node name:@"positions"])
        {
            NSArray* __items=[__node elementsForName:@"positions"];
            for (DDXMLElement* __item in __items) {
                [self.positions addObject:(position*)[__request createObject:__item type:[position class]]];
            }
        }
        if([Helper hasValue:__node name:@"shipment" index:0])
        {
            self.shipment = (shipment*)[__request createObject:[Helper getNode:__node name:@"shipment" index:0] type:[shipment class]];
        }
        if([Helper hasValue:__node name:@"success" index:0])
        {
            self.success = [[[Helper getNode:__node name:@"success" index:0] stringValue] boolValue];
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
             
    if(self.positions!=nil)
    {
        for (position* __item in self.positions) {
            DDXMLElement* __positionsItemElement=[__request writeElement:positions type:[position class] name:@"positions" URI:@"" parent:__parent skipNullProperty:NO];
            if(__positionsItemElement!=nil)
            {
                [__item serialize:__positionsItemElement __request: __request];
            }
        }
    }
             
    DDXMLElement* __shipmentItemElement=[__request writeElement:shipment type:[shipment class] name:@"shipment" URI:@"" parent:__parent skipNullProperty:YES];
    if(__shipmentItemElement!=nil)
    {
        [self.shipment serialize:__shipmentItemElement __request: __request];
    }
             
    DDXMLElement* __successItemElement=[__request writeElement:@"success" URI:@"" parent:__parent];
    [__successItemElement setStringValue:[Helper toBoolStringFromBool:self.success]];


}
@end