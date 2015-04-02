//
//  DetailBeaconViewController.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 02.04.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "DetailBeaconViewController.h"
#import "snfsdk.h"

@interface DetailBeaconViewController ()

@end

@implementation DetailBeaconViewController
@synthesize theDevice, cntBtn, statusLbl;

NSTimer* timer;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateScreen) userInfo:NULL repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//next to methods are to update based on the beacon state. If you wanted something to be triggered with any given beacon
//when it connects/ disconnects then you'd use the same switch idea (but do it in didChange state in the App Delegate)
- (void)updateScreen{
    switch (theDevice.state) {
        case LE_DEVICE_STATE_CONNECTED:
            statusLbl.text = @"Connected";
            break;
            
        case LE_DEVICE_STATE_CONNECTING:
            statusLbl.text = @"Connecting";
            break;
        case LE_DEVICE_STATE_DISCONNECTED:
            statusLbl.text = @"Disconnected";
            break;
            
        default: //firmware update
            statusLbl.text = [NSString stringWithFormat:@"Firmware Upadate: %.2f", theDevice.fwloadProgress];
            break;
    }
}

- (IBAction)connectOrDisconnect:(id)sender {
    switch (theDevice.state) {
        case LE_DEVICE_STATE_CONNECTED:
        case LE_DEVICE_STATE_CONNECTING:
            [theDevice disconnect];
            [cntBtn setTitle:@"Connect" forState:UIControlStateNormal];
            break;
            
        case LE_DEVICE_STATE_DISCONNECTED:
            [theDevice connect];
            [cntBtn setTitle:@"Disconnect" forState:UIControlStateNormal];
            break;
            
        default:
            //LE_DEVICE_STATE_UPDATING_FIRMWARE so just let it be
            break;
    }
}

- (IBAction)pageBeacon:(id)sender {
    [theDevice enableAlertSound:YES light:YES]; //if connect page ... else nothing will happen
}


- (IBAction)showBeaconTab:(id)sender {
    [self performSegueWithIdentifier:@"showBeaconTable" sender:self];
}
@end
