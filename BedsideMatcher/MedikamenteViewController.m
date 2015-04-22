//
//  MedikamenteViewController.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 11.03.15.
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
@synthesize scheduledPrescriptionsTable,scheduledPrescriptionsEvening,scheduledPrescriptionsNight,scheduledPrescriptionsNoon,scheduledPrescriptionsMorning,scheduledPrescriptions,managedObjectContext,patients,medications,searchResultsEvening,searchResultsMorning,searchResultsNight,searchResultsNoon;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // get the managed object context from AppDelegate
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    
    self.searchDisplayController.searchBar.scopeButtonTitles = @[NSLocalizedString(@"Name",@"Name"),
                                                                 NSLocalizedString(@"Vorname",@"Vorname"),NSLocalizedString(@"Station",@"Station")];
    self.searchResultsNoon = [[NSMutableArray alloc]init];
    self.searchResultsNight = [[NSMutableArray alloc]init];
    self.searchResultsMorning = [[NSMutableArray alloc]init];
    self.searchResultsEvening = [[NSMutableArray alloc]init];

    [self performFetch];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Customize the number of sections in the table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==self.searchDisplayController.searchResultsTableView){
        return 4;
    }else{
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 38;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *titleString = [[NSString alloc]init];
    if (section==0) {
        titleString=@"Morgen";
    }else if(section==1){
        titleString=@"Mittag";
    }else if(section==2){
        titleString=@"Abend";
    }else if(section==3){
        titleString=@"Nacht";
    }else titleString = @"";
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 38)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:14]];
    [label setText:titleString];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:0.85 green:0.84 blue:0.84 alpha:1.0]];
    return view;
}

// Customize the number of rows in the section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.searchDisplayController.searchResultsTableView){
        if(section==0){
            return searchResultsMorning.count;
        }else if(section==1){
            return searchResultsNoon.count;
        }else if(section==2){
            return searchResultsEvening.count;
        }else if(section==3){
            return searchResultsNight.count;
        }else{
            return 0;
        }
    }else{
        if(section==0){
            return scheduledPrescriptionsMorning.count;
        }else if(section==1){
            return scheduledPrescriptionsNoon.count;
        }else if(section==2){
            return scheduledPrescriptionsEvening.count;
        }else if(section==3){
            return scheduledPrescriptionsNight.count;
        }else{
            return 0;
        }
    }
}

// Customize the appearance of table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.searchDisplayController.searchResultsTableView){
        // check if its section 0 (Station A) or section 1 (Station B)
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
        // check if its section 0 (Station A) or section 1 (Station B)
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
    
    static NSString *CellIdentifier = @"ScheduledPrescriptionCell";
    
    ScheduledPrescriptionCell *cell = (ScheduledPrescriptionCell *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ScheduledPrescriptionCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    ListScheduledPrescription *listPresc = [scheduledPrescriptions objectAtIndex:indexPath.row];
    medications = [listPresc.presc getMedications];
    Patient *patient =listPresc.patient;

    if([@"weiblich" isEqualToString:[patient gender]]){
        cell.imageView.image = [UIImage imageNamed:@"female.png"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"male.png"];
    }
    cell.nameLabel.text=[[patient.name stringByAppendingString:@" "]stringByAppendingString:patient.firstname];
    cell.birthdateLabel.text=[self getBirthdateString:patient.birthdate];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

// define cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.0;
}

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

    SupplyChainServicePortBinding* service = [[SupplyChainServicePortBinding alloc]init];
    toDoListPrescriptions *prescriptionList = [service getToDoListPrescriptions:nil];
    tempScheduledPrescriptionsMorning = [prescriptionList getScheduldedPrescriptionsMorning];
    tempScheduledPrescriptionsNoon = [prescriptionList getScheduldedPrescriptionsNoon];
    tempScheduledPrescriptionsEvening = [prescriptionList getScheduldedPrescriptionsEvening];
    tempScheduledPrescriptionsNight = [prescriptionList getScheduldedPrescriptionsNight];
    
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

// converts a birthdate of the format 2013-12-12 to the format 12.12.2013
-(NSString*)getBirthdateString:(NSString *)birthdate{
    NSString *birthdateString = birthdate;
    if([birthdateString isEqualToString:@""]){
        return @"Unbekannt";
    }
    NSArray *birthdateSplitted = [birthdateString componentsSeparatedByString:@"-"];
    return [[[[birthdateSplitted[2] stringByAppendingString:@"."]stringByAppendingString:birthdateSplitted[1]]stringByAppendingString:@"."]stringByAppendingString:birthdateSplitted[0]];
}

// converts a birthdate of the format 1111 to the format 1-1-1-1
-(NSString*)getSchemeString:(NSString *)scheme{
    NSString *schemeString = scheme;
    if([schemeString isEqualToString:@""]){
        return @"Unbekannt";
    }
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[schemeString length]];
    for (int i=0; i < [schemeString length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [schemeString characterAtIndex:i]];
        [characters addObject:ichar];
    }
    return [[[[[[[characters objectAtIndex:0]stringByAppendingString:@"-"]stringByAppendingString:[characters objectAtIndex:1]]stringByAppendingString:@"-"]stringByAppendingString:[characters objectAtIndex:2]]stringByAppendingString:@"-"]stringByAppendingString:[characters objectAtIndex:3]];
}

-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope{
    [self.searchResultsEvening removeAllObjects ];
    [self.searchResultsMorning removeAllObjects];
    [self.searchResultsNight removeAllObjects];
    [self.searchResultsNoon removeAllObjects];

    for (ListScheduledPrescription *listSched in self.scheduledPrescriptionsMorning)
    {
        NSComparisonResult result;
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
    for (ListScheduledPrescription *listSched in self.scheduledPrescriptionsNoon)
    {
        NSComparisonResult result;
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
    for (ListScheduledPrescription *listSched in self.searchResultsEvening)
    {
        NSComparisonResult result;
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
    for (ListScheduledPrescription *listSched in self.scheduledPrescriptionsNight)
    {
        NSComparisonResult result;
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
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex] ]];
    return YES;
}

-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    self.searchDisplayController.searchBar.showsCancelButton = YES;
    UIButton *cancelButton;
    UIView *topView = self.searchDisplayController.searchBar.subviews[0];
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

-(NSString*)getStationString:(NSString*)station{
    NSString *stationString = station;
    NSArray *stationSplitted = [stationString componentsSeparatedByString:@" "];
    return stationSplitted[1];
}

@end
