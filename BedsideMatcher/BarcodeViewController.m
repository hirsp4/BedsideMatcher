//
//  BarcodeViewController.m
//  BedsideMatcher
//
//  Class for the scanning of a patient barcode. Handles the scanned barcode and
//  initializes a patient view with the stored values for the given patient
//  in the database.
//
//  Created by Patrizia Zehnder on 01.04.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import "BarcodeViewController.h"
#import "PatientViewController.h"
#import "AppDelegate.h"
#import "Patient.h"

@interface BarcodeViewController ()

@end

@implementation BarcodeViewController
@synthesize patients,managedObjectContext,patientPID;
/**
 *  always called when view did load
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // set the back button in the navigation bar to get back to beacon view controller
    [self setBackButton];
    // get the managed object context from AppDelegate
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    // perform the fetch to get all patients from core data
    [self performFetch];
    // load and setup the capture frames
    self.capture = nil;
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.rotation = 90.0f;
    self.capture.layer.frame = self.scanRectView.frame;
    [self.scanRectView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.0]];
    CGFloat borderWidth = 2.0f;
    self.scanRectView.frame = CGRectInset(self.scanRectView.frame, -borderWidth, -borderWidth);
    self.scanRectView.layer.borderColor = [UIColor greenColor].CGColor;
    self.scanRectView.layer.borderWidth = borderWidth;
    [self.view.layer addSublayer:self.capture.layer];
    [self.view bringSubviewToFront:self.scanRectView];
    [self.view bringSubviewToFront:self.decodedLabel];
}
/**
 *  dealloc method to remove the capture layer from its superlayer
 */
- (void)dealloc {
    [self.capture.layer removeFromSuperlayer];
}
/**
 *  always called when view will appear
 *
 *  @param animated a BOOL
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hasScannedResult=NO;
    self.capture.delegate = self;
    self.capture.layer.frame = self.view.bounds;
    // transform the scan view to full screen size
    CGAffineTransform captureSizeTransform = CGAffineTransformMakeScale(320 / self.view.frame.size.width, 480 / self.view.frame.size.height);
    self.capture.scanRect = CGRectApplyAffineTransform(self.scanRectView.frame, captureSizeTransform);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  create the back button and set it in the navigation bar
 */
- (void)setBackButton{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Zurück" style:UIBarButtonItemStyleDone target:nil action:@selector(showBeaconView:)];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle: @"Barcode scannen"];
    item.leftBarButtonItem=backButton;
    [_navBarBarcode pushNavigationItem:item animated:NO];
}
/**
 *  Action method for the back button.
 *
 *  @param sender a UIButton
 */
- (IBAction)showBeaconView:(id)sender {
    [self performSegueWithIdentifier:@"showBeaconView" sender:self];
}
#pragma mark - Private Methods
/**
 *  private helper method to convert the scanned barcode formats to strings
 *
 *  @param format ZXBarcodeFormat
 *
 *  @return a NSString
 */
- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format {
    switch (format) {
        case kBarcodeFormatAztec:
            return @"Aztec";
            
        case kBarcodeFormatCodabar:
            return @"CODABAR";
            
        case kBarcodeFormatCode39:
            return @"Code 39";
            
        case kBarcodeFormatCode93:
            return @"Code 93";
            
        case kBarcodeFormatCode128:
            return @"Code 128";
            
        case kBarcodeFormatDataMatrix:
            return @"Data Matrix";
            
        case kBarcodeFormatEan8:
            return @"EAN-8";
            
        case kBarcodeFormatEan13:
            return @"EAN-13";
            
        case kBarcodeFormatITF:
            return @"ITF";
            
        case kBarcodeFormatPDF417:
            return @"PDF417";
            
        case kBarcodeFormatQRCode:
            return @"QR Code";
            
        case kBarcodeFormatRSS14:
            return @"RSS 14";
            
        case kBarcodeFormatRSSExpanded:
            return @"RSS Expanded";
            
        case kBarcodeFormatUPCA:
            return @"UPCA";
            
        case kBarcodeFormatUPCE:
            return @"UPCE";
            
        case kBarcodeFormatUPCEANExtension:
            return @"UPC/EAN extension";
            
        default:
            return @"Unknown";
    }
}

#pragma mark - ZXCaptureDelegate Methods
/**
 *  capture method of the scanner
 *
 *  @param capture ZXCapture
 *  @param result  ZXResult
 */
- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    // check if there's a valid result
    if (!result) return;
    // check hasScannedResult boolean. Needed to avoid having multiple successful scans
    // in few seconds.
    if(self.hasScannedResult == NO)
    {
        self.hasScannedResult = YES;
        [self.capture stop];
        NSString *numberString;
        // extract numbers from the scanned string (trims the first sign of the barcode which
        // is defined as a "¿"
        NSScanner *scanner = [NSScanner scannerWithString:result.text];
        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        // Throw away characters before the first number.
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        // Collect numbers.
        [scanner scanCharactersFromSet:numbers intoString:&numberString];
        // We got a result. Display information about the result onscreen.
        NSString *formatString = [self barcodeFormatToString:result.barcodeFormat];
        NSString *display = [NSString stringWithFormat:@"Gescannt!\n\nFormat: %@\nInhalt:\n%@", formatString, numberString];
        [self.decodedLabel performSelectorOnMainThread:@selector(setText:) withObject:display waitUntilDone:YES];
        NSLog(@"%@",display);
        // Vibrate
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        // set the minor id instance variable
        patientPID = [NSMutableString string];
        [patientPID appendString:numberString];
        // perform the segue to patient view
        if([self shouldPerformSegueWithIdentifier:@"scanToPatientView" sender:self]){
            [self performSegueWithIdentifier:@"scanToPatientView" sender:self];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.capture start];
        });
    }
}

/**
 *  Tap recognizer to get back to beacon view (tap because the scan view is full screen and
 *  we dont want to have buttons here).
 *
 *  @param sender UITapRecognizer
 */
- (IBAction)didTap:(id)sender {
    [self performSegueWithIdentifier:@"showBeaconView" sender:self];
}
/**
 *  gets called before the segue gets actually performed. sets all values in the destination
 *  view controller.
 *
 *  @param segue  UIStoryboardSegue
 *  @param sender
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"scanToPatientView"]) {
        // set the destination view controller
        PatientViewController *destViewController = segue.destinationViewController;
        // web service getPatientInformation
        Patient *patient = nil;
        // get the right patient from core data
        for(Patient *p in patients){
            if([p.polypointPID isEqualToString:patientPID]){
                patient=p;
            }
        }
        // if the patient is nil, no patient was found. if the patient is not nil,
        // we pass data of this patient to the destination view controller.
        if(patient!=nil){
            // pass the variables
            destViewController.name = patient.name;
            destViewController.firstname = patient.firstname;
            destViewController.birthdate = patient.birthdate;
            destViewController.gender = patient.gender;
            destViewController.station=patient.station;
            destViewController.pid=patient.polypointPID;
            destViewController.reastate = patient.reastate;
            destViewController.bloodgroup = patient.bloodgroup;
            destViewController.room=patient.room;
            destViewController.caseid=patient.caseID;
            // select the right patient image
            if([patient.gender isEqualToString:@"f"]){
                destViewController.image=[UIImage imageNamed:@"female.png"];
            }else  destViewController.image=[UIImage imageNamed:@"male.png"];
            // reset the minor id instance variable
            patientPID =nil;
        }else{
            // build the alert string to inform the user
            NSString *alertMessage=@"Es wurde kein Patient gefunden.";
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Achtung!"
                                                              message:alertMessage
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
    }
}
/**
 *  check permission to perform segue. if no patient was found, dont perform the segue!
 *
 *  @param identifier NSString
 *  @param sender     id
 *
 *  @return BOOL state
 */
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"scanToPatientView"]) {
        // web service getPatientInformation
        Patient *patient = nil;
        // get the right patient from core data
        for(Patient *p in patients){
            if([p.polypointPID isEqualToString:patientPID]){
                patient=p;
            }
        }
        if(patient ==nil){
            // build the alert string to inform the user
            NSString *alertMessage=@"Es wurde kein Patient gefunden.";
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Achtung!"
                                                              message:alertMessage
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
            return NO;
        }else{return YES;}
    }else{
        return NO;
    }
}
/**
 *  check the user interaction with the alert view
 *
 *  @param alertView   UIAlertView
 *  @param buttonIndex NSInteger
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if (buttonIndex == 0)
        {
            [self.decodedLabel setText:@""];
            self.hasScannedResult=NO;
        }
        else
        {
            NSLog(@"user pressed Button Indexed 1");
        }
}

/**
 *  get the patients from core data.
 */
-(void)performFetch{
    NSFetchRequest *fetchRequestPatient = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Patient" inManagedObjectContext:managedObjectContext];
    [fetchRequestPatient setEntity:entity];
    NSError *error;
    self.patients = [managedObjectContext executeFetchRequest:fetchRequestPatient error:&error];
}

@end
