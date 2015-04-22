//
//  LoginViewController.h
//  BedsideMatcher
//
//  Class that handles the login UI of BedsideMatcher. Input values not validated.
//
//  Created by Patrick Hirschi on 11.03.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "ViewController.h"

@interface LoginViewController : ViewController
- (IBAction)loginButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end
