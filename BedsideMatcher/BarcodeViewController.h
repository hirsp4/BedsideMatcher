//
//  BarcodeViewController.h
//  BedsideMatcher
//
//  Created by Patrizia Zehnder on 01/04/15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingObjC.h"

@interface BarcodeViewController : UIViewController <ZXCaptureDelegate>
@property (strong, nonatomic) IBOutlet UIView *scanView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBarBarcode;
@property (weak, nonatomic) IBOutlet UIView *scanRectView;
@property (weak, nonatomic) IBOutlet UILabel *decodedLabel;
@property (nonatomic, strong) ZXCapture *capture;
- (IBAction)didTap:(id)sender;

@end
