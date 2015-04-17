//
//  PatientViewController.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 09.04.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "PatientViewController.h"
#import "PrescriptionTableViewCell.h"
#import "SupplyChainServicePortBinding.h"
#import "trspPrescription.h"
#import "trspMedication.h"

@interface PatientViewController (){
    NSMutableArray *prescriptions;
}

@end

@implementation PatientViewController
@synthesize nameLabel,firstnameLabel,genderLabel,birthdateLabel,navBar,patientImage,name,firstname,birthdate,pid,gender,image,stationLabel,station,patientView,prescriptionView,segmentedControl,prescriptionTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    nameLabel.text=name;
    firstnameLabel.text=firstname;
    patientImage.image=image;
    birthdateLabel.text=birthdate;
    genderLabel.text=gender;
    stationLabel.text=station;
    [self setBackButtonAndTitle];
    
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
    self.utilityView.layer.borderWidth = borderWidth;
    self.mainView.autoresizesSubviews=NO;
    [self.utilityView.layer addSublayer:self.scanView.layer];
    [self.utilityView bringSubviewToFront:self.scanView];
    [self.scanView.layer addSublayer:self.capture.layer];
    [self.scanView bringSubviewToFront:self.scanRectView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.capture.delegate = self;
    self.capture.layer.frame = self.utilityView.bounds;
    
    [self performFetch];
    
    //CGAffineTransform captureSizeTransform = CGAffineTransformMakeScale(320 / self.view.frame.size.width, 480 / self.view.frame.size.height);
    //self.capture.scanRect = CGRectApplyAffineTransform(self.scanRectView.frame, captureSizeTransform);
}

// Customize the number of sections in the table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Customize the number of rows in the section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return prescriptions.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string =[[[@"Verordnungen für: " stringByAppendingString:name]stringByAppendingString:@" "]stringByAppendingString:firstname];
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:0.85 green:0.84 blue:0.84 alpha:1.0]]; //your background color...
    return view;
}


// Customize the appearance of table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    int val = [[prefs objectForKey:@"selectedRow"] intValue];
    static NSString *CellIdentifier = @"PrescriptionTableViewCell";
    PrescriptionTableViewCell *cell = (PrescriptionTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrescriptionTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (indexPath.row == val)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    } else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
          }
    
    [cell.cellNumberLabel setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    trspPrescription *prescription = [prescriptions objectAtIndex:indexPath.row];
    cell.dateLabel.text=[prescription getDateCreated];
    cell.nameLabel.text=@"Verordnung";
    cell.descriptionLabel.text=[prescription getSchedule];
    NSMutableArray *medications = [prescription getMedications];
    for(int i=0;i<medications.count;i++){
        trspMedication *medication = [medications objectAtIndex:i];
        NSLog(@"Description: %@",[medication getName]);
    }
    cell.backgroundColor = [UIColor colorWithRed:1.00 green:0.94 blue:0.87 alpha:1.0];
    return cell;
}
// define cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0;
}

- (void)setBackButtonAndTitle{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton addTarget:self
                action:@selector(backToBeaconView:)
      forControlEvents:UIControlEventTouchUpInside];
    backButton.bounds = CGRectMake( 0, 0, 66, 31);
    [backButton setTitle:@"< Zurück" forState:UIControlStateNormal];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle: @"Patienteninfo"];
    item.leftBarButtonItem = backButtonItem;
    [navBar pushNavigationItem:item animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) backToBeaconView: (id) sender{
    [self performSegueWithIdentifier:@"backToBeaconView" sender:self];
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
    // We got a result. Display information about the result onscreen.
    NSString *formatString = [self barcodeFormatToString:result.barcodeFormat];
    NSString *display = [NSString stringWithFormat:@"Gescannt!\n\nFormat: %@\nInhalt:\n%@", formatString, result.text];
    NSLog(@"%@",display);
    
    // Vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    [self.capture stop];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.capture start];
    });
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) performFetch{
    prescriptions =[[NSMutableArray alloc] init];
    [prescriptions removeAllObjects];
    SupplyChainServicePortBinding* service = [[SupplyChainServicePortBinding alloc]init];
    getPrescriptionsForPatientResponse *result=[service getPrescriptionsForPatient:pid __error:nil];
    for(int i=0;i<result.count;i++){
        trspPrescription *trsppresc= [result objectAtIndex:i];
        [prescriptions addObject:trsppresc];
    }
    [self.prescriptionTable reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.prescriptionTable cellForRowAtIndexPath:indexPath];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[NSNumber numberWithInt:indexPath.row] forKey:@"selectedRow"];
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [tableView reloadData];
}

- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.patientView.hidden=NO;
            self.prescriptionView.hidden=YES;
            break;
        case 1:
            self.patientView.hidden=YES;
            self.prescriptionView.hidden=NO;
            break;
        default:
            break;
    }
}
@end
