//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 21-04-2015
//
//---------------------------------------------------


#import "Helper.h"
#import "trspMedication.h"


@implementation trspMedication
@synthesize applicationScheme;
@synthesize description;
@synthesize dosage;
@synthesize dosageUnit;
@synthesize gtinA;
@synthesize gtinBs;
@synthesize name;

+ (trspMedication *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
        self.gtinBs =[NSMutableArray array];
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(RequestResultHandler*) __request{
    if(self = [self init])
    {
        if([Helper hasValue:__node name:@"applicationScheme" index:0])
        {
            self.applicationScheme = [[Helper getNode:__node name:@"applicationScheme" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"description" index:0])
        {
            self.description = [[Helper getNode:__node name:@"description" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"dosage" index:0])
        {
            self.dosage = [[Helper getNode:__node name:@"dosage" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"dosageUnit" index:0])
        {
            self.dosageUnit = [[Helper getNode:__node name:@"dosageUnit" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"gtinA" index:0])
        {
            self.gtinA = [[Helper getNode:__node name:@"gtinA" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"gtinBs"])
        {
            NSArray* __items=[__node elementsForName:@"gtinBs"];
            for (DDXMLElement* __item in __items) {
                [self.gtinBs addObject:[__item stringValue]];
            }
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

             
    DDXMLElement* __applicationSchemeItemElement=[__request writeElement:applicationScheme type:[NSString class] name:@"applicationScheme" URI:@"" parent:__parent skipNullProperty:YES];
    if(__applicationSchemeItemElement!=nil)
    {
        [__applicationSchemeItemElement setStringValue:self.applicationScheme];
    }
             
    DDXMLElement* __descriptionItemElement=[__request writeElement:description type:[NSString class] name:@"description" URI:@"" parent:__parent skipNullProperty:YES];
    if(__descriptionItemElement!=nil)
    {
        [__descriptionItemElement setStringValue:self.description];
    }
             
    DDXMLElement* __dosageItemElement=[__request writeElement:dosage type:[NSString class] name:@"dosage" URI:@"" parent:__parent skipNullProperty:YES];
    if(__dosageItemElement!=nil)
    {
        [__dosageItemElement setStringValue:self.dosage];
    }
             
    DDXMLElement* __dosageUnitItemElement=[__request writeElement:dosageUnit type:[NSString class] name:@"dosageUnit" URI:@"" parent:__parent skipNullProperty:YES];
    if(__dosageUnitItemElement!=nil)
    {
        [__dosageUnitItemElement setStringValue:self.dosageUnit];
    }
             
    DDXMLElement* __gtinAItemElement=[__request writeElement:gtinA type:[NSString class] name:@"gtinA" URI:@"" parent:__parent skipNullProperty:YES];
    if(__gtinAItemElement!=nil)
    {
        [__gtinAItemElement setStringValue:self.gtinA];
    }
             
    if(self.gtinBs!=nil)
    {
        for (NSString* __item in self.gtinBs) {
            DDXMLElement* __gtinBsItemElement=[__request writeElement:gtinBs type:[NSString class] name:@"gtinBs" URI:@"" parent:__parent skipNullProperty:NO];
            if(__gtinBsItemElement!=nil)
            {
                [__gtinBsItemElement setStringValue:__item];
            }
        }
    }
             
    DDXMLElement* __nameItemElement=[__request writeElement:name type:[NSString class] name:@"name" URI:@"" parent:__parent skipNullProperty:YES];
    if(__nameItemElement!=nil)
    {
        [__nameItemElement setStringValue:self.name];
    }


}
@end
