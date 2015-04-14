//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 14-04-2015
//
//---------------------------------------------------



#import "checkoutItems.h"
#import "item.h"
#import "company.h"
#import "checkoutItemsResponse.h"
#import "webServiceResult.h"
#import "getOrderForSSCC.h"
#import "getOrderForSSCCResponse.h"
#import "getPrescriptionsForPatient.h"
#import "trspPrescription.h"
#import "trspPreparedMedication.h"
#import "trspMedication.h"
#import "trspPatient.h"
#import "resetTrackedItems.h"
#import "resetTrackedItemsResponse.h"
#import "updatePreparedMedications.h"
#import "updatePreparedMedicationsResponse.h"
#import "getOpenOrdersByGLN.h"
#import "order.h"
#import "position.h"
#import "getPatients.h"
#import "sayHelloWorldFrom.h"
#import "sayHelloWorldFromResponse.h"
#import "getPatientByPid.h"
#import "getPatientByPidResponse.h"
#import "savePreparedMedicationsResponse.h"
#import "checkinItems.h"
#import "checkinItemsResponse.h"
#import "getStations.h"
#import "station.h"
#import "getPreparedMedicationsForPatient.h"
#import "getPrescriptionsWithPreparedMedicationsForPatient.h"
#import "getItemsByBatch.h"
#import "getItemsBySSCC.h"
#import "getPatientByMinorId.h"
#import "getPatientByMinorIdResponse.h"
#import "getItemByIdentifier.h"
#import "getItemByIdentifierResponse.h"
#import "setOrder.h"
#import "setOrderResponse.h"
#import "processOrder.h"
#import "processOrderResponse.h"
#import "production.h"
#import "shipment.h"
#import "updatePrescriptions.h"
#import "updatePrescriptionsResponse.h"
#import "getItemsByGSIN.h"
#import "getItemsByGSINResponse.h"
#import "getDosetForPatient.h"
#import "getDosetForPatientResponse.h"
#import "getCheckedInItems.h"
#import "getCheckedInItemsResponse.h"
#import "insertTrackingItems.h"
#import "insertTrackingItemsResponse.h"
#import "getQuantities.h"
#import "quantity.h"
#import "getProductForSecondaryPackage.h"
#import "getProductForSecondaryPackageResponse.h"
#import "getPrescriptionsForPatientResponse.h"
#import "getOpenOrdersByGLNResponse.h"
#import "getPatientsResponse.h"
#import "savePreparedMedications.h"
#import "getStationsResponse.h"
#import "getPreparedMedicationsForPatientResponse.h"
#import "getPrescriptionsWithPreparedMedicationsForPatientResponse.h"
#import "getItemsByBatchResponse.h"
#import "getItemsBySSCCResponse.h"
#import "getQuantitiesResponse.h"
#import "Helper.h"
#import "RequestResultHandler.h"
#import "SoapError.h"


@implementation RequestResultHandler

@synthesize Header,Body;
@synthesize OutputHeader,OutputBody,OutputFault;
@synthesize Callback;
@synthesize EnableLogging;
static NSDictionary* classNames;

- (id) init {
    if(self = [self init:SOAPVERSION_11])
    {
    }
    return self;
}

