//
//  MedikamenteViewController.m
//  BedsideMatcher
//
//  Controller to list all scheduled prescriptions of the hospital sectioned in
//  morning, noon, evening and night. The view provides a search bar allowing to search
//  for patient name, patient firstname or the station identifier. Provides a quick overview
//  of the situation for the employees.
//
//  Created by Patrick Hirschi on 11.03.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "MedikamenteViewController.h"
#import "SupplyChainServicePortBinding.h"
#import "ScheduledPrescriptionCell.h"
#import "trspPrescription.h"
#import "trspPreparedMedication.h"
#import "AppDelegate.h"
#import "Patient.h"
#import "ListScheduledPrescription.h"

@interface MedikamenteViewController ()

@end

@implementation MedikamenteViewController
/**
 *  synthesize the instance variables
 */
@synthesize scheduledPrescriptionsTable,scheduledPrescriptionsEvening,scheduledPrescriptionsNight,scheduledPrescriptionsNoon,scheduledPrescriptionsMorning,scheduledPrescriptions,managedObjectContext,patients,medications,searchResultsEvening,searchResultsMorning,searchResultsNight,searchResultsNoon;
/**
 *  always called after loading the view
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // get the managed object context from AppDelegate
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    // set the scope buttons in the UISearchBar (name, firstname, station)
    self.searchDisplayController.searchBar.scopeButtonTitles = @[NSLocalizedString(@"Name",@"Name"),
                                                                 NSLocalizedString(@"Vorname",@"Vorname"),NSLocalizedString(@"Station",@"Station")];
    // initialize the arrays holding the table view content
    self.searchResultsNoon = [[NSMutableArray alloc]init];
    self.searchResultsNight = [[NSMutableArray alloc]init];
    self.searchResultsMorning = [[NSMutableArray alloc]init];
    self.searchResultsEvening = [[NSMutableArray alloc]init];

    // perform the fetch to get all scheduled prescriptions from the webservice
    [self performFetch];
    // Do any additional setup after loading the view.
}
/**
 *  default method
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  customize the number of sections in the table view and the search results table view.
 *
 *  @param tableView a UITableView
 *
 *  @return a NSInteger holding the number of sections for the table view
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // check the type of the table view (search results table view or scheduled prescriptions
    // table view. We want to show all sections in both tables (4) even if they can be empty.
    if(tableView==self.searchDisplayController.searchResultsTableView){
        return 4;
    }else{
        return 4;
    }
}
/**
 *  customize the height of the header in a specific section
 *
 *  @param tableView a UITableView
 *  @param section   a NSInteger
 *
 *  @return a CGFloat holding the height of the header in section
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 38;
}
/**
 *  customize the view for the header in section
 *
 *  @param tableView a UITableView
 *  @param section   a NSInteger
 *
 *  @return a UIView holding a label with the title (bold)
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    // initialize the title string
    NSString *titleString = [[NSString alloc]init];
    // check the section number and set the corresponding title (ordered).
    if (section==0) {
        titleString=@"Morgen";
    }else if(section==1){
        titleString=@"Mittag";
    }else if(section==2){
        titleString=@"Abend";
    }else if(section==3){
        titleString=@"Nacht";
    }else titleString = @"";
    // Create custom view to display section header...
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 38)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:14]];
    [label setText:titleString];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:0.85 green:0.84 blue:0.84 alpha:1.0]];
    return view;
}
/**
 *  customize the number of rows in the sections of table view and the search results table view.
 *
 *  @param tableView a UITableView
 *  @param section   a NSInteger
 *
 *  @return a NSInteger holding the number of rows for the specified sections.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // check the type of the table view (search results table view or scheduled prescriptions
    // table view and set the row count appropriately.
    if(tableView==self.searchDisplayController.searchResultsTableView){
        if(section==0){
            // return search result count
            return searchResultsMorning.count;
        }else if(section==1){
            return searchResultsNoon.count;
        }else if(section==2){
            return searchResultsEvening.count;
        }else if(section==3){
            return searchResultsNight.count;
        }else{
            // should never be the case, but lets add some default stuff to avoid errors.
            return 0;
        }
    }else{
        if(section==0){
            // return scheduled prescriptions count
            return scheduledPrescriptionsMorning.count;
        }else if(section==1){
            return scheduledPrescriptionsNoon.count;
        }else if(section==2){
            return scheduledPrescriptionsEvening.count;
        }else if(section==3){
            return scheduledPrescriptionsNight.count;
        }else{
            // should never be the case, but lets add some default stuff to avoid errors.
            return 0;
        }
    }
}
/**
 *  Customize the appearance of table view cells.
 *
 *  @param tableView a UITableView
 *  @param indexPath a NSIndexPath
 *
 *  @return Custom UITableViewCell of class ScheduledPrescriptionCell.h
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.searchDisplayController.searchResultsTableView){
        // check if its section 0 (morning),section 1 (noon), section 2 (evening)
        // or section 3 (night)
        if(indexPath.section==0){
            scheduledPrescriptions=searchResultsMorning;
        }else if(indexPath.section==1){
            scheduledPrescriptions=searchResultsNoon;
        }else if(indexPath.section==2){
            scheduledPrescriptions=searchResultsEvening;
        }else if(indexPath.section==3){
            scheduledPrescriptions=searchResultsNight;
        }
    }else{
        // check if its section 0 (morning),section 1 (noon), section 2 (evening)
        // or section 3 (night)
        if(indexPath.section==0){
            scheduledPrescriptions=scheduledPrescriptionsMorning;
        }else if(indexPath.section==1){
            scheduledPrescriptions=scheduledPrescriptionsNoon;
        }else if(indexPath.section==2){
            scheduledPrescriptions=scheduledPrescriptionsEvening;
        }else if(indexPath.section==3){
            scheduledPrescriptions=scheduledPrescriptionsNight;
        }
    }
    
    // set the cell identifier
    static NSString *CellIdentifier = @"ScheduledPrescriptionCell";
    
    // try to find the cell
    ScheduledPrescriptionCell *cell = (ScheduledPrescriptionCell *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        // search the cell with nib name to avoid nil valued cells
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ScheduledPrescriptionCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // get the current ListScheduledPrescription object and extract patient and medications
    ListScheduledPrescription *listPresc = [scheduledPrescriptions objectAtIndex:indexPath.row];
    medications = [listPresc.presc getMedications];
    Patient *patient =listPresc.patient;

    // set the cell image (female or male)
    if([@"weiblich" isEqualToString:[patient gender]]){
        cell.imageView.image = [UIImage imageNamed:@"female.png"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"male.png"];
    }
    // setup cell labels
    cell.nameLabel.text=[[patient.name stringByAppendingString:@" "]stringByAppendingString:patient.firstname];
    cell.birthdateLabel.text= [[[[self getBirthdateString:patient.birthdate]stringByAppendingString:@" ("]stringByAppendingString:[self getAgeFromDateString:[self getBirthdateString:patient.birthdate]]]stringByAppendingString:@")"];
    [self getBirthdateString:patient.birthdate];
    cell.schemeLabel.text = [self getSchemeString:[listPresc.presc getSchedule]];
    cell.descriptionLabel.numberOfLines=0;
    cell.descriptionLabel.text = [listPresc.presc getDescription];
    NSString *medicationString = @"";
    for(trspPreparedMedication *medi in medications){
        medicationString = [medicationString stringByAppendingString:medi.getName];
        medicationString = [medicationString stringByAppendingString:@" "];
    }
    cell.medicationLabel.numberOfLines=0;
    cell.medicationLabel.text = medicationString;
    [cell.descriptionLabel sizeToFit];
    return cell;
}
/**
 *  called when the user selects a cell from the table view.
 *
 *  @param tableView a UITableView
 *  @param indexPath a NSIndexPath
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
/**
 *  sets the height for the rows in the table view
 *
 *  @param tableView a UITableView
 *  @param indexPath a NSIndexPath
 *
 *  @return a CGFloat holding the height for the row at specified index path
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.0;
}
/**
 *  gets all scheduled prescriptions from the supply chain service, gets the corresponding patients from 
 *  core data and builds the instance variable arrays holding ListScheduledPrescription objects.
 */
