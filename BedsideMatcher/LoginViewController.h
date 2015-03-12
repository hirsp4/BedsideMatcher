//
//  LoginViewController.h
//  BedsideMatcher
//
//  Created by Fresh Prince on 11.03.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "ViewController.h"

@interface LoginViewController : ViewController
- (IBAction)loginButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end