-(id)init:(int)version {
    if ((self=[super init])) {
        soapVersion=version;
        envNS=(soapVersion==SOAPVERSION_12?@"http://www.w3.org/2003/05/soap-envelope":@"http://schemas.xmlsoap.org/soap/envelope/");
        receivedBuffer=[NSMutableData data];
        referencesTable=[NSMutableDictionary dictionary];
        reverseReferencesTable=[NSMutableDictionary dictionary];
        namespaces=[NSMutableDictionary dictionary];
        [self createEnvelopeXml];

        if(!classNames)
        {
            classNames = [NSDictionary dictionaryWithObjectsAndKeys:    
            [checkoutItems class],@"http://service/^^checkoutItems",
            [item class],@"http://service/^^item",
            [company class],@"http://service/^^company",
            [checkoutItemsResponse class],@"http://service/^^checkoutItemsResponse",
            [webServiceResult class],@"http://service/^^webServiceResult",
            [getOrderForSSCC class],@"http://service/^^getOrderForSSCC",
            [getOrderForSSCCResponse class],@"http://service/^^getOrderForSSCCResponse",
            [getPrescriptionsForPatient class],@"http://service/^^getPrescriptionsForPatient",
            [trspPrescription class],@"http://service/^^trspPrescription",
            [trspPreparedMedication class],@"http://service/^^trspPreparedMedication",
            [trspMedication class],@"http://service/^^trspMedication",
            [trspPatient class],@"http://service/^^trspPatient",
            [resetTrackedItems class],@"http://service/^^resetTrackedItems",
            [resetTrackedItemsResponse class],@"http://service/^^resetTrackedItemsResponse",
            [updatePreparedMedications class],@"http://service/^^updatePreparedMedications",
            [updatePreparedMedicationsResponse class],@"http://service/^^updatePreparedMedicationsResponse",
            [getOpenOrdersByGLN class],@"http://service/^^getOpenOrdersByGLN",
            [order class],@"http://service/^^order",
            [position class],@"http://service/^^position",
            [getPatients class],@"http://service/^^getPatients",
            [sayHelloWorldFrom class],@"http://service/^^sayHelloWorldFrom",
            [sayHelloWorldFromResponse class],@"http://service/^^sayHelloWorldFromResponse",
            [getPatientByPid class],@"http://service/^^getPatientByPid",
            [getPatientByPidResponse class],@"http://service/^^getPatientByPidResponse",
            [savePreparedMedicationsResponse class],@"http://service/^^savePreparedMedicationsResponse",
            [checkinItems class],@"http://service/^^checkinItems",
            [checkinItemsResponse class],@"http://service/^^checkinItemsResponse",
            [getStations class],@"http://service/^^getStations",
            [station class],@"http://service/^^station",
            [getPreparedMedicationsForPatient class],@"http://service/^^getPreparedMedicationsForPatient",
            [getPrescriptionsWithPreparedMedicationsForPatient class],@"http://service/^^getPrescriptionsWithPreparedMedicationsForPatient",
            [getItemsByBatch class],@"http://service/^^getItemsByBatch",
            [getItemsBySSCC class],@"http://service/^^getItemsBySSCC",
            [getPatientByMinorId class],@"http://service/^^getPatientByMinorId",
            [getPatientByMinorIdResponse class],@"http://service/^^getPatientByMinorIdResponse",
            [getItemByIdentifier class],@"http://service/^^getItemByIdentifier",
            [getItemByIdentifierResponse class],@"http://service/^^getItemByIdentifierResponse",
            [setOrder class],@"http://service/^^setOrder",
            [setOrderResponse class],@"http://service/^^setOrderResponse",
            [processOrder class],@"http://service/^^processOrder",
            [processOrderResponse class],@"http://service/^^processOrderResponse",
            [production class],@"http://service/^^production",
            [shipment class],@"http://service/^^shipment",
            [updatePrescriptions class],@"http://service/^^updatePrescriptions",
            [updatePrescriptionsResponse class],@"http://service/^^updatePrescriptionsResponse",
            [getItemsByGSIN class],@"http://service/^^getItemsByGSIN",
            [getItemsByGSINResponse class],@"http://service/^^getItemsByGSINResponse",
            [getDosetForPatient class],@"http://service/^^getDosetForPatient",
            [getDosetForPatientResponse class],@"http://service/^^getDosetForPatientResponse",
            [getCheckedInItems class],@"http://service/^^getCheckedInItems",
            [getCheckedInItemsResponse class],@"http://service/^^getCheckedInItemsResponse",
            [insertTrackingItems class],@"http://service/^^insertTrackingItems",
            [insertTrackingItemsResponse class],@"http://service/^^insertTrackingItemsResponse",
            [getQuantities class],@"http://service/^^getQuantities",
            [quantity class],@"http://service/^^quantity",
            [getProductForSecondaryPackage class],@"http://service/^^getProductForSecondaryPackage",
            [getProductForSecondaryPackageResponse class],@"http://service/^^getProductForSecondaryPackageResponse",
            [getPrescriptionsForPatientResponse class],@"http://service/^^getPrescriptionsForPatientResponse",
            [getOpenOrdersByGLNResponse class],@"http://service/^^getOpenOrdersByGLNResponse",
            [getPatientsResponse class],@"http://service/^^getPatientsResponse",
            [savePreparedMedications class],@"http://service/^^savePreparedMedications",
            [getStationsResponse class],@"http://service/^^getStationsResponse",
            [getPreparedMedicationsForPatientResponse class],@"http://service/^^getPreparedMedicationsForPatientResponse",
            [getPrescriptionsWithPreparedMedicationsForPatientResponse class],@"http://service/^^getPrescriptionsWithPreparedMedicationsForPatientResponse",
            [getItemsByBatchResponse class],@"http://service/^^getItemsByBatchResponse",
            [getItemsBySSCCResponse class],@"http://service/^^getItemsBySSCCResponse",
            [getQuantitiesResponse class],@"http://service/^^getQuantitiesResponse",
            nil]; 

        }
    }
    return self;
}

    
-(NSString*) getEnvelopeString
{
    return [[xml rootElement] XMLString];
}