-(void)performFetch{
    // initialize the arrays
    NSMutableArray *tempScheduledPrescriptionsMorning = [[NSMutableArray alloc]init];
    NSMutableArray *tempScheduledPrescriptionsNoon = [[NSMutableArray alloc]init];
    NSMutableArray *tempScheduledPrescriptionsEvening = [[NSMutableArray alloc]init];
    NSMutableArray *tempScheduledPrescriptionsNight = [[NSMutableArray alloc]init];
    self.scheduledPrescriptionsMorning=[[NSMutableArray alloc]init];
    self.scheduledPrescriptionsNoon=[[NSMutableArray alloc]init];
    self.scheduledPrescriptionsEvening=[[NSMutableArray alloc]init];
    self.scheduledPrescriptionsNight=[[NSMutableArray alloc]init];

    // get a connection to the supply chain service
    SupplyChainServicePortBinding* service = [[SupplyChainServicePortBinding alloc]init];
    toDoListPrescriptions *prescriptionList = [service getToDoListPrescriptions:nil];
    tempScheduledPrescriptionsMorning = [prescriptionList getScheduldedPrescriptionsMorning];
    tempScheduledPrescriptionsNoon = [prescriptionList getScheduldedPrescriptionsNoon];
    tempScheduledPrescriptionsEvening = [prescriptionList getScheduldedPrescriptionsEvening];
    tempScheduledPrescriptionsNight = [prescriptionList getScheduldedPrescriptionsNight];
    
    // SETUP ALL PRESCRIPTION ARRAYS
    
    // MORNING PRESCRIPTIONS
    for(trspPrescription *presc in tempScheduledPrescriptionsMorning){
        NSFetchRequest *fetchRequestPatient = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Patient" inManagedObjectContext:managedObjectContext];
        [fetchRequestPatient setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"polypointPID LIKE %@",
                              [presc getPatientPolypointID]];
        [fetchRequestPatient setPredicate:predicate];
        NSError *error;
        patients = [managedObjectContext executeFetchRequest:fetchRequestPatient error:&error];
        Patient *patient = [patients firstObject];
        ListScheduledPrescription *listPresc = [[ListScheduledPrescription alloc]init];
        listPresc.patient=patient;
        listPresc.presc = presc;
        [self.scheduledPrescriptionsMorning addObject:listPresc];
    }
    
    // NOON PRESCRIPTIONS
    for(trspPrescription *presc in tempScheduledPrescriptionsNoon){
        NSFetchRequest *fetchRequestPatient = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"Patient" inManagedObjectContext:managedObjectContext];
        [fetchRequestPatient setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"polypointPID LIKE %@",
                                  [presc getPatientPolypointID]];
        [fetchRequestPatient setPredicate:predicate];
        NSError *error;
        patients = [managedObjectContext executeFetchRequest:fetchRequestPatient error:&error];
        Patient *patient = [patients firstObject];
        ListScheduledPrescription *listPresc = [[ListScheduledPrescription alloc]init];
        listPresc.patient=patient;
        listPresc.presc = presc;
        [self.scheduledPrescriptionsNoon addObject:listPresc];
    }
    
    // EVENING PRESCRIPTIONS
    for(trspPrescription *presc in tempScheduledPrescriptionsEvening){
        NSFetchRequest *fetchRequestPatient = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"Patient" inManagedObjectContext:managedObjectContext];
        [fetchRequestPatient setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"polypointPID LIKE %@",
                                  [presc getPatientPolypointID]];
        [fetchRequestPatient setPredicate:predicate];
        NSError *error;
        patients = [managedObjectContext executeFetchRequest:fetchRequestPatient error:&error];
        Patient *patient = [patients firstObject];
        ListScheduledPrescription *listPresc = [[ListScheduledPrescription alloc]init];
        listPresc.patient=patient;
        listPresc.presc = presc;
        [self.scheduledPrescriptionsEvening addObject:listPresc];
    }
    
    // NIGHT PRESCRIPTIONS
    for(trspPrescription *presc in tempScheduledPrescriptionsNight){
        NSFetchRequest *fetchRequestPatient = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"Patient" inManagedObjectContext:managedObjectContext];
        [fetchRequestPatient setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"polypointPID LIKE %@",
                                  [presc getPatientPolypointID]];
        [fetchRequestPatient setPredicate:predicate];
        NSError *error;
        patients = [managedObjectContext executeFetchRequest:fetchRequestPatient error:&error];
        Patient *patient = [patients firstObject];
        ListScheduledPrescription *listPresc = [[ListScheduledPrescription alloc]init];
        listPresc.patient=patient;
        listPresc.presc = presc;
        [self.scheduledPrescriptionsNight addObject:listPresc];
    }
    
}
/**
 *  converts NSString values of the birthdate (cosmetical issues)
 *
 *  @param birthdate a NSString of format yyyy-mm-dd
 *
 *  @return a NSString of format dd.mm.yyyy
 */
