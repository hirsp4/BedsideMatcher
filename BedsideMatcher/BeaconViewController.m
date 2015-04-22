//
//  BeaconViewController.m
//  BedsideMatcher
//
//  Modified by Patrick Hirschi on 11.03.2015.
//
//  Main view controller of the application. Provides the possibility to perform bluetooth scans
//  for patients and display them in a table view. Alternatively the user can press the navigation bar
//  button to get to the BarcodeViewController and select the patient with a barcode scan.
//
//  Originally Created by Nick Toumpelis on 2013-10-06.
//  Copyright (c) 2013-2014 Nick Toumpelis.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "BeaconViewController.h"
#import "AppDelegate.h"
#import "Patient.h"
#import "PatientViewController.h"

// set the beacon region UUID and location identifier (beacons have to be configured to this UUID and the below location
// to be detected).
static NSString * const kUUID = @"4661D06A-9E38-4367-8BA2-2C72DE319164";
static NSString * const kIdentifier = @"BFH";
// set the cell identifiers
static NSString * const kOperationCellIdentifier = @"OperationCell";
static NSString * const kBeaconCellIdentifier = @"BeaconCell";

static NSString * const kRangingOperationTitle = @"Patientensuche";
static NSUInteger const kNumberOfSections = 2;
static NSUInteger const kNumberOfAvailableOperations = 1;
static CGFloat const kOperationCellHeight = 44;
static CGFloat const kBeaconCellHeight = 52;
static NSString * const kBeaconSectionTitle = @"Suche nach Patienten...";
static CGPoint const kActivityIndicatorPosition = (CGPoint){205, 12};
static NSString * const kBeaconsHeaderViewIdentifier = @"BeaconsHeader";

static void * const kMonitoringOperationContext = (void *)&kMonitoringOperationContext;
static void * const kRangingOperationContext = (void *)&kRangingOperationContext;

typedef NS_ENUM(NSUInteger, NTSectionType) {
    NTOperationsSection,
    NTDetectedBeaconsSection
};

typedef NS_ENUM(NSUInteger, NTOperationsRow) {
    NTRangingRow
};
@interface BeaconViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic, strong) NSArray *detectedBeacons;
@property (nonatomic, weak) UISwitch *rangingSwitch;
@property (nonatomic, unsafe_unretained) void *operationContext;

@end

@implementation BeaconViewController
@synthesize patients,managedObjectContext;
/**
 *  always called when the view did load
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // geth the managed object context from AppDelegate
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    // get the patients from core data
    [self performFetch];
    // set the button to get to barcode view
    [self setBarcodeButton];
}

/**
 *  create and set the barcode button in the navigation bar
 */
