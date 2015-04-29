//
//  BarcodeViewController.h
//  BedsideMatcher
//
//  Class for the scanning of a patient barcode. Handles the scanned barcode and
//  initializes a patient view with the stored values for the given patient
//  in the database.
//
//  Created by Patrizia Zehnder on 01.04.2015.
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
@property (nonatomic, strong) NSArray *patients;
@property (nonatomic, strong) NSMutableString *patientPID;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, assign) BOOL hasScannedResult;

- (IBAction)didTap:(id)sender;

@end