-(NSString*)getBirthdateString:(NSString *)birthdate{
    NSString *birthdateString = birthdate;
    // if its an empty string we return "Unbekannt"
    if([birthdateString isEqualToString:@""]){
        return @"Unbekannt";
    }
    // split the string after every "-" character
    NSArray *birthdateSplitted = [birthdateString componentsSeparatedByString:@"-"];
    // return the right format
    return [[[[birthdateSplitted[2] stringByAppendingString:@"."]stringByAppendingString:birthdateSplitted[1]]stringByAppendingString:@"."]stringByAppendingString:birthdateSplitted[0]];
}

/**
 *  converts a scheme of the format 1111 to the format 1-1-1-1
 *
 *  @param scheme a NSString with format %d%d%d%d
 *
 *  @return a NSString with format %d-%d-%d-%d
 */
-(NSString*)getSchemeString:(NSString *)scheme{
    NSString *schemeString = scheme;
    // if its an empty string we return "Unbekannt"
    if([schemeString isEqualToString:@""]){
        return @"Unbekannt";
    }
    // get the 4 characters
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[schemeString length]];
    for (int i=0; i < [schemeString length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [schemeString characterAtIndex:i]];
        [characters addObject:ichar];
    }
    // return the right format
    return [[[[[[[characters objectAtIndex:0]stringByAppendingString:@"-"]stringByAppendingString:[characters objectAtIndex:1]]stringByAppendingString:@"-"]stringByAppendingString:[characters objectAtIndex:2]]stringByAppendingString:@"-"]stringByAppendingString:[characters objectAtIndex:3]];
}
/**
 *  filters the arrays of the table view based on a specified search text and a scope that can be chosen
 *  by the user.
 *
 *  @param searchText a NSString holding the text to search for
 *  @param scope      a NSString holding the scope
 */
