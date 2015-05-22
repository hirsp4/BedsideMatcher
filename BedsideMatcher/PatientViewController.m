//
//  PatientViewController.m
//  BedsideMatcher
//
//  View controller for the visualization of patient information. The view consists of
//  a segmented controler (general patient information and prescription informations / scanning).
//
//  Created by Fresh Prince on 09.04.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "PatientViewController.h"
#import "PrescriptionTableViewCell.h"
#import "SupplyChainServicePortBinding.h"
#import "trspPrescription.h"
#import "trspMedication.h"
#import "prescriptionState.h"


@interface PatientViewController (){
    NSMutableArray *prescriptions;
}

@end

@implementation PatientViewController
@synthesize nameLabel,firstnameLabel,genderLabel,birthdateLabel,navBar,patientImage,name,firstname,birthdate,caseid,reastate,bloodgroup,room,pid,gender,image,stationLabel,station,patientView,prescriptionView,segmentedControl,prescriptionTable, roomLabel,pidLabel,fidLabel,bloodgroupLabel,reaLabel;
/**
 *  always called when view did load
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // fill the labels with the values of the instance variables
    nameLabel.text=name;
    firstnameLabel.text=firstname;
    patientImage.image=image;
    birthdateLabel.text=[[[[self getBirthdateString]stringByAppendingString:@" ("]stringByAppendingString:[self getAgeFromDateString:[self getBirthdateString]]]stringByAppendingString:@")"];
    genderLabel.text=gender;
    stationLabel.text=[self getStationString];
    roomLabel.text=room;
    pidLabel.text=pid;
    fidLabel.text=caseid;
    reaLabel.text=reastate;
    bloodgroupLabel.text=[self getBloodGroupString];
    // set the title of the navigation bar and add a back button
    [self setBackButtonAndTitle];
    
    // setup the scan view to scan for prescriptions
    self.hasScannedResult=YES;
    [self.capture.layer removeFromSuperlayer];
    self.capture = [[ZXCapture alloc] init];
    [self.capture stop];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.rotation = 90.0f;
    self.capture.layer.frame = self.utilityView.bounds;
    [self.scanRectView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.0]];
    CGFloat borderWidth = 2.0f;
    self.scanView.frame = CGRectInset(self.scanView.frame, -borderWidth, -borderWidth);
    self.scanRectView.layer.borderColor = [UIColor greenColor].CGColor;
    self.scanRectView.layer.borderWidth = borderWidth;
    self.utilityView.layer.borderColor = [UIColor blackColor].CGColor;
    borderWidth = 1.0f;
    self.utilityView.layer.borderWidth = borderWidth;
    self.mainView.autoresizesSubviews=NO;
    [self.utilityView.layer addSublayer:self.scanView.layer];
    [self.utilityView bringSubviewToFront:self.scanView];
    [self.scanView.layer addSublayer:self.capture.layer];
    [self.scanView bringSubviewToFront:self.scanRectView];
    
}
/**
 *  always called when view will appear
 *
 *  @param animated BOOL
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.capture.delegate = self;
    self.capture.layer.frame = self.utilityView.bounds;
    // get prescriptions from the webservice
    [self performFetch];
}
/**
 *  Customize the number of sections in the table view
 *
 *  @param tableView UITableView
 *
 *  @return NSInteger number of sections
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
/**
 *  Customize the number of rows in the section
 *
 *  @param tableView UITableView
 *  @param section   NSInteger
 *
 *  @return NSInteger number of rows in section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return prescriptions.count;
}
/**
 *  Sets and returns the view for the header in the specified section.
 *
 *  @param tableView UITableView
 *  @param section   NSInteger
 *
 *  @return UIView view for the header in the specified section
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 38)];
    // Create custom view to display section header...
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:14]];
    NSString *string =[[[@"Verordnungen für: " stringByAppendingString:name]stringByAppendingString:@" "]stringByAppendingString:firstname];
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:0.85 green:0.84 blue:0.84 alpha:1.0]];
    return view;
}
/**
 *  Customize the appearance of table view cells
 *
 *  @param tableView UITableView
 *  @param indexPath NSIndexPath
 *
 *  @return UITableViewCell custom cell of class "PrescriptionTableViewCell.h"
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // get the selected row in  user defaults
    int val = [[prefs objectForKey:@"selectedRow"] intValue];
    static NSString *CellIdentifier = @"PrescriptionTableViewCell";
    PrescriptionTableViewCell *cell = (PrescriptionTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrescriptionTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // ensure that only one cell can be selected with accessory checkmark
    if (indexPath.row == val)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    } else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    // set the info button and tag it
    cell.infoButton.tag=indexPath.row;
    [cell.infoButton addTarget:self
               action:@selector(showInfoAlert:) forControlEvents:UIControlEventTouchDown];
    [cell.cellNumberLabel setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    trspPrescription *prescription = [prescriptions objectAtIndex:indexPath.row];
    // set the prescription labels of the cell
    cell.dateLabel.text=[prescription getDateCreated];
    cell.nameLabel.text=@"Verordnung";
    cell.descriptionLabel.text=[prescription getDescription];
    if([[[prescription getPrescriptionState]stringValue]isEqualToString:@"stopped"]){
        cell.backgroundColor = [UIColor greenColor];
    }else cell.backgroundColor = [UIColor colorWithRed:1.00 green:0.94 blue:0.87 alpha:1.0];

    return cell;
}
/**
 *  customizing the row height
 *
 *  @param tableView UITableView
 *  @param indexPath NSIndexPath
 *
 *  @return CGFloat height for the row at a specific index path
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0;
}
/**
 *  set the back button and the title of the navigation bar
 */
