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

@interface VerordnungenViewController ()

@end

@implementation VerordnungenViewController
@synthesize managedObjectContext,patients;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // get the managed object context from AppDelegate
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
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
    return 1;
}

// Customize the number of rows in the section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return patients.count;
}

// Customize the appearance of table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableViewCellVerordnung";
    
    TableViewCellVerordnung *cell = (TableViewCellVerordnung *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableViewCellVerordnung" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.nameLabel.text=[[[[patients objectAtIndex:indexPath.row]name]stringByAppendingString:@" "]stringByAppendingString:[[patients objectAtIndex:indexPath.row]firstname]];
    cell.birthdateLabel.text=[self getBirthdateString:[[patients objectAtIndex:indexPath.row]birthdate]];
    if([@"weiblich" isEqualToString:[[patients objectAtIndex:indexPath.row]gender]]){
        cell.imageView.image = [UIImage imageNamed:@"female.png"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"male.png"];
    }
    SupplyChainServicePortBinding* service = [[SupplyChainServicePortBinding alloc]init];
    NSNumber *result=[service getPreparedPrescriptionsCountForPatient:[[patients objectAtIndex:indexPath.row]polypointPID] __error:nil];
    if([result integerValue]>0){
        cell.backgroundColor = [UIColor colorWithRed:0.99 green:0.81 blue:0.63 alpha:1.0];
    }
    cell.prescriptionNbLabel.text=[result stringValue];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showVerordnungDetail" sender:[self.tableViewVerordnungen cellForRowAtIndexPath:indexPath]];
}

// define cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65.0;
    
}
-(void)performFetch{
    NSFetchRequest *fetchRequestPatient = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Patient" inManagedObjectContext:managedObjectContext];
    [fetchRequestPatient setEntity:entity];
    NSError *error;
    self.patients = [managedObjectContext executeFetchRequest:fetchRequestPatient error:&error];
}
-(NSString*)getBirthdateString:(NSString *)birthdate{
    NSString *birthdateString = birthdate;
    if([birthdateString isEqualToString:@""]){
        return @"Unbekannt";
    }
    NSArray *birthdateSplitted = [birthdateString componentsSeparatedByString:@"-"];
    return [[[[birthdateSplitted[2] stringByAppendingString:@"."]stringByAppendingString:birthdateSplitted[1]]stringByAppendingString:@"."]stringByAppendingString:birthdateSplitted[0]];
}
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

@end
