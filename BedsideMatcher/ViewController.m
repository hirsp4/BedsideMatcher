//
//  ViewController.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 10.03.15.
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
    // Do any additional setup after loading the view, typically from a nib.
    SupplyChainServicePortBinding* service = [[SupplyChainServicePortBinding alloc]init];
    NSLog(@"%@",[service sayHelloWorldFrom:@"Patrizia" __error:nil]);
    }

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController setSelectedIndex:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
