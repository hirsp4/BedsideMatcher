//
//  BeaconViewController.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 11.03.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "BeaconViewController.h"
#import "TableViewCellPatients.h"
#import "BeaconTableViewCell.h"
#import "AppDelegate.h"
#import "snfsdk.h"
#import "DetailBeaconViewController.h"

@interface BeaconViewController (){
    NSArray *Patients;
}

@end

@implementation BeaconViewController
@synthesize tableViewBeacon;
NSTimer *timer;
LeSnfDevice *selectedDevice;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setBarcodeButton];
     timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadTable) userInfo:NULL repeats:YES];
}
-(void) viewWillAppear:(BOOL)animated{


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)getBeaconArray{
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    return appDel.deviceManager.devList;
}

-(void)reloadTable{
    [tableViewBeacon reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getBeaconArray].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BeaconTableViewCell *cell = [self.tableViewBeacon dequeueReusableCellWithIdentifier: @"BEACONCELL" forIndexPath:indexPath];
    
    LeSnfDevice *device = [[self getBeaconArray]objectAtIndexedSubscript:indexPath.row];
    
    cell.nameLbl.text = device.peripheral.name;
    cell.rssiLbl.text = [device.peripheral.identifier UUIDString];
    cell.distLbl.text = [[NSString stringWithFormat:@"%f", device.distanceEstimate]stringByAppendingString:@" m"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedDevice = [[self getBeaconArray] objectAtIndex:indexPath.row];
    
    //have to do segue manually (otherwise segue registers before this method does)
    [self performSegueWithIdentifier:@"toBeacon" sender:self.tableViewBeacon];
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toBeacon"]) {
        DetailBeaconViewController *vc = [segue destinationViewController];
        vc.theDevice = selectedDevice;
    }
}

// create Barcode-Button
- (void)setBarcodeButton{

UIImage *barcodeImage = [[UIImage imageNamed:@"barcode.png"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    UIButton *barcode = [UIButton buttonWithType:UIButtonTypeCustom];
    [barcode addTarget:self
         action:@selector(showBarcodeView:)
         forControlEvents:UIControlEventTouchUpInside];
    barcode.bounds = CGRectMake( 0, 0, 36, 31);
    [barcode setImage:barcodeImage forState:UIControlStateNormal];
    UIBarButtonItem *barcodeButton = [[UIBarButtonItem alloc] initWithCustomView:barcode];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle: @"Patienten in der Nähe"];
    item.leftBarButtonItem = barcodeButton;
    [_navBarBeacon pushNavigationItem:item animated:NO];
}

- (IBAction)showBarcodeView:(id)sender {

    [self performSegueWithIdentifier:@"showBarcodeView" sender:self];
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