-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope{
    // reset all search result arrays
    [self.searchResultsEvening removeAllObjects ];
    [self.searchResultsMorning removeAllObjects];
    [self.searchResultsNight removeAllObjects];
    [self.searchResultsNoon removeAllObjects];

    // filter the scheduled prescriptions for the morning
    for (ListScheduledPrescription *listSched in self.scheduledPrescriptionsMorning)
    {
        NSComparisonResult result;
        // search for scopes "name", "firstname" and "station"
        if([scope isEqualToString:@"Name"]){
            result = [listSched.patient.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }if ([scope isEqualToString:@"Vorname"]) {
            result = [listSched.patient.firstname compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }if ([scope isEqualToString:@"Station"]) {
            result = [[self getStationString: listSched.patient.station] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }
        if (result == NSOrderedSame)
        {
            [self.searchResultsMorning addObject:listSched];
        }
    }
    // filter the scheduled prescriptions for noon
    for (ListScheduledPrescription *listSched in self.scheduledPrescriptionsNoon)
    {
        NSComparisonResult result;
        // search for scopes "name", "firstname" and "station"
        if([scope isEqualToString:@"Name"]){
            result = [listSched.patient.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }if ([scope isEqualToString:@"Vorname"]) {
            result = [listSched.patient.firstname compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }if ([scope isEqualToString:@"Station"]) {
            result = [[self getStationString: listSched.patient.station] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }
        if (result == NSOrderedSame)
        {
            [self.searchResultsNoon addObject:listSched];
        }
    }
    // filter the scheduled prescriptions for the evening
    for (ListScheduledPrescription *listSched in self.searchResultsEvening)
    {
        NSComparisonResult result;
        // search for scopes "name", "firstname" and "station"
        if([scope isEqualToString:@"Name"]){
            result = [listSched.patient.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }if ([scope isEqualToString:@"Vorname"]) {
            result = [listSched.patient.firstname compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }if ([scope isEqualToString:@"Station"]) {
            result = [[self getStationString: listSched.patient.station] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }
        if (result == NSOrderedSame)
        {
            [self.scheduledPrescriptionsEvening addObject:listSched];
        }
    }
    // filter the scheduled prescriptions for the night
    for (ListScheduledPrescription *listSched in self.scheduledPrescriptionsNight)
    {
        NSComparisonResult result;
        // search for scopes "name", "firstname" and "station"
        if([scope isEqualToString:@"Name"]){
            result = [listSched.patient.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }if ([scope isEqualToString:@"Vorname"]) {
            result = [listSched.patient.firstname compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }if ([scope isEqualToString:@"Station"]) {
            result = [[self getStationString: listSched.patient.station] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }
        if (result == NSOrderedSame)
        {
            [self.searchResultsNight addObject:listSched];
        }
    }
    
}
/**
 *  indicates if the search table view should be reloaded
 *
 *  @param controller   an UISearchDisplayController
 *  @param searchString a NSString holding the search text
 *
 *  @return a BOOL indicating if the search table view should be reloaded
 */
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex] ]];
    return YES;
}
/**
 *  method always called if user types in a searchtext, sets the button title to "Abbrechen" (default: 
 *  "Cancel")
 *
 *  @param controller an UISearchDisplayController
 */
-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    // show the button
    self.searchDisplayController.searchBar.showsCancelButton = YES;
    UIButton *cancelButton;
    UIView *topView = self.searchDisplayController.searchBar.subviews[0];
    // iterate through all subviews to find the right button
    for (UIView *subView in topView.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            cancelButton = (UIButton*)subView;
        }
    }
    if (cancelButton) {
        //Set the new title of the cancel button
        [cancelButton setTitle:@"Abbrechen" forState:UIControlStateNormal];
    }
}
/**
 *  extracts the station identifer e.g. "A" or "B" from the station string ("Station A" or "Station B")
 *
 *  @param station a NSString of format "Station A" or "Station B"
 *
 *  @return a NSString holding the identifier e.g. "A" or "B"
 */
-(NSString*)getStationString:(NSString*)station{
    NSString *stationString = station;
    // split after the spaces
    NSArray *stationSplitted = [stationString componentsSeparatedByString:@" "];
    return stationSplitted[1];
}

/**
 *  calculates the age of a patient based on a given date of birth (dd.MM.yyyy)
 *
 *  @param dateOfBirth a birthdate of format dd.MM.yyyy
 *
 *  @return NSString age in years
 */
-(NSString *)getAgeFromDateString:(NSString*)dateOfBirth{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateOfBirth];
    
    NSDate *today = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:dateFromString
                                       toDate:today
                                       options:0];
    return [NSString stringWithFormat:@"%ld",(long)ageComponents.year];
}

@end