-(DDXMLDocument*) createEnvelopeXml
{
    NSString *envelope=nil;
    if(soapVersion==SOAPVERSION_12)
    {
        envelope = [NSString stringWithFormat:@"<soap:Envelope xmlns:c=\"http://www.w3.org/2003/05/soap-encoding\" xmlns:soap=\"%@\"></soap:Envelope>",envNS];
    }
    else
    {
        envelope = [NSString stringWithFormat:@"<soap:Envelope xmlns:c=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:soap=\"%@\"></soap:Envelope>",envNS];
    }
    
    xml = [[DDXMLDocument alloc] initWithXMLString:envelope options:0 error:nil];
    
    DDXMLElement *root=[xml rootElement];
    Header=[[DDXMLElement alloc] initWithName:@"soap:Header"];
    Body=[[DDXMLElement alloc] initWithName:@"soap:Body"];
    [root addChild:Header];
    [root addChild:Body];
    return xml;
}

-(id)createObject: (DDXMLElement*) node type:(Class) type
{
    DDXMLNode* refAttr=[Helper getAttribute:node name:@"Ref" url:MS_SERIALIZATION_NS];
    if(refAttr!=nil)
    {
        return [referencesTable objectForKey:[refAttr stringValue]];
    }
    
    DDXMLNode* nilAttr=[Helper getAttribute:node name:@"nil" url:XSI];
    if(nilAttr!=nil && [[nilAttr stringValue]boolValue])
    {
        return nil;
    }

    DDXMLNode* typeAttr=[Helper getAttribute:node name:@"type" url:XSI];
    if(typeAttr !=nil)
    {
        NSString* attrValue=[typeAttr stringValue];
        NSArray* splitString=[attrValue componentsSeparatedByString:@":"];
        DDXMLNode* namespace=[node resolveNamespaceForName:attrValue];
        NSString* typeName=[splitString count]==2?[splitString objectAtIndex:1]:attrValue;
        if(namespace!=nil)
        {
            NSString* classType=[NSString stringWithFormat:@"%@^^%@",[namespace stringValue],typeName];
            Class temp=[classNames objectForKey: classType];
            if(temp!=nil)
            {
                type=temp;
            }
        }
    }

    DDXMLNode* hrefAttr=[Helper getAttribute:node name:@"href" url:@""];
    if(hrefAttr==nil)
    {
        hrefAttr=[Helper getAttribute:node name:@"ref" url:@""];
    }
    if(hrefAttr!=nil)
    {
        NSString* hrefId=[[hrefAttr stringValue] substringFromIndex:1];
        NSString* xpathQuery=[NSString stringWithFormat:@"//*[@id='%@']",hrefId];
        NSArray *nodes=[node.rootDocument nodesForXPath:xpathQuery error:nil];

        if([nodes count]>0)
        {
            node=[nodes objectAtIndex:0];
        }
    }

    id obj=[self createInstance:type node:node request:self];

    DDXMLNode* idAttr=[Helper getAttribute:node name:@"Id" url:MS_SERIALIZATION_NS];
    if(idAttr!=nil)
    {
        [referencesTable setObject:obj forKey:[idAttr stringValue]];
    }
    
    return obj;
}
    
