//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 23-04-2015
//
//---------------------------------------------------


#import "trspPreparedMedication.h"
#import "prescriptionState.h"
#import "Helper.h"
#import "trspPrescription.h"


@implementation trspPrescription
@synthesize createdByStaffGLN;
@synthesize dateCreated;
@synthesize description;
@synthesize firstName;
@synthesize medications;
@synthesize medicationsEvening;
@synthesize medicationsMorning;
@synthesize medicationsNight;
@synthesize medicationsNoon;
@synthesize name;
@synthesize notes;
@synthesize patientPolypointID;
@synthesize polypointID;
@synthesize position;
@synthesize prescriptionState;
@synthesize routeOfAdministration;
@synthesize schedule;
@synthesize vaildUntil;

+ (trspPrescription *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
        self.medications =[NSMutableArray array];
        self.medicationsEvening =[NSMutableArray array];
        self.medicationsMorning =[NSMutableArray array];
        self.medicationsNight =[NSMutableArray array];
        self.medicationsNoon =[NSMutableArray array];
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(RequestResultHandler*) __request{
    if(self = [self init])
    {
        if([Helper hasValue:__node name:@"createdByStaffGLN" index:0])
        {
            self.createdByStaffGLN = [[Helper getNode:__node name:@"createdByStaffGLN" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"dateCreated" index:0])
        {
            self.dateCreated = [[Helper getNode:__node name:@"dateCreated" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"description" index:0])
        {
            self.description = [[Helper getNode:__node name:@"description" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"firstName" index:0])
        {
            self.firstName = [[Helper getNode:__node name:@"firstName" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"medications"])
        {
            NSArray* __items=[__node elementsForName:@"medications"];
            for (DDXMLElement* __item in __items) {
                [self.medications addObject:(trspPreparedMedication*)[__request createObject:__item type:[trspPreparedMedication class]]];
            }
        }
        if([Helper hasValue:__node name:@"medicationsEvening"])
        {
            NSArray* __items=[__node elementsForName:@"medicationsEvening"];
            for (DDXMLElement* __item in __items) {
                [self.medicationsEvening addObject:(trspPreparedMedication*)[__request createObject:__item type:[trspPreparedMedication class]]];
            }
        }
        if([Helper hasValue:__node name:@"medicationsMorning"])
        {
            NSArray* __items=[__node elementsForName:@"medicationsMorning"];
            for (DDXMLElement* __item in __items) {
                [self.medicationsMorning addObject:(trspPreparedMedication*)[__request createObject:__item type:[trspPreparedMedication class]]];
            }
        }
        if([Helper hasValue:__node name:@"medicationsNight"])
        {
            NSArray* __items=[__node elementsForName:@"medicationsNight"];
            for (DDXMLElement* __item in __items) {
                [self.medicationsNight addObject:(trspPreparedMedication*)[__request createObject:__item type:[trspPreparedMedication class]]];
            }
        }
        if([Helper hasValue:__node name:@"medicationsNoon"])
        {
            NSArray* __items=[__node elementsForName:@"medicationsNoon"];
            for (DDXMLElement* __item in __items) {
                [self.medicationsNoon addObject:(trspPreparedMedication*)[__request createObject:__item type:[trspPreparedMedication class]]];
            }
        }
        if([Helper hasValue:__node name:@"name" index:0])
        {
            self.name = [[Helper getNode:__node name:@"name" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"notes" index:0])
        {
            self.notes = [[Helper getNode:__node name:@"notes" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"patientPolypointID" index:0])
        {
            self.patientPolypointID = [[Helper getNode:__node name:@"patientPolypointID" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"polypointID" index:0])
        {
            self.polypointID = [[Helper getNode:__node name:@"polypointID" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"position" index:0])
        {
            self.position = [[Helper getNode:__node name:@"position" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"prescriptionState" index:0])
        {
            self.prescriptionState = (prescriptionState*)[prescriptionState createWithXml:[Helper getNode:__node name:@"prescriptionState" index:0]];
        }
        if([Helper hasValue:__node name:@"routeOfAdministration" index:0])
        {
            self.routeOfAdministration = [[Helper getNode:__node name:@"routeOfAdministration" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"schedule" index:0])
        {
            self.schedule = [[Helper getNode:__node name:@"schedule" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"vaildUntil" index:0])
        {
            self.vaildUntil = [[Helper getNode:__node name:@"vaildUntil" index:0] stringValue];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request
{

             
    DDXMLElement* __createdByStaffGLNItemElement=[__request writeElement:createdByStaffGLN type:[NSString class] name:@"createdByStaffGLN" URI:@"" parent:__parent skipNullProperty:YES];
    if(__createdByStaffGLNItemElement!=nil)
    {
        [__createdByStaffGLNItemElement setStringValue:self.createdByStaffGLN];
    }
             
    DDXMLElement* __dateCreatedItemElement=[__request writeElement:dateCreated type:[NSString class] name:@"dateCreated" URI:@"" parent:__parent skipNullProperty:YES];
    if(__dateCreatedItemElement!=nil)
    {
        [__dateCreatedItemElement setStringValue:self.dateCreated];
    }
             
    DDXMLElement* __descriptionItemElement=[__request writeElement:description type:[NSString class] name:@"description" URI:@"" parent:__parent skipNullProperty:YES];
    if(__descriptionItemElement!=nil)
    {
        [__descriptionItemElement setStringValue:self.description];
    }
             
    DDXMLElement* __firstNameItemElement=[__request writeElement:firstName type:[NSString class] name:@"firstName" URI:@"" parent:__parent skipNullProperty:YES];
    if(__firstNameItemElement!=nil)
    {
        [__firstNameItemElement setStringValue:self.firstName];
    }
             
    if(self.medications!=nil)
    {
        for (trspPreparedMedication* __item in self.medications) {
            DDXMLElement* __medicationsItemElement=[__request writeElement:medications type:[trspPreparedMedication class] name:@"medications" URI:@"" parent:__parent skipNullProperty:NO];
            if(__medicationsItemElement!=nil)
            {
                [__item serialize:__medicationsItemElement __request: __request];
            }
        }
    }
             
    if(self.medicationsEvening!=nil)
    {
        for (trspPreparedMedication* __item in self.medicationsEvening) {
            DDXMLElement* __medicationsEveningItemElement=[__request writeElement:medicationsEvening type:[trspPreparedMedication class] name:@"medicationsEvening" URI:@"" parent:__parent skipNullProperty:NO];
            if(__medicationsEveningItemElement!=nil)
            {
                [__item serialize:__medicationsEveningItemElement __request: __request];
            }
        }
    }
             
    if(self.medicationsMorning!=nil)
    {
        for (trspPreparedMedication* __item in self.medicationsMorning) {
            DDXMLElement* __medicationsMorningItemElement=[__request writeElement:medicationsMorning type:[trspPreparedMedication class] name:@"medicationsMorning" URI:@"" parent:__parent skipNullProperty:NO];
            if(__medicationsMorningItemElement!=nil)
            {
                [__item serialize:__medicationsMorningItemElement __request: __request];
            }
        }
    }
             
    if(self.medicationsNight!=nil)
    {
        for (trspPreparedMedication* __item in self.medicationsNight) {
            DDXMLElement* __medicationsNightItemElement=[__request writeElement:medicationsNight type:[trspPreparedMedication class] name:@"medicationsNight" URI:@"" parent:__parent skipNullProperty:NO];
            if(__medicationsNightItemElement!=nil)
            {
                [__item serialize:__medicationsNightItemElement __request: __request];
            }
        }
    }
             
    if(self.medicationsNoon!=nil)
    {
        for (trspPreparedMedication* __item in self.medicationsNoon) {
            DDXMLElement* __medicationsNoonItemElement=[__request writeElement:medicationsNoon type:[trspPreparedMedication class] name:@"medicationsNoon" URI:@"" parent:__parent skipNullProperty:NO];
            if(__medicationsNoonItemElement!=nil)
            {
                [__item serialize:__medicationsNoonItemElement __request: __request];
            }
        }
    }
             
    DDXMLElement* __nameItemElement=[__request writeElement:name type:[NSString class] name:@"name" URI:@"" parent:__parent skipNullProperty:YES];
    if(__nameItemElement!=nil)
    {
        [__nameItemElement setStringValue:self.name];
    }
             
    DDXMLElement* __notesItemElement=[__request writeElement:notes type:[NSString class] name:@"notes" URI:@"" parent:__parent skipNullProperty:YES];
    if(__notesItemElement!=nil)
    {
        [__notesItemElement setStringValue:self.notes];
    }
             
    DDXMLElement* __patientPolypointIDItemElement=[__request writeElement:patientPolypointID type:[NSString class] name:@"patientPolypointID" URI:@"" parent:__parent skipNullProperty:YES];
    if(__patientPolypointIDItemElement!=nil)
    {
        [__patientPolypointIDItemElement setStringValue:self.patientPolypointID];
    }
             
    DDXMLElement* __polypointIDItemElement=[__request writeElement:polypointID type:[NSString class] name:@"polypointID" URI:@"" parent:__parent skipNullProperty:YES];
    if(__polypointIDItemElement!=nil)
    {
        [__polypointIDItemElement setStringValue:self.polypointID];
    }
             
    DDXMLElement* __positionItemElement=[__request writeElement:position type:[NSString class] name:@"position" URI:@"" parent:__parent skipNullProperty:YES];
    if(__positionItemElement!=nil)
    {
        [__positionItemElement setStringValue:self.position];
    }
             
    DDXMLElement* __prescriptionStateItemElement=[__request writeElement:prescriptionState type:[prescriptionState class] name:@"prescriptionState" URI:@"" parent:__parent skipNullProperty:YES];
    if(__prescriptionStateItemElement!=nil)
    {
        [self.prescriptionState serialize:__prescriptionStateItemElement];
    }
             
    DDXMLElement* __routeOfAdministrationItemElement=[__request writeElement:routeOfAdministration type:[NSString class] name:@"routeOfAdministration" URI:@"" parent:__parent skipNullProperty:YES];
    if(__routeOfAdministrationItemElement!=nil)
    {
        [__routeOfAdministrationItemElement setStringValue:self.routeOfAdministration];
    }
             
    DDXMLElement* __scheduleItemElement=[__request writeElement:schedule type:[NSString class] name:@"schedule" URI:@"" parent:__parent skipNullProperty:YES];
    if(__scheduleItemElement!=nil)
    {
        [__scheduleItemElement setStringValue:self.schedule];
    }
             
    DDXMLElement* __vaildUntilItemElement=[__request writeElement:vaildUntil type:[NSString class] name:@"vaildUntil" URI:@"" parent:__parent skipNullProperty:YES];
    if(__vaildUntilItemElement!=nil)
    {
        [__vaildUntilItemElement setStringValue:self.vaildUntil];
    }


}
@end