- (void)setBarcodeButton{
    // setup the barcode button
    UIImage *barcodeImage = [[UIImage imageNamed:@"barcode.png"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    UIButton *barcode = [UIButton buttonWithType:UIButtonTypeCustom];
    [barcode addTarget:self
                action:@selector(showBarcodeView:)
      forControlEvents:UIControlEventTouchUpInside];
    barcode.bounds = CGRectMake( 0, 0, 36, 31);
    [barcode setImage:barcodeImage forState:UIControlStateNormal];
    UIBarButtonItem *barcodeButton = [[UIBarButtonItem alloc] initWithCustomView:barcode];
    // set the view title
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle: @"Patienten in der Nähe"];
    item.leftBarButtonItem = barcodeButton;
    [_navBarBeacon pushNavigationItem:item animated:NO];
}
/**
 *  Action method for the barcode button.
 *
 *  @param sender UIButton
 */
- (IBAction)showBarcodeView:(id)sender {
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    [self performSegueWithIdentifier:@"showBarcodeView" sender:self];
}
/**
 *  get the patients from core data
 */
-(void)performFetch{
    NSFetchRequest *fetchRequestPatient = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Patient" inManagedObjectContext:managedObjectContext];
    [fetchRequestPatient setEntity:entity];
    NSError *error;
    self.patients = [managedObjectContext executeFetchRequest:fetchRequestPatient error:&error];
}

#pragma mark - Index path management
/**
 *  Returns an array of all index paths of the removed beacons
 *
 *  @param beacons NSArray of beacons
 *
 *  @return NSArray with the index paths of all removed beacons
 */
- (NSArray *)indexPathsOfRemovedBeacons:(NSArray *)beacons
{
    // initialize the array
    NSMutableArray *indexPaths = nil;
    NSUInteger row = 0;
    // iterate over all detected beacons and check if they still exist
    for (CLBeacon *existingBeacon in self.detectedBeacons) {
        BOOL stillExists = NO;
        for (CLBeacon *beacon in beacons) {
            if ((existingBeacon.major.integerValue == beacon.major.integerValue) &&
                (existingBeacon.minor.integerValue == beacon.minor.integerValue)) {
                stillExists = YES;
                break;
            }
        }
        if (!stillExists) {
            if (!indexPaths)
                indexPaths = [NSMutableArray new];
            [indexPaths addObject:[NSIndexPath indexPathForRow:row inSection:NTDetectedBeaconsSection]];
        }
        row++;
    }
    return indexPaths;
}
/**
 *  Returns an array of all index paths of the inserted beacons
 *
 *  @param beacons NSArray of beacons
 *
 *  @return NSArray with the index paths of all inserted beacons
 */
- (NSArray *)indexPathsOfInsertedBeacons:(NSArray *)beacons
{
    // initialize the array
    NSMutableArray *indexPaths = nil;
    NSUInteger row = 0;
    // iterate over all detected beacons and check if they are new
    for (CLBeacon *beacon in beacons) {
        BOOL isNewBeacon = YES;
        for (CLBeacon *existingBeacon in self.detectedBeacons) {
            if ((existingBeacon.major.integerValue == beacon.major.integerValue) &&
                (existingBeacon.minor.integerValue == beacon.minor.integerValue)) {
                isNewBeacon = NO;
                break;
            }
        }
        if (isNewBeacon) {
            if (!indexPaths)
                indexPaths = [NSMutableArray new];
            [indexPaths addObject:[NSIndexPath indexPathForRow:row inSection:NTDetectedBeaconsSection]];
        }
        row++;
    }
    return indexPaths;
}
/**
 *  handles the user selection
 *
 *  @param tableView a UITableView
 *  @param indexPath a NSIndexPath
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section!=0) {
        [self performSegueWithIdentifier:@"showPatientView" sender:[self.beaconTableView cellForRowAtIndexPath:indexPath]];
    }
}
/**
 *  pass patient data to destination view controller
 *
 *  @param segue  UIStoryboardSegue
 *  @param sender
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPatientView"]) {
        UITableViewCell *cell =sender;
        PatientViewController *destViewController = segue.destinationViewController;
        // split the detail string of the beacon cell in table view and
        // set the destination view controllers instance variables.
        NSArray *detailSplitted = [cell.detailTextLabel.text componentsSeparatedByString: @" "];
        Patient *patient = [self getPatientForBeacon:detailSplitted[0]];
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
        // stop ranging for beacons because we already selected a patient!
        [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    }
}
/**
 *  returns an array of index paths for an array of beacons
 *
 *  @param beacons NSArray of beacons
 *
 *  @return NSArray of NSIndexPaths
 */
- (NSArray *)indexPathsForBeacons:(NSArray *)beacons
{
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSUInteger row = 0; row < beacons.count; row++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:row inSection:NTDetectedBeaconsSection]];
    }
    return indexPaths;
}
/**
 *  returns a set of inserted sections
 *
 *  @return NSIndexSet
 */
- (NSIndexSet *)insertedSections
{
    if (self.rangingSwitch.on && [self.beaconTableView numberOfSections] == kNumberOfSections - 1) {
        return [NSIndexSet indexSetWithIndex:1];
    } else {
        return nil;
    }
}
/**
 *  returns a set of deleted sections
 *
 *  @return NSIndexSet
 */
- (NSIndexSet *)deletedSections
{
    if (!self.rangingSwitch.on && [self.beaconTableView numberOfSections] == kNumberOfSections) {
        return [NSIndexSet indexSetWithIndex:1];
    } else {
        return nil;
    }
}
/**
 *  returns a filtered array of beacons (delete duplicates)
 *
 *  @param beacons NSArray of beacons
 *
 *  @return NSArray of filtered beacons
 */
- (NSArray *)filteredBeacons:(NSArray *)beacons
{
    // Filters duplicate beacons out; this may happen temporarily if the originating device changes its Bluetooth id
    NSMutableArray *mutableBeacons = [beacons mutableCopy];
    
    NSMutableSet *lookup = [[NSMutableSet alloc] init];
    for (int index = 0; index < [beacons count]; index++) {
        CLBeacon *curr = [beacons objectAtIndex:index];
        NSString *identifier = [NSString stringWithFormat:@"%@/%@", curr.major, curr.minor];
        
        // this is very fast constant time lookup in a hash table
        if ([lookup containsObject:identifier]) {
            [mutableBeacons removeObjectAtIndex:index];
        } else {
            [lookup addObject:identifier];
        }
    }
    
    return [mutableBeacons copy];
}