-(id) createInstance:(Class) type node: (DDXMLNode*)node request :(RequestResultHandler *)request
{
    SEL initSelector=@selector(initWithXml:__request:);
    id allocObj=[type alloc];
    IMP imp = [allocObj methodForSelector:initSelector];
    id (*func)(id, SEL, DDXMLNode*, RequestResultHandler *) = (void *)imp;
    id obj = func(allocObj, initSelector, node, self);
    return obj;
}

-(NSString*) getNamespacePrefix:(NSString*) url propertyElement:(DDXMLElement*) propertyElement
{
    if([url length]==0)
    {
        return nil;
    }
    DDXMLElement* rootElement= [[propertyElement rootDocument] rootElement];
    NSString* prefix= [namespaces valueForKey:url];
    if(prefix==nil)
    {
        prefix=[NSString stringWithFormat:@"n%u",[namespaces count]+1];
        DDXMLNode* ns=[DDXMLNode namespaceWithName:prefix stringValue:url];
        [rootElement addNamespace:ns];
        [namespaces setValue:prefix forKey:url];
    }
    return prefix;
}
        
-(NSString*) getXmlFullName:(NSString*) name URI:(NSString*) URI propertyElement:(DDXMLElement*) propertyElement
{
    NSString *prefix=[self getNamespacePrefix:URI propertyElement:propertyElement];
    NSString *fullname=name;
    if(prefix!=nil)
    {
        fullname=[NSString stringWithFormat:@"%@:%@",prefix,name];
    }
    return fullname;
}
    
-(DDXMLNode*) addAttribute:(NSString*) name URI:(NSString*) URI stringValue:(NSString*) stringValue element:(DDXMLElement*) element
{
    NSString *fullname=[self getXmlFullName:name URI:URI propertyElement:element];
    DDXMLNode *refAttr=[DDXMLNode attributeWithName:fullname stringValue:stringValue];
    [element addAttribute:refAttr];
    return refAttr;
}

-(DDXMLElement*) writeElement:(NSString*)name URI: (NSString*) URI parent:(DDXMLElement*) parent
{
    NSString *fullname=[self getXmlFullName:name URI:URI propertyElement:parent];
    DDXMLElement* propertyElement=[[DDXMLElement alloc] initWithName:fullname];
    [parent addChild:propertyElement];
    return propertyElement;
}


