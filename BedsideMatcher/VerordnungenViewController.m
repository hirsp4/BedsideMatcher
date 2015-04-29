//
//  VerordnungenViewController.m
//  BedsideMatcher
//
//  Controller to list the patients sectioned in stations with the corresponding count of
//  open prescriptions.
//
//  Created by Patrick Hirschi on 11.03.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "VerordnungenViewController.h"
#import "TableViewCellVerordnung.h"
#import "AppDelegate.h"
#import "Patient.h"
#import "SupplyChainServicePortBinding.h"
#import "getPreparedPrescriptionsCountForPatientResponse.h"
#import "ListPatient.h"

@interface VerordnungenViewController ()

@end

@implementation VerordnungenViewController
@synthesize managedObjectContext,patientsA,patientsB,listPatientsA,listPatientsB,listPatients,searchResultsA,searchResultsB;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // get the managed object context from AppDelegate
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    // set the scope buttons in the UISearchBar (name, firstname, station)
    self.searchDisplayController.searchBar.scopeButtonTitles = @[NSLocalizedString(@"Name",@"Name"),
                                                          NSLocalizedString(@"Vorname",@"Vorname")];
    // initialize the arrays holding the table view content
    self.searchResultsA = [[NSMutableArray alloc]init];
    self.searchResultsB = [[NSMutableArray alloc]init];
    // get the patients from core data
    [self performFetch];
}

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
    return 2;
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
        titleString=@"Station A";
    }else titleString = @"Station B";
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 38)];
    // Create custom view to display section header...
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
            return searchResultsA.count;
        }
        if(section==1){
            return searchResultsB.count;
        }else{
            return 0;
        }
    }else{
        if(section==0){
            return listPatientsA.count;
        }
        if(section==1){
            return listPatientsB.count;
        }else{
            return 0;
        }
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
 *  Customize the appearance of table view cells.
 *
 *  @param tableView a UITableView
 *  @param indexPath a NSIndexPath
 *
 *  @return Custom UITableViewCell of class TableViewCellVerordnung.h
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.searchDisplayController.searchResultsTableView){
        // check if its section 0 (Station A) or section 1 (Station B)
        if(indexPath.section==0){
            listPatients=[searchResultsA mutableCopy];
        }else{
            listPatients=[searchResultsB mutableCopy];
        }
    }else{
        // check if its section 0 (Station A) or section 1 (Station B)
        if(indexPath.section==0){
            listPatients=listPatientsA;
        }else{
            listPatients=listPatientsB;
        }
    }
    // set the cell identifier
    static NSString *CellIdentifier = @"TableViewCellVerordnung";
    // initialize the cell
    TableViewCellVerordnung *cell = (TableViewCellVerordnung *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        // just to avoid nil values!
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableViewCellVerordnung" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // setup cell labels
    cell.nameLabel.text=[[[[[listPatients objectAtIndex:indexPath.row]patient ]name]stringByAppendingString:@" "]stringByAppendingString:[[[listPatients objectAtIndex:indexPath.row]patient ]firstname]];
    cell.birthdateLabel.text=[[[[self getBirthdateString:[[[listPatients objectAtIndex:indexPath.row]patient ]birthdate]]stringByAppendingString:@" ("]stringByAppendingString:[self getAgeFromDateString:[self getBirthdateString:[[[listPatients objectAtIndex:indexPath.row]patient ]birthdate]]]]stringByAppendingString:@")"];
    if([@"weiblich" isEqualToString:[[[listPatients objectAtIndex:indexPath.row]patient ]gender]]){
        cell.imageView.image = [UIImage imageNamed:@"female.png"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"male.png"];
    }

    if([[[listPatients objectAtIndex:indexPath.row ]openPrescriptions] integerValue]>0){
        cell.backgroundColor = [UIColor colorWithRed:0.99 green:0.81 blue:0.63 alpha:1.0];
    }
    cell.prescriptionNbLabel.text=[[[listPatients objectAtIndex:indexPath.row ]openPrescriptions]stringValue];
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
    return 65.0;
}
/**
 *  performs the fetch of the patients in core data and the open prescriptions in the webservice
 */
