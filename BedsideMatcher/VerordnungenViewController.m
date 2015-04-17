//
//  VerordnungenViewController.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 11.03.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "VerordnungenViewController.h"
#import "TableViewCellVerordnung.h"

@interface VerordnungenViewController (){

    NSArray *Verordnungen;
}

@end

@implementation VerordnungenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Create Array
    Verordnungen = [NSArray arrayWithObjects: @"Hirschi, Patrick (12.01.1990, m) \n Valium 10mg (0-0-0-1) ", @"Gnägi, Johannes (28.03.1989, m) \n Dafalgan 500mg (1-1-1-1)", @"Zehnder, Patrizia (16.08.1992, w) \n Resyl Plus Tr. 0-0-0-20)", nil];
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
    return Verordnungen.count;
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
    cell.verordnungsLabelPatient.numberOfLines=2;
    cell.verordnungsLabelPatient.text=[Verordnungen objectAtIndex:indexPath.row];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