- (void)setBackButtonAndTitle{
    // initialize button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton addTarget:self
                action:@selector(backToBeaconView:)
      forControlEvents:UIControlEventTouchUpInside];
    backButton.bounds = CGRectMake( 0, 0, 66, 31);
    [backButton setTitle:@"< Zurück" forState:UIControlStateNormal];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    // set the title in the navigation bar
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle: @"Patienteninfo"];
    item.leftBarButtonItem = backButtonItem;
    [navBar pushNavigationItem:item animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  action method for the back button
 *
 *  @param sender UIButton
 */
- (void) backToBeaconView: (id) sender{
    // remove the capture layer from the superlayer
    [self.capture.layer removeFromSuperlayer];
    self.hasScannedResult = YES;
    [self performSegueWithIdentifier:@"backToBeaconView" sender:self];
}

#pragma mark - Private Methods
/**
 *  private helper method to convert the scanned barcode formats to strings
 *
 *  @param format ZXBarcodeFormat
 *
 *  @return NSString
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
    // check if we have a valid result
    if (!result) return;
    // check hasScannedResult boolean. Needed to avoid having multiple successful scans
    // in few seconds.
    if(self.hasScannedResult == NO)
    {
        self.hasScannedResult = YES;
        // We got a result. Display information about the result onscreen.
        NSString *formatString = [self barcodeFormatToString:result.barcodeFormat];
        NSString *display = [NSString stringWithFormat:@"Gescannt!\n\nFormat: %@\nInhalt:\n%@", formatString, result.text];
        NSLog(@"%@",display);

        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        trspPrescription *presc = [prescriptions objectAtIndex:[[prefs objectForKey:@"selectedRow"]integerValue]];

        NSString *vid =presc.polypointID;
        NSString *numberString;
        // extract numbers from the scanned string (trims the first sign of the barcode which
        // is defined as a "¿"
        NSScanner *scanner = [NSScanner scannerWithString:result.text];
        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        // Throw away characters before the first number.
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        // Collect numbers.
        [scanner scanCharactersFromSet:numbers intoString:&numberString];

        if([vid isEqualToString:numberString]){
            SupplyChainServicePortBinding* service = [[SupplyChainServicePortBinding alloc]init];
            trspPrescription *sendingPresc = [prescriptions objectAtIndex:[[prefs objectForKey:@"selectedRow"]integerValue]];
            for (trspPreparedMedication *med in sendingPresc.getMedications) {
                
            }
            
            mediPrepResult *result= [service updateDispensedMedication:sendingPresc arg1:@"7640166731078" __error:nil]; //GLN Station A: 7640166731078
            
            [[prescriptions objectAtIndex:[[prefs objectForKey:@"selectedRow"]integerValue]]setPrescriptionState:[prescriptionState createWithString:@"stopped"]];
            NSLog(@"%@",[[[prescriptions objectAtIndex:[[prefs objectForKey:@"selectedRow"]integerValue]]getPrescriptionState]stringValue]);
            [self.prescriptionTable reloadData];
        }else{
            NSString *alertMessage = @"Die Verordnung und die gescannte Etikette stimmen nicht überein. Überprüfen Sie ob die richtige Verordnung vorliegt.";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Zuweisung fehlerhaft"
                                                            message:alertMessage
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            alert.tag=0;
            [alert show];

        }
        
        // Vibrate
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        [self.capture stop];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.capture start];
        });
    }
}
/**
 *  get all prescriptions for the selected patient from supply chain service.
 */
-(void) performFetch{
    prescriptions =[[NSMutableArray alloc] init];
    [prescriptions removeAllObjects];
    SupplyChainServicePortBinding* service = [[SupplyChainServicePortBinding alloc]init];
    getPreparedPrescriptionsForPatientResponse *result=[service getPreparedPrescriptionsForPatient:pid __error:nil];
    for(int i=0;i<result.count;i++){
        trspPrescription *trsppresc= [result objectAtIndex:i];
        [prescriptions addObject:trsppresc];
    }
    [self.prescriptionTable reloadData];
}
/**
 *  handle the user selections and set the accessory checkmark
 *
 *  @param tableView UITableView
 *  @param indexPath NSIndexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.prescriptionTable cellForRowAtIndexPath:indexPath];
    // save the selected index
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[NSNumber numberWithInt:indexPath.row] forKey:@"selectedRow"];
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    // force table view to reload the content
    [tableView reloadData];
}
/**
 *  managing the views of the segmented control
 *
 *  @param sender UISegmentedControl
 */
- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0: // segment "Patient"
            self.patientView.hidden=NO;
            self.prescriptionView.hidden=YES;
            [self.capture.layer removeFromSuperlayer];
            break;
        case 1: // segment "Verordnungen"
            self.patientView.hidden=YES;
            self.prescriptionView.hidden=NO;
            self.hasScannedResult=NO;
            break;
                // should never happen, just some default stuff
        default:
            break;
    }
}
/**
 *  show information for a selected prescription row to the user
 *
 *  @param sender UIButton
 */
