//
//  ViewController.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 10.03.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "ViewController.h"
#import "NIVSupplyChainServiceBinding.h"
#import "NIVwebServiceResult.h"
#import "NIVitem.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //NIVSupplyChainServiceBinding* service = [[NIVSupplyChainServiceBinding alloc]init];
    //NSLog(@"%@",[service sayHelloWorldFrom:@"Patrick" __error:nil]);
    //NIVwebServiceResult* result = [service getCheckedInItems:@"7640166731078" __error:nil];
   // NIVitem* item =[[result getItems]firstObject];
    //NSLog(@"%i",[[result getItems]count]);
    //NSLog(@"%@",[item getExpiryDate]);
     //NSLog(@"%@",[item getGTIN]);

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
