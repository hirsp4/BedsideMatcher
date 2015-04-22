//
//  LoginViewController.m
//  BedsideMatcher
//
//  Class that handles the login UI of BedsideMatcher. Input values not validated.
//
//  Created by Patrick Hirschi on 11.03.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 *  login button simply leads to tab bar controller of the application. no input validation!
 *
 *  @param sender UIButton
 */
- (IBAction)loginButton:(id)sender {
    [self performSegueWithIdentifier:@"showTabBarController" sender:sender];
}
@end