-(void)showInfoAlert:(UIButton*)sender
{
    // get the selected prescriptions and build an alert message
    // for the medications in the prescription
    trspPrescription *prescription = [prescriptions objectAtIndex:sender.tag];
    NSMutableArray *medications = [prescription getMedications];
    NSString *alertMessage=@"Die Verordnung besteht aus den folgenden Komponenten: \n\n";
    for(int i=0;i<medications.count;i++){
        trspMedication *medication = [medications objectAtIndex:i];
        alertMessage=[alertMessage stringByAppendingString:@"- "];
        alertMessage=[alertMessage stringByAppendingString:[medication getName]];
        alertMessage=[alertMessage stringByAppendingString:@"\n"];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inhalt"
                                                    message:alertMessage
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
/**
 *  dealloc method to remove capture layer from superlayer
 */
- (void)dealloc {
    [self.capture.layer removeFromSuperlayer];
}
/**
 *  Translater method for bloodgroup values.
 *
 *  @return NSString translated bloodgroup
 */
-(NSString*)getBloodGroupString{
    if([bloodgroup isEqualToString:@"Apositive"]){
        return @"A+";
    }else if([bloodgroup isEqualToString:@"Bpositive"]){
        return @"B+";
    }else if([bloodgroup isEqualToString:@"AB"]){
        return @"AB";
    }else if([bloodgroup isEqualToString:@"ZeroNegative"]){
        return @"0-";
    }else if([bloodgroup isEqualToString:@"ZeroPositive"]){
        return @"0+";
    }else{
        return @"Unbekannt";
    }

}
/**
 *  extracts the station identifer e.g. "A" or "B" from the station string ("Station A" or "Station B")
 *
 *  @return a NSString holding the identifier e.g. "A" or "B"
 */
-(NSString*)getStationString{
    NSString *stationString = station;
    if([stationString isEqualToString:@""]){
        return @"";
    }
    NSArray *stationSplitted = [stationString componentsSeparatedByString:@" "];
    return stationSplitted[1];
}
/**
 *  converts NSString values of the birthdate (cosmetical issues)
 *
 *  @return a NSString of format dd.mm.yyyy
 */
-(NSString*)getBirthdateString{
    NSString *birthdateString = birthdate;
    if([birthdateString isEqualToString:@""]){
        return @"Unbekannt";
    }
    NSArray *birthdateSplitted = [birthdateString componentsSeparatedByString:@"-"];
    return [[[[birthdateSplitted[2] stringByAppendingString:@"."]stringByAppendingString:birthdateSplitted[1]]stringByAppendingString:@"."]stringByAppendingString:birthdateSplitted[0]];
}
/**
 *  calculates the age of a patient based on a given date of birth (dd.MM.yyyy)
 *
 *  @param dateOfBirth a birthdate of format dd.MM.yyyy
 *
 *  @return NSString age in years
 */
-(NSString *)getAgeFromDateString:(NSString*)dateOfBirth{
    NSLog(@"%@",dateOfBirth);
    if ([dateOfBirth isEqualToString:@"Unbekannt"]) {
        return @"?";
    }
    if ([dateOfBirth isEqualToString:@""]) {
        return @"?";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is important - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateOfBirth];
    NSDate *today = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:dateFromString
                                       toDate:today
                                       options:0];
    return [NSString stringWithFormat:@"%ld",(long)ageComponents.year];
}

/**
 *  check the user interaction with the alert view
 *
 *  @param alertView   UIAlertView
 *  @param buttonIndex NSInteger
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==0) {
        if (buttonIndex == 0)
        {
            self.hasScannedResult=NO;
        }
    }
}

@end