-(DDXMLElement*) writeElement:(id)obj type:(Class)type name: (NSString*)name URI: (NSString*) URI parent:(DDXMLElement*) parent skipNullProperty:(BOOL)skipNullProperty
{
    if(obj==nil && skipNullProperty)
    {
        return nil;
    }
    DDXMLElement* propertyElement=[self writeElement:name URI:URI parent:parent];
    
    if(obj==nil)
    {
        [self addAttribute:@"nil" URI:XSI stringValue:@"true" element:propertyElement];
        return nil;
    }
    NSValue* key=[NSValue valueWithNonretainedObject:obj ] ;
    id idStr=[reverseReferencesTable objectForKey:key];
    if(idStr!=nil)
    {
        [self addAttribute:@"Ref" URI:MS_SERIALIZATION_NS stringValue:idStr element:propertyElement];
        return nil;
    }
    if([obj conformsToProtocol:@protocol(IReferenceObject)])
    {
        idStr=[NSString stringWithFormat:@"i%u",[reverseReferencesTable count]+1];       
        [self addAttribute:@"Id" URI:MS_SERIALIZATION_NS stringValue:idStr element:propertyElement];
        [reverseReferencesTable setObject:idStr forKey:key];
    }

    Class currentType=[obj class];
    if(currentType!=type)
    {
        NSString* xmlType=(NSString*)[[classNames allKeysForObject:currentType] lastObject];//add namespace?
        if(xmlType!=nil)
        {
            
            NSArray* splitType=[xmlType componentsSeparatedByString:@"^^"];
            NSString *fullname=[self getXmlFullName:[splitType objectAtIndex:1] URI:[splitType objectAtIndex:0] propertyElement:propertyElement];
            [self addAttribute:@"type" URI:XSI stringValue:fullname element:propertyElement];
        }
        
    }
    return propertyElement;
}


        
-(void)setResponse:(NSData *)responseData response:(NSURLResponse*) response
{
    if(self.EnableLogging) {
        NSString* strResponse = [[NSString alloc] initWithData: responseData encoding: NSUTF8StringEncoding];
        NSLog(@"%@\n", strResponse);
    }
    DDXMLDocument *__doc=[[DDXMLDocument alloc] initWithData:responseData options:0 error:nil];
    DDXMLElement *__root=[__doc rootElement];
    if(__root==nil)
    {
        NSString* errorMessage=[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding ];
        OutputFault=[NSError  errorWithDomain:errorMessage code:0 userInfo:nil];
        return;
    }
    OutputBody=[Helper getNode:__root  name:@"Body" URI:envNS];
    OutputHeader=[Helper getNode:__root  name:@"Header" URI:envNS];
    DDXMLElement* fault=[Helper getNode:OutputBody  name:@"Fault" URI:envNS];
    if(fault!=nil)
    {
        DDXMLElement* faultString=[Helper getNode:fault name:@"faultstring"];
        id faultObj=nil;
        DDXMLElement* faultDetail=[Helper getNode:fault name:@"detail"];
        if(faultDetail!=nil)
        {
            DDXMLElement* faultClass=(DDXMLElement*)[faultDetail childAtIndex:0];
            if(faultClass!=nil)
            {
                NSString * typeName=[faultClass localName];
                DDXMLNode* namespaceNode=[faultClass resolveNamespaceForName:typeName];
                NSString* namespace=nil;
                if(namespaceNode==nil)
                {
                    namespace=[faultClass URI];
                }
                else
                {
                    namespace=[namespaceNode stringValue];
                }
                NSString* classType=[NSString stringWithFormat:@"%@^^%@",namespace,typeName];
                Class temp=[classNames objectForKey: classType];
                if(temp!=nil)
                {
                    faultObj= [self createInstance:temp node:faultClass request:self];
                }
            }
        }
        
        OutputFault=[[SoapError alloc] initWithDetails:[faultString stringValue] details:faultObj];
    }
}

-(void) sendImplementation:(NSMutableURLRequest*) request
{

    if(self.EnableLogging) {
        NSString* strRequest = [[NSString alloc] initWithData: request.HTTPBody encoding: NSUTF8StringEncoding];
        NSLog(@"%@\n", strRequest);
    }

    NSURLResponse* response;
    NSError* innerError;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&innerError];
    if(data==nil)
    {
        OutputFault = innerError;
    }
    else
    {
        [self setResponse:data response:response];
    }
}

-(void) sendImplementation:(NSMutableURLRequest*) request callbackDelegate:(CLB) callbackDelegate
{
    if(self.EnableLogging) {
        NSString* strRequest = [[NSString alloc] initWithData: request.HTTPBody encoding: NSUTF8StringEncoding];
        NSLog(@"%@\n", strRequest);
    }
    self.Callback=callbackDelegate;
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedBuffer setLength:0];
    responseObj=response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)value {
    [receivedBuffer appendData:value];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    OutputFault=error;
    self.Callback(self);
    connection = nil;
    self.Callback=nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	connection = nil;
    [self setResponse:receivedBuffer response:responseObj];
    self.Callback(self);
    self.Callback=nil;
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
}

-(void)Cancel
{
    if(connection!=nil)
    {
        [connection cancel];
        connection=nil;
        self.Callback=nil;
    }
}