#pragma mark - Table view functionality
/**
 *  returns a formatted detail string of beacon information (used for beacons that arent yet
 *  of a specific patient)
 *
 *  @param beacon CLBeacon
 *
 *  @return NSString of beacon details
 */
- (NSString *)detailsStringForBeacon:(CLBeacon *)beacon
{
    NSString *proximity;
    switch (beacon.proximity) {
        case CLProximityNear:
            proximity = @"Nah";
            break;
        case CLProximityImmediate:
            proximity = @"Mittel";
            break;
        case CLProximityFar:
            proximity = @"Fern";
            break;
        case CLProximityUnknown:
        default:
            proximity = @"Unbekannt";
            break;
    }
    
    NSString *format = @"%@, %@ • %@ • %f • %li";
    return [NSString stringWithFormat:format, beacon.major, beacon.minor, proximity, beacon.accuracy, beacon.rssi];
}
/**
 *  returns a formatted detail string of beacon and patient information
 *
 *  @param beacon  CLBeacon
 *  @param patient Patient
 *
 *  @return NSString of beacon details
 */
- (NSString *)detailsStringForBeacon:(CLBeacon *)beacon andPatient:(Patient *)patient
{
    NSString *proximity;
    switch (beacon.proximity) {
        case CLProximityNear:
            proximity = @"Nah";
            break;
        case CLProximityImmediate:
            proximity = @"Mittel";
            break;
        case CLProximityFar:
            proximity = @"Fern";
            break;
        case CLProximityUnknown:
        default:
            proximity = @"Unbekannt";
            break;
    }
    NSString *format = @"%@, %@ • %@ • %@ • %@";
    return [NSString stringWithFormat:format, beacon.minor, patient.birthdate,[@"Geschlecht: " stringByAppendingString:patient.gender],patient.station,patient.polypointPID];
}
/**
 *  customizing the table view cells
 *
 *  @param tableView UITableView
 *  @param indexPath NSIndexPath
 *
 *  @return UITableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    // check the section
    switch (indexPath.section) {
            // set the cell with a UISwitch to start and stop ranging for beacons
        case NTOperationsSection: {
            cell = [tableView dequeueReusableCellWithIdentifier:kOperationCellIdentifier];
            switch (indexPath.row) {
                case NTRangingRow:
                default:
                    cell.textLabel.text = kRangingOperationTitle;                    
                    self.rangingSwitch = (UISwitch *)[cell.contentView viewWithTag:9999];
                    [self.rangingSwitch addTarget:self
                                           action:@selector(changeRangingState:)
                                 forControlEvents:UIControlEventValueChanged];
                    break;
            }
        }
            break;
        case NTDetectedBeaconsSection:
        default: {
            // we found a beacon and set its cell
            CLBeacon *beacon = self.detectedBeacons[indexPath.row];
            
            cell = [tableView dequeueReusableCellWithIdentifier:kBeaconCellIdentifier];
            
            if (!cell)
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:kBeaconCellIdentifier];
            NSString *name = @"Beacon";
            cell.textLabel.text = name;
            cell.detailTextLabel.text = [self detailsStringForBeacon:beacon];
            for(Patient *patient in self.patients){
                if([[beacon.minor stringValue]isEqualToString:patient.minorid]){
                    cell.textLabel.text = [[patient.firstname stringByAppendingString:@" "]stringByAppendingString:patient.name];
                    cell.detailTextLabel.text = [self detailsStringForBeacon:beacon andPatient:patient];
                    if([@"f" isEqualToString:patient.gender]){
                        cell.imageView.image = [UIImage imageNamed:@"female.png"];
                    }else{
                        cell.imageView.image = [UIImage imageNamed:@"male.png"];
                    }
                    
                }
            }
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.backgroundColor = [UIColor colorWithRed:0.847 green:0.902 blue:1 alpha:1];
        }
            break;
    }
    return cell;
}
/**
 *  returns a NSInteger holding the number of sections in the table view
 *
 *  @param tableView UITableView
 *
 *  @return NSInteger number of sections
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.rangingSwitch.on) {
        return kNumberOfSections;       // All sections visible
    } else {
        return kNumberOfSections - 1;   // Beacons section not visible
    }
}
/**
 *  returns a NSInteger holding the number of rows in a section
 *
 *  @param tableView UITableView
 *  @param section   NSInteger
 *
 *  @return NSInteger number of rows in section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case NTOperationsSection:
            return kNumberOfAvailableOperations;
        case NTDetectedBeaconsSection:
        default:
            return self.detectedBeacons.count;
    }
}
/**
 *  returns a title for the header
 *
 *  @param tableView UITableView
 *  @param section   NSInteger
 *
 *  @return NSString header title
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case NTOperationsSection:
            return nil;
        case NTDetectedBeaconsSection:
        default:
            return kBeaconSectionTitle;
    }
}
/**
 *  returns the height for a row at specific index path
 *
 *  @param tableView UITableView
 *  @param indexPath NSIndexPath
 *
 *  @return CGFloat
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case NTOperationsSection:
            return kOperationCellHeight;
        case NTDetectedBeaconsSection:
        default:
            return kBeaconCellHeight;
    }
}
/**
 *  return a view for the header in a section
 *
 *  @param tableView UITableView
 *  @param section   NSInteger
 *
 *  @return UIView view for the header in a section
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView =
    [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:kBeaconsHeaderViewIdentifier];
    // Adds an activity indicator view to the section header
    UIActivityIndicatorView *indicatorView =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [headerView addSubview:indicatorView];
    indicatorView.frame = (CGRect){kActivityIndicatorPosition, indicatorView.frame.size};
    [indicatorView startAnimating];
    return headerView;
}

#pragma mark - Common
/**
 *  creates a beacon region with specified proximity UUID and identifier
 */
