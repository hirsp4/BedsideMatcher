//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.4
//
// Created by Quasar Development at 16-04-2015
//
//---------------------------------------------------


#import "SoapError.h"

@implementation SoapError
@synthesize Details;

-(id)initWithDetails:(NSString*) faultString details:(id)details
{
    if(self = [self initWithDomain:faultString code:0 userInfo:nil])
    {
        self.Details=details;
    }
    return self;
}
@end