//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 23-04-2015
//
//---------------------------------------------------


#import "trspPrescription.h"
#import "trspPatient.h"
#import "medicationState.h"
#import "trspMedication.h"
#import "Helper.h"
#import "trspPreparedMedication.h"


@implementation trspPreparedMedication
@synthesize basedOnPrescription;
@synthesize batchLot;
@synthesize expiryDate;
@synthesize forPatient;
@synthesize gtinFromAssignedItem;
@synthesize isReserve;
@synthesize preparationTime;
@synthesize preparedMedicationId;
@synthesize serial;
@synthesize staffGln;
@synthesize state;

+ (trspPreparedMedication *)createWithXml:(DDXMLElement *)__node __request:(RequestResultHandler*) __request
{
    if(__node == nil) { return nil; }
    return [[self alloc] initWithXml: __node __request:__request];
}

-(id)init {
    if ((self=[super init])) {
        self.preparedMedicationId =0;
    }
    return self;
}

- (id) initWithXml: (DDXMLElement*) __node __request:(RequestResultHandler*) __request{
    if(self = [super initWithXml:__node __request:__request])
    {
        if([Helper hasValue:__node name:@"basedOnPrescription" index:0])
        {
            self.basedOnPrescription = (trspPrescription*)[__request createObject:[Helper getNode:__node name:@"basedOnPrescription" index:0] type:[trspPrescription class]];
        }
        if([Helper hasValue:__node name:@"batchLot" index:0])
        {
            self.batchLot = [[Helper getNode:__node name:@"batchLot" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"expiryDate" index:0])
        {
            self.expiryDate = [[Helper getNode:__node name:@"expiryDate" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"forPatient" index:0])
        {
            self.forPatient = (trspPatient*)[__request createObject:[Helper getNode:__node name:@"forPatient" index:0] type:[trspPatient class]];
        }
        if([Helper hasValue:__node name:@"gtinFromAssignedItem" index:0])
        {
            self.gtinFromAssignedItem = [[Helper getNode:__node name:@"gtinFromAssignedItem" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"isReserve" index:0])
        {
            self.isReserve = [[[Helper getNode:__node name:@"isReserve" index:0] stringValue] boolValue];
        }
        if([Helper hasValue:__node name:@"preparationTime" index:0])
        {
            self.preparationTime = [[Helper getNode:__node name:@"preparationTime" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"preparedMedicationId" index:0])
        {
            self.preparedMedicationId = [[[Helper getNode:__node name:@"preparedMedicationId" index:0] stringValue] intValue];
        }
        if([Helper hasValue:__node name:@"serial" index:0])
        {
            self.serial = [[Helper getNode:__node name:@"serial" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"staffGln" index:0])
        {
            self.staffGln = [[Helper getNode:__node name:@"staffGln" index:0] stringValue];
        }
        if([Helper hasValue:__node name:@"state" index:0])
        {
            self.state = (medicationState*)[medicationState createWithXml:[Helper getNode:__node name:@"state" index:0]];
        }
    }
    return self;
}

-(void) serialize:(DDXMLElement*)__parent __request:(RequestResultHandler*) __request
{
    [super serialize:__parent __request:__request];

             
    DDXMLElement* __basedOnPrescriptionItemElement=[__request writeElement:basedOnPrescription type:[trspPrescription class] name:@"basedOnPrescription" URI:@"" parent:__parent skipNullProperty:YES];
    if(__basedOnPrescriptionItemElement!=nil)
    {
        [self.basedOnPrescription serialize:__basedOnPrescriptionItemElement __request: __request];
    }
             
    DDXMLElement* __batchLotItemElement=[__request writeElement:batchLot type:[NSString class] name:@"batchLot" URI:@"" parent:__parent skipNullProperty:YES];
    if(__batchLotItemElement!=nil)
    {
        [__batchLotItemElement setStringValue:self.batchLot];
    }
             
    DDXMLElement* __expiryDateItemElement=[__request writeElement:expiryDate type:[NSString class] name:@"expiryDate" URI:@"" parent:__parent skipNullProperty:YES];
    if(__expiryDateItemElement!=nil)
    {
        [__expiryDateItemElement setStringValue:self.expiryDate];
    }
             
    DDXMLElement* __forPatientItemElement=[__request writeElement:forPatient type:[trspPatient class] name:@"forPatient" URI:@"" parent:__parent skipNullProperty:YES];
    if(__forPatientItemElement!=nil)
    {
        [self.forPatient serialize:__forPatientItemElement __request: __request];
    }
             
    DDXMLElement* __gtinFromAssignedItemItemElement=[__request writeElement:gtinFromAssignedItem type:[NSString class] name:@"gtinFromAssignedItem" URI:@"" parent:__parent skipNullProperty:YES];
    if(__gtinFromAssignedItemItemElement!=nil)
    {
        [__gtinFromAssignedItemItemElement setStringValue:self.gtinFromAssignedItem];
    }
             
    DDXMLElement* __isReserveItemElement=[__request writeElement:@"isReserve" URI:@"" parent:__parent];
    [__isReserveItemElement setStringValue:[Helper toBoolStringFromBool:self.isReserve]];
             
    DDXMLElement* __preparationTimeItemElement=[__request writeElement:preparationTime type:[NSString class] name:@"preparationTime" URI:@"" parent:__parent skipNullProperty:YES];
    if(__preparationTimeItemElement!=nil)
    {
        [__preparationTimeItemElement setStringValue:self.preparationTime];
    }
             
    DDXMLElement* __preparedMedicationIdItemElement=[__request writeElement:@"preparedMedicationId" URI:@"" parent:__parent];
    [__preparedMedicationIdItemElement setStringValue: [NSString stringWithFormat:@"%i", self.preparedMedicationId]];
             
    DDXMLElement* __serialItemElement=[__request writeElement:serial type:[NSString class] name:@"serial" URI:@"" parent:__parent skipNullProperty:YES];
    if(__serialItemElement!=nil)
    {
        [__serialItemElement setStringValue:self.serial];
    }
             
    DDXMLElement* __staffGlnItemElement=[__request writeElement:staffGln type:[NSString class] name:@"staffGln" URI:@"" parent:__parent skipNullProperty:YES];
    if(__staffGlnItemElement!=nil)
    {
        [__staffGlnItemElement setStringValue:self.staffGln];
    }
             
    DDXMLElement* __stateItemElement=[__request writeElement:state type:[medicationState class] name:@"state" URI:@"" parent:__parent skipNullProperty:YES];
    if(__stateItemElement!=nil)
    {
        [self.state serialize:__stateItemElement];
    }


}
@end