- (void)createBeaconRegion
{
    if (self.beaconRegion)
        return;
    
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:kUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:kIdentifier];
    self.beaconRegion.notifyEntryStateOnDisplay = YES;
}
/**
 *  creates the location manager (if nil)
 */
- (void)createLocationManager
{
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
}

#pragma mark - Beacon ranging
/**
 *  checks the state of the ranging switch
 */
- (void)changeRangingState:sender
{
    UISwitch *theSwitch = (UISwitch *)sender;
    if (theSwitch.on) {
        [self startRangingForBeacons];
    } else {
        [self stopRangingForBeacons];
    }
}
/**
 *  starts ranging for beacons in the specified region
 */
- (void)startRangingForBeacons
{
    self.operationContext = kRangingOperationContext;
    [self createLocationManager];
    [self checkLocationAccessForRanging];
    self.detectedBeacons = [NSArray array];
    [self turnOnRanging];
}
/**
 *  turn on ranging for beacons
 */
- (void)turnOnRanging
{
    NSLog(@"Turning on ranging...");
    if (![CLLocationManager isRangingAvailable]) {
        NSLog(@"Couldn't turn on ranging: Ranging is not available.");
        self.rangingSwitch.on = NO;
        return;
    }
    if (self.locationManager.rangedRegions.count > 0) {
        NSLog(@"Didn't turn on ranging: Ranging already on.");
        return;
    }
    [self createBeaconRegion];
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
    NSLog(@"Ranging turned on for region: %@.", self.beaconRegion);
}
/**
 *  stop ranging for beacons (used for UISwitch state NO)
 */
- (void)stopRangingForBeacons
{
    if (self.locationManager.rangedRegions.count == 0) {
        NSLog(@"Didn't turn off ranging: Ranging already off.");
        return;
    }
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    NSIndexSet *deletedSections = [self deletedSections];
    self.detectedBeacons = [NSArray array];
    [self.beaconTableView beginUpdates];
    if (deletedSections)
        [self.beaconTableView deleteSections:deletedSections withRowAnimation:UITableViewRowAnimationFade];
    [self.beaconTableView endUpdates];
    NSLog(@"Turned off ranging.");
}

