//
//  BarcodeViewController.m
//  BedsideMatcher
//
//  Created by Patrizia Zehnder on 01/04/15.
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
@synthesize patients,managedObjectContext,minorID;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setBackButton];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    [self performFetch];
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.capture.delegate = self;
    self.capture.layer.frame = self.view.bounds;
    
    CGAffineTransform captureSizeTransform = CGAffineTransformMakeScale(320 / self.view.frame.size.width, 480 / self.view.frame.size.height);
    self.capture.scanRect = CGRectApplyAffineTransform(self.scanRectView.frame, captureSizeTransform);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// create Back-Button
- (void)setBackButton{
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Zurück" style:UIBarButtonItemStyleDone target:nil action:@selector(showBeaconView:)];
    
        UINavigationItem *item = [[UINavigationItem alloc] initWithTitle: @"Barcode scannen"];
    item.leftBarButtonItem=backButton;
    [_navBarBarcode pushNavigationItem:item animated:NO];
}

- (IBAction)showBeaconView:(id)sender {
    
    [self performSegueWithIdentifier:@"showBeaconView" sender:self];
}
#pragma mark - Private Methods

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

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    if (!result) return;
    if(self.hasScannedResult == NO)
    {
        self.hasScannedResult = YES;
        [self.capture stop];
        
         // Intermediate
    NSString *numberString;
    
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
    minorID = [NSMutableString string];
    [minorID appendString:numberString];
    [self performSegueWithIdentifier:@"scanToPatientView" sender:self];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.capture start];
    });
    }
    
    
   
}

- (IBAction)didTap:(id)sender {
    [self performSegueWithIdentifier:@"showBeaconView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"scanToPatientView"]) {
        PatientViewController *destViewController = segue.destinationViewController;
        // web service getPatientInformation
        Patient *patient = nil;
        for(Patient *p in patients){
            if([p.minorid isEqualToString:minorID]){
                patient=p;
            }
        }
        if(patient!=nil){
           destViewController.name = patient.name;
        destViewController.firstname = patient.firstname;
        destViewController.birthdate = patient.birthdate;
        destViewController.gender = patient.gender;
        destViewController.station=patient.station;
            if([patient.gender isEqualToString:@"f"]){
                destViewController.image=[UIImage imageNamed:@"female.png"];
            }else  destViewController.image=[UIImage imageNamed:@"male.png"];
        minorID =nil; 
        }else{
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
-(void)performFetch{
    NSFetchRequest *fetchRequestPatient = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Patient" inManagedObjectContext:managedObjectContext];
    [fetchRequestPatient setEntity:entity];
    NSError *error;
    self.patients = [managedObjectContext executeFetchRequest:fetchRequestPatient error:&error];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
