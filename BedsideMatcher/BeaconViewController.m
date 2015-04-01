//
//  BeaconViewController.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 11.03.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "BeaconViewController.h"
#import "TableViewCellPatients.h"

@interface BeaconViewController (){
    NSArray *Patients;
}

@end

@implementation BeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}
-(void) viewWillAppear:(BOOL)animated{
    Patients = [NSArray arrayWithObjects: @"Hirschi, Patrick (12.01.1990, m)", @"Gnägi, Johannes (28.03.1989, m)", @"Zehnder, Patrizia (16.08.1992, w)", nil];

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
    return Patients.count;
}

// Customize the appearance of table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableViewCellPatients";
    
    TableViewCellPatients *cell = (TableViewCellPatients *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[TableViewCellPatients alloc] init];
    }
    cell.beaconsLabelPatients.text=[Patients objectAtIndex:indexPath.row];
    NSLog(@"%@",cell.beaconsLabelPatients.text);

    return cell;
}

// define cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45.0;
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
