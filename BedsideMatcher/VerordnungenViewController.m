//
//  VerordnungenViewController.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 11.03.15.
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
    self.searchDisplayController.searchBar.scopeButtonTitles = @[NSLocalizedString(@"Name",@"Name"),
                                                          NSLocalizedString(@"Vorname",@"Vorname")];
    self.searchResultsA = [[NSMutableArray alloc]init];
    self.searchResultsB = [[NSMutableArray alloc]init];
    // get the patients from core data
    [self performFetch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Customize the number of sections in the table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *titleString = [[NSString alloc]init];
    if (section==0) {
        titleString=@"Station A";
    }else titleString = @"Station B";
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

// Customize the appearance of table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.searchDisplayController.searchResultsTableView){
        // check if its section 0 (Station A) or section 1 (Station B)
        if(indexPath.section==0){
            listPatients=[searchResultsA mutableCopy];
        }else{
            listPatients=[searchResultsB mutableCopy];
        }
        static NSString *CellIdentifier = @"TableViewCellVerordnung";
        
        TableViewCellVerordnung *cell = (TableViewCellVerordnung *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableViewCellVerordnung" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.nameLabel.text=[[[[[listPatients objectAtIndex:indexPath.row]patient ]name]stringByAppendingString:@" "]stringByAppendingString:[[[listPatients objectAtIndex:indexPath.row]patient ]firstname]];
        cell.birthdateLabel.text=[self getBirthdateString:[[[listPatients objectAtIndex:indexPath.row]patient ]birthdate]];
        if([@"weiblich" isEqualToString:[[[listPatients objectAtIndex:indexPath.row]patient ]gender]]){
            cell.imageView.image = [UIImage imageNamed:@"female.png"];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"male.png"];
        }
        
        if([[[listPatients objectAtIndex:indexPath.row ]openPrescriptions] integerValue]>0){
            cell.backgroundColor = [UIColor colorWithRed:0.99 green:0.81 blue:0.63 alpha:1.0];
        }
        cell.prescriptionNbLabel.text=[[[listPatients objectAtIndex:indexPath.row ]openPrescriptions]stringValue];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
    // check if its section 0 (Station A) or section 1 (Station B)
    if(indexPath.section==0){
        listPatients=listPatientsA;
    }else{
        listPatients=listPatientsB;
    }
    static NSString *CellIdentifier = @"TableViewCellVerordnung";
    
    TableViewCellVerordnung *cell = (TableViewCellVerordnung *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableViewCellVerordnung" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.nameLabel.text=[[[[[listPatients objectAtIndex:indexPath.row]patient ]name]stringByAppendingString:@" "]stringByAppendingString:[[[listPatients objectAtIndex:indexPath.row]patient ]firstname]];
    cell.birthdateLabel.text=[self getBirthdateString:[[[listPatients objectAtIndex:indexPath.row]patient ]birthdate]];
    if([@"weiblich" isEqualToString:[[[listPatients objectAtIndex:indexPath.row]patient ]gender]]){
        cell.imageView.image = [UIImage imageNamed:@"female.png"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"male.png"];
    }

    if([[[listPatients objectAtIndex:indexPath.row ]openPrescriptions] integerValue]>0){
        cell.backgroundColor = [UIColor colorWithRed:0.99 green:0.81 blue:0.63 alpha:1.0];
    }
    cell.prescriptionNbLabel.text=[[[listPatients objectAtIndex:indexPath.row ]openPrescriptions]stringValue];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showVerordnungDetail" sender:[self.tableViewVerordnungen cellForRowAtIndexPath:indexPath]];
}

// define cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65.0;
    
}
// performs the fetch of the patients in core data and the open prescriptions in the webservice
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
// converts a birthdate of the format 2013-12-12 to the format 12.12.2013
-(NSString*)getBirthdateString:(NSString *)birthdate{
    NSString *birthdateString = birthdate;
    if([birthdateString isEqualToString:@""]){
        return @"Unbekannt";
    }
    NSArray *birthdateSplitted = [birthdateString componentsSeparatedByString:@"-"];
    return [[[[birthdateSplitted[2] stringByAppendingString:@"."]stringByAppendingString:birthdateSplitted[1]]stringByAppendingString:@"."]stringByAppendingString:birthdateSplitted[0]];
}
// converts a given string of a station (p.e. Station A) to the identifier only e.g. "A"
-(NSString*)getStationString:(NSString *)station{
    NSString *stationString = station;
    NSArray *stationSplitted = [stationString componentsSeparatedByString:@" "];
    return stationSplitted[1];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope{
    [self.searchResultsA removeAllObjects ];
    [self.searchResultsB removeAllObjects];

    for (ListPatient *listPatient in self.listPatientsA)
    {
        NSComparisonResult result;
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
        if (result == NSOrderedSame)
        {
            [self.searchResultsB addObject:listPatient];
        }
    }

}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex] ]];
    return YES;
}

@end