#pragma mark - Location manager delegate methods
/**
 *  method that is called if user changes the authorization of location manager
 *
 *  @param manager CLLocationManager
 *  @param status  CLAuthorizationStatus
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (![CLLocationManager locationServicesEnabled]) {
        if (self.operationContext == kMonitoringOperationContext) {
            NSLog(@"Couldn't turn on monitoring: Location services are not enabled.");
            return;
        } else {
            NSLog(@"Couldn't turn on ranging: Location services are not enabled.");
            self.rangingSwitch.on = NO;
            return;
        }
    }
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    switch (authorizationStatus) {
        case kCLAuthorizationStatusAuthorizedAlways:
            if (self.operationContext == kMonitoringOperationContext) {
            } else {
                self.rangingSwitch.on = YES;
            }
            return;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            if (self.operationContext == kMonitoringOperationContext) {
                NSLog(@"Couldn't turn on monitoring: Required Location Access(Always) missing.");
            } else {
                self.rangingSwitch.on = YES;
            }
            return;
        default:
            if (self.operationContext == kMonitoringOperationContext) {
                NSLog(@"Couldn't turn on monitoring: Required Location Access(Always) missing.");
                return;
            } else {
                NSLog(@"Couldn't turn on monitoring: Required Location Access(WhenInUse) missing.");
                self.rangingSwitch.on = NO;
                return;
            }
            break;
    }
}
/**
 *  called if beacons are ranged in the specified region
 *
 *  @param manager CLLocationManager
 *  @param beacons NSArray
 *  @param region  CLBeaconRegion
 */
- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region {
    NSArray *filteredBeacons = [self filteredBeacons:beacons];
    
    if (filteredBeacons.count == 0) {
        NSLog(@"No beacons found nearby.");
    } else {
        NSLog(@"Found %lu %@.", (unsigned long)[filteredBeacons count],
              [filteredBeacons count] > 1 ? @"beacons" : @"beacon");
    }
    
    NSIndexSet *insertedSections = [self insertedSections];
    NSIndexSet *deletedSections = [self deletedSections];
    NSArray *deletedRows = [self indexPathsOfRemovedBeacons:filteredBeacons];
    NSArray *insertedRows = [self indexPathsOfInsertedBeacons:filteredBeacons];
    NSArray *reloadedRows = nil;
    if (!deletedRows && !insertedRows)
        reloadedRows = [self indexPathsForBeacons:filteredBeacons];
    
    self.detectedBeacons = filteredBeacons;
    
    [self.beaconTableView beginUpdates];
    if (insertedSections)
        [self.beaconTableView insertSections:insertedSections withRowAnimation:UITableViewRowAnimationFade];
    if (deletedSections)
        [self.beaconTableView deleteSections:deletedSections withRowAnimation:UITableViewRowAnimationFade];
    if (insertedRows)
        [self.beaconTableView insertRowsAtIndexPaths:insertedRows withRowAnimation:UITableViewRowAnimationFade];
    if (deletedRows)
        [self.beaconTableView deleteRowsAtIndexPaths:deletedRows withRowAnimation:UITableViewRowAnimationFade];
    if (reloadedRows)
        [self.beaconTableView reloadRowsAtIndexPaths:reloadedRows withRowAnimation:UITableViewRowAnimationNone];
    [self.beaconTableView endUpdates];
}
/**
 *  @param manager CLLocationManager
 *  @param state   CLRegionState
 *  @param region  CLRegion
 */
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    NSString *stateString = nil;
    switch (state) {
        case CLRegionStateInside:
            stateString = @"inside";
            break;
        case CLRegionStateOutside:
            stateString = @"outside";
            break;
        case CLRegionStateUnknown:
            stateString = @"unknown";
            break;
    }
    NSLog(@"State changed to %@ for region %@.", stateString, region);
}

#pragma mark - Local notifications
- (void)sendLocalNotificationForBeaconRegion:(CLBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    
    // Notification details
    notification.alertBody = [NSString stringWithFormat:@"Entered beacon region for UUID: %@",
                              region.proximityUUID.UUIDString];   // Major and minor are not available at the monitoring stage
    notification.alertAction = NSLocalizedString(@"View Details", nil);
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}


-(Patient*)getPatientForBeacon:(NSString*)beaconID{
    NSString *numberString;
    // extract numbers from the scanned string (trims the first sign of the barcode which
    // is defined as a "¿"
    NSScanner *scanner = [NSScanner scannerWithString:beaconID];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    // Throw away characters before the first number.
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    
    // Collect numbers.
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Patient"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"minorid LIKE %@",
                              numberString];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // impossible
        //... error handling code
    }
    
    return [fetchedObjects firstObject];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheralManager
{
    if (peripheralManager.state != CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Peripheral manager is off.");
        return;
    }
    
    NSLog(@"Peripheral manager is on.");
}

#pragma mark - Location access methods (iOS8/Xcode6)
- (void)checkLocationAccessForRanging {
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}


#pragma mark - Alert view delegate methods
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}
@end