-(void) prepareRequest:(NSMutableURLRequest*)__requestObj
{
    NSData *__soapMessageData=nil;
    {
        __soapMessageData=[[self getEnvelopeString] dataUsingEncoding:NSUTF8StringEncoding];
        [__requestObj addValue: soapVersion==SOAPVERSION_12?@"application/soap+xml; charset=utf-8":@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }

    NSString *msgLength = [NSString stringWithFormat:@"%u", [__soapMessageData length]];
    [__requestObj addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [__requestObj setHTTPBody: __soapMessageData];
}
-(void) setBinary:(DDXMLNode*)propertyElement data:(NSData*)data isSwaRef:(BOOL)isSwaRef isAttribute:(BOOL) isAttribute
{
    [propertyElement setStringValue:[Helper base64forData:data]];
}

-(NSData*) getBinary: (DDXMLNode*)element isSwaRef:(BOOL)isSwaRef isAttribute:(BOOL) isAttribute
{
    return [Helper base64DataFromString:[element stringValue]];
}
 


-(void) addWS_addressingHeaders:(NSString*) action replyTo:(NSString*) replyTo to:(NSString*) to referenceParameters:(NSMutableArray *)referenceParameters
{
    DDXMLElement* __wsaddressingElement=[self writeElement:@"Action" URI:@"http://www.w3.org/2005/08/addressing" parent:self.Header];
    [__wsaddressingElement setStringValue:action];
    [self addAttribute:@"mustUnderstand" URI:envNS stringValue:@"1" element:__wsaddressingElement];
    __wsaddressingElement=[self writeElement:@"MessageID"  URI:@"http://www.w3.org/2005/08/addressing" parent:self.Header];
    [__wsaddressingElement setStringValue:[@"urn:uuid:" stringByAppendingString:[Helper createGuid]]];
    __wsaddressingElement=[self writeElement:@"ReplyTo" URI:@"http://www.w3.org/2005/08/addressing" parent:self.Header];
    __wsaddressingElement=[self writeElement:@"Address" URI:@"http://www.w3.org/2005/08/addressing" parent:__wsaddressingElement];
    [__wsaddressingElement setStringValue:replyTo];
    __wsaddressingElement=[self writeElement:@"To" URI:@"http://www.w3.org/2005/08/addressing" parent:self.Header];
    [__wsaddressingElement setStringValue:to ];
    [self addAttribute:@"mustUnderstand" URI:envNS stringValue:@"1" element:__wsaddressingElement];

    for (NSString* param in referenceParameters) {
        DDXMLDocument *__doc=[[DDXMLDocument alloc]  initWithXMLString:param options:0 error:nil];
        DDXMLElement *root=[__doc rootElement];
        [root detach];
        [self addAttribute:@"IsReferenceParameter" URI:@"http://www.w3.org/2005/08/addressing" stringValue:@"true" element:root];
        [self.Header addChild:root];
    }
}

-(id) getAnyTypeValue:(DDXMLElement*) node
{
    DDXMLNode* typeAttr=[Helper getAttribute:node name:@"type" url:XSI];
    if(typeAttr !=nil)
    {
        NSString* attrValue=[typeAttr stringValue];
        NSArray* splitString=[attrValue componentsSeparatedByString:@":"];
        if([splitString count]==2)
        {
            DDXMLNode* namespace=[node resolveNamespaceForName:attrValue];
            if([[namespace stringValue] isEqualToString:@"http://www.w3.org/2001/XMLSchema"])
            {
                NSString *value=(NSString *)[splitString objectAtIndex:1];
                if([value isEqualToString:@"int"] || [value isEqualToString:@"double"] || [value isEqualToString:@"float"] || [value isEqualToString:@"long"] || [value isEqualToString:@"integer"] || [value isEqualToString:@"decimal"] || [value isEqualToString:@"byte"] || [value isEqualToString:@"negativeInteger"]
                    || [value isEqualToString:@"nonNegativeInteger"] || [value isEqualToString:@"nonPositiveInteger"] || [value isEqualToString:@"positiveInteger"]
                    || [value isEqualToString:@"short"] || [value isEqualToString:@"unsignedLong"] || [value isEqualToString:@"unsignedInt" ]|| [value isEqualToString:@"unsignedShort"] || [value isEqualToString:@"unsignedByte"])
                {
                    return [Helper getNumber:[node stringValue] ];
                }
                else if([value isEqualToString:@"boolean"])
                {
                    return [NSNumber numberWithBool:[[node stringValue] isEqualToString:@"true"]];
                }
                else{
                    return [node stringValue];
                }
            }
            else
            {
                NSString* typeName=[splitString count]==2?[splitString objectAtIndex:1]:attrValue;
                if(namespace!=nil)
                {
                    NSString* classType=[NSString stringWithFormat:@"%@^^%@",[namespace stringValue],typeName];
                    Class temp=[classNames objectForKey: classType];
                    if(temp!=nil)
                    {
                        return [self createInstance:temp node:node request:self];
                    }
                }
            }
        }
    }
    return node;
}

-(void) setAnyTypeValue: (NSObject*)item propertyElement:(DDXMLElement*) propertyElement
{
    if([item conformsToProtocol:@protocol(ISerializableObject)])
    {
        id< ISerializableObject> obj1=(id< ISerializableObject>)item;
        [obj1 serialize:propertyElement __request:self];
    }
    else if([item isKindOfClass:[NSString class]])
    {
        NSString* str=(NSString*)item;
        NSString* prefix=[self getNamespacePrefix:@"http://www.w3.org/2001/XMLSchema" propertyElement:propertyElement];
        [self addAttribute:@"type" URI:@"http://www.w3.org/2001/XMLSchema-instance" stringValue:[NSString stringWithFormat:@"%@:string", prefix] element:propertyElement];
        [propertyElement setStringValue:str];
    }
    else if([item isKindOfClass:[NSNumber class]])
    {
        NSNumber *number=(NSNumber*)item;
        NSString* prefix=[self getNamespacePrefix:@"http://www.w3.org/2001/XMLSchema" propertyElement:propertyElement ];
        if (strcmp([number objCType], @encode(BOOL)) == 0)
        {
            [self addAttribute:@"type" URI:@"http://www.w3.org/2001/XMLSchema-instance" stringValue:[NSString stringWithFormat:@"%@:boolean", prefix] element:propertyElement];
            [propertyElement setStringValue:item == (void*)kCFBooleanFalse?@"false":@"true"];
        } 
        else if (strcmp([number objCType], @encode(int)) == 0) 
        {
            [self addAttribute:@"type" URI:@"http://www.w3.org/2001/XMLSchema-instance" stringValue:[NSString stringWithFormat:@"%@:int", prefix] element:propertyElement];
            [propertyElement setStringValue:[number stringValue]];
        }
        else if (strcmp([number objCType], @encode(long)) == 0) 
        {
            [self addAttribute:@"type" URI:@"http://www.w3.org/2001/XMLSchema-instance" stringValue:[NSString stringWithFormat:@"%@:long", prefix] element:propertyElement];
            [propertyElement setStringValue:[number stringValue]];
        }
        else if (strcmp([number objCType], @encode(float)) == 0) 
        {
            [self addAttribute:@"type" URI:@"http://www.w3.org/2001/XMLSchema-instance" stringValue:[NSString stringWithFormat:@"%@:float", prefix] element:propertyElement];
            [propertyElement setStringValue:[number stringValue]];
        }
        else if (strcmp([number objCType], @encode(double)) == 0) 
        {
            [self addAttribute:@"type" URI:@"http://www.w3.org/2001/XMLSchema-instance" stringValue:[NSString stringWithFormat:@"%@:double", prefix] element:propertyElement];
            [propertyElement setStringValue:[number stringValue]];
        }
        else
        {
            [self addAttribute:@"type" URI:@"http://www.w3.org/2001/XMLSchema-instance" stringValue:[NSString stringWithFormat:@"%@:long", prefix] element:propertyElement];
            [propertyElement setStringValue:[number stringValue]];
        }
    }
    else
    {
        [propertyElement setStringValue:[item description]];
    }
}
@end