-(void)performFetch{
    // initialize the requests for station A and station B
    NSFetchRequest *fetchRequestPatientA = [[NSFetchRequest alloc] init];
    NSFetchRequest *fetchRequestPatientB = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Patient" inManagedObjectContext:managedObjectContext];
    // set the entities for station A and station B
    [fetchRequestPatientA setEntity:entity];
    [fetchRequestPatientB setEntity:entity];
    // search predicates for the requests for station A and station B
    NSPredicate *predicateA = [NSPredicate predicateWithFormat:@"station LIKE %@",
                              @"Station A"];
    NSPredicate *predicateB = [NSPredicate predicateWithFormat:@"station LIKE %@",
                               @"Station B"];
    // set predicates for the requests for station A and station B
    [fetchRequestPatientA setPredicate:predicateA];
    [fetchRequestPatientB setPredicate:predicateB];
    NSError *error;
    // initialize the instancevariables
    listPatientsA = [[NSMutableArray alloc]init];
    listPatientsB = [[NSMutableArray alloc]init];
    // do the fetches
    self.patientsA = [managedObjectContext executeFetchRequest:fetchRequestPatientA error:&error];
    self.patientsB = [managedObjectContext executeFetchRequest:fetchRequestPatientB error:&error];
    // transform the patients to listpatients (needed for the sorting of the table view)
    for(Patient *p in self.patientsA){
         SupplyChainServicePortBinding* service = [[SupplyChainServicePortBinding alloc]init];
        NSNumber *result=[service getPreparedPrescriptionsCountForPatient:[p polypointPID] __error:nil];
        ListPatient *listPatient = [[ListPatient alloc]init];
        listPatient.patient=p;
        listPatient.openPrescriptions=result;
        [listPatientsA addObject:listPatient];
    }
    for(Patient *p in self.patientsB){
        SupplyChainServicePortBinding* service = [[SupplyChainServicePortBinding alloc]init];
        NSNumber *result=[service getPreparedPrescriptionsCountForPatient:[p polypointPID] __error:nil];
        ListPatient *listPatient = [[ListPatient alloc]init];
        listPatient.patient=p;
        listPatient.openPrescriptions=result;
        [listPatientsB addObject:listPatient];
    }
    // sort the arrays and set the instance variables
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"openPrescriptions"
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArrayA;
    NSArray *sortedArrayB;
    sortedArrayA = [listPatientsA sortedArrayUsingDescriptors:sortDescriptors];
    listPatientsA = [sortedArrayA mutableCopy];
    sortedArrayB = [listPatientsB sortedArrayUsingDescriptors:sortDescriptors];
    listPatientsB = [sortedArrayB mutableCopy];
   
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
    // if the string is empty we return "Unbekannt"
    if([birthdateString isEqualToString:@""]){
        return @"Unbekannt";
    }
    // split the string after every "-" character
    NSArray *birthdateSplitted = [birthdateString componentsSeparatedByString:@"-"];
    return [[[[birthdateSplitted[2] stringByAppendingString:@"."]stringByAppendingString:birthdateSplitted[1]]stringByAppendingString:@"."]stringByAppendingString:birthdateSplitted[0]];
}
/**
 *  extracts the station identifer e.g. "A" or "B" from the station string ("Station A" or "Station B")
 *
 *  @param station a NSString of format "Station A" or "Station B"
 *
 *  @return a NSString holding the identifier e.g. "A" or "B"
 */
-(NSString*)getStationString:(NSString *)station{
    NSString *stationString = station;
    if([stationString isEqualToString:@""]){
        return @"";
    }
    // split the station string after every space
    NSArray *stationSplitted = [stationString componentsSeparatedByString:@" "];
    return stationSplitted[1];
}
/**
 *  filters the arrays of the table view based on a specified search text and a scope that can be chosen
 *  by the user.
 *
 *  @param searchText a NSString holding the text to search for
 *  @param scope      a NSString holding the scope
 */
-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope{
    // reset all search arrays
    [self.searchResultsA removeAllObjects ];
    [self.searchResultsB removeAllObjects];

    // filter arrays of station A and B based on the specified search text
    for (ListPatient *listPatient in self.listPatientsA)
    {
        NSComparisonResult result = [listPatient.patient.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if([scope isEqualToString:@"Name"]){
            result = [listPatient.patient.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }if ([scope isEqualToString:@"Vorname"]) {
            result = [listPatient.patient.firstname compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }
        if (result == NSOrderedSame)
        {
            [self.searchResultsA addObject:listPatient];
        }
    }
    for (ListPatient *listPatient in self.listPatientsB)
    {
        NSComparisonResult result = [listPatient.patient.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if([scope isEqualToString:@"Name"]){
            result = [listPatient.patient.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }if ([scope isEqualToString:@"Vorname"]) {
            result = [listPatient.patient.firstname compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        }
        if (result == NSOrderedSame)
        {
            [self.searchResultsB addObject:listPatient];
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
 *  calculates the age of a patient based on a given date of birth (dd.MM.yyyy)
 *
 *  @param dateOfBirth a birthdate of format dd.MM.yyyy
 *
 *  @return NSString age in years
 */
-(NSString *)getAgeFromDateString:(NSString*)dateOfBirth{
    if([dateOfBirth isEqualToString:@""]){
        return @"?";
    }
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
