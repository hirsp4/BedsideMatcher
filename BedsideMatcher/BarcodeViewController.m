//
//  BarcodeViewController.m
//  BedsideMatcher
//
//  Created by Patrizia Zehnder on 01/04/15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "BarcodeViewController.h"

@interface BarcodeViewController ()

@end

@implementation BarcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// create Back-Button
- (void)setBackButton{
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Zurück" style:UIBarButtonItemStyleDone target:nil action:@selector(showBeaconView:)];
    
        UINavigationItem *item = [[UINavigationItem alloc] initWithTitle: @"Barcode scannen"];
    item.leftBarButtonItem=backButton;
    [_navBarBarcode pushNavigationItem:item animated:NO];
}

- (IBAction)showBeaconView:(id)sender {
    
    [self performSegueWithIdentifier:@"showBeaconView" sender:self];
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
