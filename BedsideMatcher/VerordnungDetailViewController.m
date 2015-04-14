//
//  VerordnungDetailViewController.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 13.04.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "VerordnungDetailViewController.h"

@interface VerordnungDetailViewController ()

@end

@implementation VerordnungDetailViewController
@synthesize navBar;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackButtonAndTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBackButtonAndTitle{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton addTarget:self
                   action:@selector(backToVerordnungenView:)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.bounds = CGRectMake( 0, 0, 66, 31);
    [backButton setTitle:@"< Zurück" forState:UIControlStateNormal];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle: @"Verordnungsinfo"];
    item.leftBarButtonItem = backButtonItem;
    [navBar pushNavigationItem:item animated:NO];
}
- (void) backToVerordnungenView: (id) sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
