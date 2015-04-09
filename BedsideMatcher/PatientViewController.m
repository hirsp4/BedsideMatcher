//
//  PatientViewController.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 09.04.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "PatientViewController.h"

@interface PatientViewController ()

@end

@implementation PatientViewController
@synthesize nameLabel,firstnameLabel,genderLabel,birthdateLabel,navBar,patientImage,name,firstname,birthdate,gender,image;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    nameLabel.text=name;
    firstnameLabel.text=firstname;
    patientImage.image=image;
    birthdateLabel.text=birthdate;
    genderLabel.text=gender;
    [self setBackButtonAndTitle];
}

- (void)setBackButtonAndTitle{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton addTarget:self
                action:@selector(backToBeaconView:)
      forControlEvents:UIControlEventTouchUpInside];
    backButton.bounds = CGRectMake( 0, 0, 66, 31);
    [backButton setTitle:@"< Zurück" forState:UIControlStateNormal];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle: @"Patienteninfo"];
    item.leftBarButtonItem = backButtonItem;
    [navBar pushNavigationItem:item animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) backToBeaconView: (id) sender{
    [self performSegueWithIdentifier:@"backToBeaconView" sender:self];
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
