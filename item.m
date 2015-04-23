//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 23-04-2015
//
//---------------------------------------------------


#import "company.h"
#import "Helper.h"
#import "item.h"


@implementation item
@synthesize ATC;
@synthesize beschreibung;
@synthesize checkInDate;
@synthesize expiryDate;
@synthesize GTIN;
@synthesize lot;
@synthesize menge;
@synthesize name;
@synthesize producer;
@synthesize serial;
@synthesize zusatz;

+ (item *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
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
        if([Helper hasValue:__node name:@"ATC" index:0])
        {
            self.ATC = [[Helper getNode:__node name:@"ATC" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"beschreibung" index:0])
        {
            self.beschreibung = [[Helper getNode:__node name:@"beschreibung" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"checkInDate" index:0])
        {
            self.checkInDate = [[Helper getNode:__node name:@"checkInDate" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"expiryDate" index:0])
        {
            self.expiryDate = [[Helper getNode:__node name:@"expiryDate" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"GTIN" index:0])
        {
            self.GTIN = [[Helper getNode:__node name:@"GTIN" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"lot" index:0])
        {
            self.lot = [[Helper getNode:__node name:@"lot" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"menge" index:0])
        {
            self.menge = [[Helper getNode:__node name:@"menge" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"name" index:0])
        {
            self.name = [[Helper getNode:__node name:@"name" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"producer" index:0])
        {
            self.producer = (company*)[__request createObject:[Helper getNode:__node name:@"producer" index:0] type:[company class]];
        }
        if([Helper hasValue:__node name:@"serial" index:0])
        {
            self.serial = [[Helper getNode:__node name:@"serial" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"zusatz" index:0])
        {
            self.zusatz = [[Helper getNode:__node name:@"zusatz" index:0] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request
{

             
    DDXMLElement* __ATCItemElement=[__request writeElement:ATC type:[NSString class] name:@"ATC" URI:@"" parent:__parent skipNullProperty:YES];
    if(__ATCItemElement!=nil)
    {
        [__ATCItemElement setStringValue:self.ATC];
    }
             
    DDXMLElement* __beschreibungItemElement=[__request writeElement:beschreibung type:[NSString class] name:@"beschreibung" URI:@"" parent:__parent skipNullProperty:YES];
    if(__beschreibungItemElement!=nil)
    {
        [__beschreibungItemElement setStringValue:self.beschreibung];
    }
             
    DDXMLElement* __checkInDateItemElement=[__request writeElement:checkInDate type:[NSString class] name:@"checkInDate" URI:@"" parent:__parent skipNullProperty:YES];
    if(__checkInDateItemElement!=nil)
    {
        [__checkInDateItemElement setStringValue:self.checkInDate];
    }
             
    DDXMLElement* __expiryDateItemElement=[__request writeElement:expiryDate type:[NSString class] name:@"expiryDate" URI:@"" parent:__parent skipNullProperty:YES];
    if(__expiryDateItemElement!=nil)
    {
        [__expiryDateItemElement setStringValue:self.expiryDate];
    }
             
    DDXMLElement* __GTINItemElement=[__request writeElement:GTIN type:[NSString class] name:@"GTIN" URI:@"" parent:__parent skipNullProperty:YES];
    if(__GTINItemElement!=nil)
    {
        [__GTINItemElement setStringValue:self.GTIN];
    }
             
    DDXMLElement* __lotItemElement=[__request writeElement:lot type:[NSString class] name:@"lot" URI:@"" parent:__parent skipNullProperty:YES];
    if(__lotItemElement!=nil)
    {
        [__lotItemElement setStringValue:self.lot];
    }
             
    DDXMLElement* __mengeItemElement=[__request writeElement:menge type:[NSString class] name:@"menge" URI:@"" parent:__parent skipNullProperty:YES];
    if(__mengeItemElement!=nil)
    {
        [__mengeItemElement setStringValue:self.menge];
    }
             
    DDXMLElement* __nameItemElement=[__request writeElement:name type:[NSString class] name:@"name" URI:@"" parent:__parent skipNullProperty:YES];
    if(__nameItemElement!=nil)
    {
        [__nameItemElement setStringValue:self.name];
    }
             
    DDXMLElement* __producerItemElement=[__request writeElement:producer type:[company class] name:@"producer" URI:@"" parent:__parent skipNullProperty:YES];
    if(__producerItemElement!=nil)
    {
        [self.producer serialize:__producerItemElement __request: __request];
    }
             
    DDXMLElement* __serialItemElement=[__request writeElement:serial type:[NSString class] name:@"serial" URI:@"" parent:__parent skipNullProperty:YES];
    if(__serialItemElement!=nil)
    {
        [__serialItemElement setStringValue:self.serial];
    }
             
    DDXMLElement* __zusatzItemElement=[__request writeElement:zusatz type:[NSString class] name:@"zusatz" URI:@"" parent:__parent skipNullProperty:YES];
    if(__zusatzItemElement!=nil)
    {
        [__zusatzItemElement setStringValue:self.zusatz];
    }


}
@end
