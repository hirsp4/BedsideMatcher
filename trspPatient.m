//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 23-04-2015
//
//---------------------------------------------------


#import "bloodGroup.h"
#import "gender.h"
#import "Helper.h"
#import "trspPatient.h"


@implementation trspPatient
@synthesize beaconID;
@synthesize birthDate;
@synthesize bloodGroup;
@synthesize fid;
@synthesize firstname;
@synthesize gender;
@synthesize lastname;
@synthesize pid;
@synthesize reaState;
@synthesize room;
@synthesize stationName;

+ (trspPatient *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
        self.fid =0;
        self.pid =0;
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(RequestResultHandler*) __request{
    if(self = [self init])
    {
        if([Helper hasValue:__node name:@"beaconID" index:0])
        {
            self.beaconID = [[Helper getNode:__node name:@"beaconID" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"birthDate" index:0])
        {
            self.birthDate = [[Helper getNode:__node name:@"birthDate" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"bloodGroup" index:0])
        {
            self.bloodGroup = (bloodGroup*)[bloodGroup createWithXml:[Helper getNode:__node name:@"bloodGroup" index:0]];
        }
        if([Helper hasValue:__node name:@"fid" index:0])
        {
            self.fid = [[[Helper getNode:__node name:@"fid" index:0] stringValue] intValue];
        }
        if([Helper hasValue:__node name:@"firstname" index:0])
        {
            self.firstname = [[Helper getNode:__node name:@"firstname" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"gender" index:0])
        {
            self.gender = (gender*)[gender createWithXml:[Helper getNode:__node name:@"gender" index:0]];
        }
        if([Helper hasValue:__node name:@"lastname" index:0])
        {
            self.lastname = [[Helper getNode:__node name:@"lastname" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"pid" index:0])
        {
            self.pid = [[[Helper getNode:__node name:@"pid" index:0] stringValue] intValue];
        }
        if([Helper hasValue:__node name:@"reaState" index:0])
        {
            self.reaState = [[[Helper getNode:__node name:@"reaState" index:0] stringValue] boolValue];
        }
        if([Helper hasValue:__node name:@"room" index:0])
        {
            self.room = [[Helper getNode:__node name:@"room" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"stationName" index:0])
        {
            self.stationName = [[Helper getNode:__node name:@"stationName" index:0] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request
{

             
    DDXMLElement* __beaconIDItemElement=[__request writeElement:beaconID type:[NSString class] name:@"beaconID" URI:@"" parent:__parent skipNullProperty:YES];
    if(__beaconIDItemElement!=nil)
    {
        [__beaconIDItemElement setStringValue:self.beaconID];
    }
             
    DDXMLElement* __birthDateItemElement=[__request writeElement:birthDate type:[NSString class] name:@"birthDate" URI:@"" parent:__parent skipNullProperty:YES];
    if(__birthDateItemElement!=nil)
    {
        [__birthDateItemElement setStringValue:self.birthDate];
    }
             
    DDXMLElement* __bloodGroupItemElement=[__request writeElement:bloodGroup type:[bloodGroup class] name:@"bloodGroup" URI:@"" parent:__parent skipNullProperty:YES];
    if(__bloodGroupItemElement!=nil)
    {
        [self.bloodGroup serialize:__bloodGroupItemElement];
    }
             
    DDXMLElement* __fidItemElement=[__request writeElement:@"fid" URI:@"" parent:__parent];
    [__fidItemElement setStringValue: [NSString stringWithFormat:@"%i", self.fid]];
             
    DDXMLElement* __firstnameItemElement=[__request writeElement:firstname type:[NSString class] name:@"firstname" URI:@"" parent:__parent skipNullProperty:YES];
    if(__firstnameItemElement!=nil)
    {
        [__firstnameItemElement setStringValue:self.firstname];
    }
             
    DDXMLElement* __genderItemElement=[__request writeElement:gender type:[gender class] name:@"gender" URI:@"" parent:__parent skipNullProperty:YES];
    if(__genderItemElement!=nil)
    {
        [self.gender serialize:__genderItemElement];
    }
             
    DDXMLElement* __lastnameItemElement=[__request writeElement:lastname type:[NSString class] name:@"lastname" URI:@"" parent:__parent skipNullProperty:YES];
    if(__lastnameItemElement!=nil)
    {
        [__lastnameItemElement setStringValue:self.lastname];
    }
             
    DDXMLElement* __pidItemElement=[__request writeElement:@"pid" URI:@"" parent:__parent];
    [__pidItemElement setStringValue: [NSString stringWithFormat:@"%i", self.pid]];
             
    DDXMLElement* __reaStateItemElement=[__request writeElement:@"reaState" URI:@"" parent:__parent];
    [__reaStateItemElement setStringValue:[Helper toBoolStringFromBool:self.reaState]];
             
    DDXMLElement* __roomItemElement=[__request writeElement:room type:[NSString class] name:@"room" URI:@"" parent:__parent skipNullProperty:YES];
    if(__roomItemElement!=nil)
    {
        [__roomItemElement setStringValue:self.room];
    }
             
    DDXMLElement* __stationNameItemElement=[__request writeElement:stationName type:[NSString class] name:@"stationName" URI:@"" parent:__parent skipNullProperty:YES];
    if(__stationNameItemElement!=nil)
    {
        [__stationNameItemElement setStringValue:self.stationName];
    }


}
@end
