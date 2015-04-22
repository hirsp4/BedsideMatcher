//
//  ViewController.m
//  BedsideMatcher
//
//  Default generated ViewController class in a tabbar application.
//
//  Created by Patrick Hirschi on 10.03.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "ViewController.h"
#import "SupplyChainServicePortBinding.h"
#import "webServiceResult.h"
#import "item.h"
#import "BeaconViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController setSelectedIndex:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
