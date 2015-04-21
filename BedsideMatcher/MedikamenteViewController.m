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
#import "AppDelegate.h"
#import "Patient.h"

@interface MedikamenteViewController ()

@end

@implementation MedikamenteViewController
@synthesize searchBar,scheduledPrescriptionsTable,scheduledPrescriptionsEvening,scheduledPrescriptionsNight,scheduledPrescriptionsNoon,scheduledPrescriptionsMorning,scheduledPrescriptions,managedObjectContext,patients;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // get the managed object context from AppDelegate
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
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
    return 4;
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

// Customize the appearance of table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    static NSString *CellIdentifier = @"ScheduledPrescriptionCell";
    
    ScheduledPrescriptionCell *cell = (ScheduledPrescriptionCell *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ScheduledPrescriptionCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    trspPrescription *presc = [scheduledPrescriptions objectAtIndex:indexPath.row];
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
    if([@"weiblich" isEqualToString:[patient gender]]){
        cell.imageView.image = [UIImage imageNamed:@"female.png"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"male.png"];
    }
    cell.nameLabel.text=[[patient.name stringByAppendingString:@" "]stringByAppendingString:patient.firstname];
    cell.birthdateLabel.text=[self getBirthdateString:patient.birthdate];
    cell.schemeLabel.text = [self getSchemeString:[presc getSchedule]];
    cell.descriptionLabel.numberOfLines=0;
    cell.descriptionLabel.text = [presc getDescription];
    [cell.descriptionLabel sizeToFit];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

// define cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78.0;
}

-(void)performFetch{
    SupplyChainServicePortBinding* service = [[SupplyChainServicePortBinding alloc]init];
    toDoListPrescriptions *prescriptionList = [service getToDoListPrescriptions:nil];
    scheduledPrescriptionsMorning = [prescriptionList getScheduldedPrescriptionsMorning];
    scheduledPrescriptionsNoon = [prescriptionList getScheduldedPrescriptionsNoon];
    scheduledPrescriptionsEvening = [prescriptionList getScheduldedPrescriptionsEvening];
    scheduledPrescriptionsNight = [prescriptionList getScheduldedPrescriptionsNight];
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

@end
