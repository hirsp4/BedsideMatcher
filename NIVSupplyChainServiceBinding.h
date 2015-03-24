//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.2
//
// Created by Quasar Development at 10-03-2015
//
//---------------------------------------------------



#import <Foundation/Foundation.h>

#import "NIVwebServiceResult.h"
#import "NIVcheckinItems.h"
#import "NIVorder.h"
#import "NIVcheckoutItems.h"
#import "NIVinsertTrackingItems.h"
#import "NIVgetItemsBySSCCResponse.h"
#import "DDXML.h"

@class NIVRequestResultHandler;

@protocol NIVSoapServiceResponse < NSObject>
- (void) onSuccess: (id) value methodName:(NSString*)methodName;
- (void) onError: (NSError*) error;
@end


@interface NIVSupplyChainServiceBinding : NSObject
    
@property (retain, nonatomic) NSDictionary* Headers;
@property (retain, nonatomic) NSString* Url;
@property (nonatomic) BOOL ShouldAddAdornments;
@property BOOL EnableLogging;

- (id) init;
- (id) initWithUrl: (NSString*) url;

-(NSMutableURLRequest*) createsayHelloWorldFromRequest:(NSString*) arg0 __request:(NIVRequestResultHandler*) __request;
-(NSString*) sayHelloWorldFrom:(NSString*) arg0 __error:(NSError**) __error;
-(NIVRequestResultHandler*) sayHelloWorldFromAsync:(NSString*) arg0 __target:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) sayHelloWorldFromAsync:(NSString*) arg0 __target:(id<NIVSoapServiceResponse>) __target;
-(NSMutableURLRequest*) creategetCheckedInItemsRequest:(NSString*) arg0 __request:(NIVRequestResultHandler*) __request;
-(NIVwebServiceResult*) getCheckedInItems:(NSString*) arg0 __error:(NSError**) __error;
-(NIVRequestResultHandler*) getCheckedInItemsAsync:(NSString*) arg0 __target:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) getCheckedInItemsAsync:(NSString*) arg0 __target:(id<NIVSoapServiceResponse>) __target;
-(NSMutableURLRequest*) createcheckinItemsRequest:(NIVcheckinItems*) checkinItems __request:(NIVRequestResultHandler*) __request;
-(NIVwebServiceResult*) checkinItems:(NIVcheckinItems*) checkinItems __error:(NSError**) __error;
-(NIVRequestResultHandler*) checkinItemsAsync:(NIVcheckinItems*) checkinItems __target:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) checkinItemsAsync:(NIVcheckinItems*) checkinItems __target:(id<NIVSoapServiceResponse>) __target;
-(NSMutableURLRequest*) createsetOrderRequest:(NIVorder*) arg0 arg1:(NSString*) arg1 arg2:(NSString*) arg2 __request:(NIVRequestResultHandler*) __request;
-(NSNumber*) setOrder:(NIVorder*) arg0 arg1:(NSString*) arg1 arg2:(NSString*) arg2 __error:(NSError**) __error;
-(NIVRequestResultHandler*) setOrderAsync:(NIVorder*) arg0 arg1:(NSString*) arg1 arg2:(NSString*) arg2 __target:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) setOrderAsync:(NIVorder*) arg0 arg1:(NSString*) arg1 arg2:(NSString*) arg2 __target:(id<NIVSoapServiceResponse>) __target;
-(NSMutableURLRequest*) createcheckoutItemsRequest:(NIVcheckoutItems*) checkoutItems __request:(NIVRequestResultHandler*) __request;
-(NIVwebServiceResult*) checkoutItems:(NIVcheckoutItems*) checkoutItems __error:(NSError**) __error;
-(NIVRequestResultHandler*) checkoutItemsAsync:(NIVcheckoutItems*) checkoutItems __target:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) checkoutItemsAsync:(NIVcheckoutItems*) checkoutItems __target:(id<NIVSoapServiceResponse>) __target;
-(NSMutableURLRequest*) createinsertTrackingItemsRequest:(NIVinsertTrackingItems*) insertTrackingItems __request:(NIVRequestResultHandler*) __request;
-(void) insertTrackingItems:(NIVinsertTrackingItems*) insertTrackingItems __error:(NSError**) __error;
-(NIVRequestResultHandler*) insertTrackingItemsAsync:(NIVinsertTrackingItems*) insertTrackingItems __target:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) insertTrackingItemsAsync:(NIVinsertTrackingItems*) insertTrackingItems __target:(id<NIVSoapServiceResponse>) __target;
-(NSMutableURLRequest*) creategetItemsBySSCCRequest:(NSString*) arg0 __request:(NIVRequestResultHandler*) __request;
-(NIVgetItemsBySSCCResponse*) getItemsBySSCC:(NSString*) arg0 __error:(NSError**) __error;
-(NIVRequestResultHandler*) getItemsBySSCCAsync:(NSString*) arg0 __target:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) getItemsBySSCCAsync:(NSString*) arg0 __target:(id<NIVSoapServiceResponse>) __target;
-(NSString*) processOrder:(NSString*) arg0 arg1:(NSString*) arg1 arg2:(NSString*) arg2 __error:(NSError**) __error;
-(NIVRequestResultHandler*) processOrderAsync:(NSString*) arg0 arg1:(NSString*) arg1 arg2:(NSString*) arg2 __target:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) processOrderAsync:(NSString*) arg0 arg1:(NSString*) arg1 arg2:(NSString*) arg2 __target:(id<NIVSoapServiceResponse>) __target;
-(NSString*) getQuantities:(NSString*) arg0 __error:(NSError**) __error;
-(NIVRequestResultHandler*) getQuantitiesAsync:(NSString*) arg0 __target:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) getQuantitiesAsync:(NSString*) arg0 __target:(id<NIVSoapServiceResponse>) __target;
-(NSString*) getOpenOrdersByGLN:(NSString*) arg0 __error:(NSError**) __error;
-(NIVRequestResultHandler*) getOpenOrdersByGLNAsync:(NSString*) arg0 __target:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) getOpenOrdersByGLNAsync:(NSString*) arg0 __target:(id<NIVSoapServiceResponse>) __target;
-(NSString*) getItemByIdentifier:(NSString*) arg0 arg1:(NSString*) arg1 __error:(NSError**) __error;
-(NIVRequestResultHandler*) getItemByIdentifierAsync:(NSString*) arg0 arg1:(NSString*) arg1 __target:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) getItemByIdentifierAsync:(NSString*) arg0 arg1:(NSString*) arg1 __target:(id<NIVSoapServiceResponse>) __target;
-(NSString*) getItemsByBatch:(NSString*) arg0 arg1:(NSString*) arg1 arg2:(NSString*) arg2 __error:(NSError**) __error;
-(NIVRequestResultHandler*) getItemsByBatchAsync:(NSString*) arg0 arg1:(NSString*) arg1 arg2:(NSString*) arg2 __target:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) getItemsByBatchAsync:(NSString*) arg0 arg1:(NSString*) arg1 arg2:(NSString*) arg2 __target:(id<NIVSoapServiceResponse>) __target;
-(NSString*) getOrderForSSCC:(NSString*) arg0 __error:(NSError**) __error;
-(NIVRequestResultHandler*) getOrderForSSCCAsync:(NSString*) arg0 __target:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) getOrderForSSCCAsync:(NSString*) arg0 __target:(id<NIVSoapServiceResponse>) __target;
-(void) resetTrackedItems:(NSError**) __error;
-(NIVRequestResultHandler*) resetTrackedItemsAsync:(id) __target __handler:(SEL) __handler;
-(NIVRequestResultHandler*) resetTrackedItemsAsync:(id<NIVSoapServiceResponse>) __target;
-(NIVRequestResultHandler*) CreateRequestResultHandler;   
-(NSMutableURLRequest*) createRequest :(NSString*) soapAction __request:(NIVRequestResultHandler*) __request; 
-(void) sendImplementation:(NSMutableURLRequest*) request requestMgr:(NIVRequestResultHandler*) requestMgr; 
-(void) sendImplementation:(NSMutableURLRequest*) request requestMgr:(NIVRequestResultHandler*) requestMgr callback:(void (^)(NIVRequestResultHandler *)) callback;

@end