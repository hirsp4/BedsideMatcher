//
//  BeaconViewController.h
//  BedsideMatcher
//
//  Modified by Patrick Hirschi on 11.03.2015.
//
//  Main view controller of the application. Provides the possibility to perform bluetooth scans
//  for patients and display them in a table view. Alternatively the user can press the navigation bar
//  button to get to the BarcodeViewController and select the patient with a barcode scan.
//
//  Originally Created by Nick Toumpelis on 2013-10-06.
//  Copyright (c) 2013-2014 Nick Toumpelis.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "ViewController.h"

@import CoreLocation;
@import CoreBluetooth;

@interface BeaconViewController : UIViewController <CLLocationManagerDelegate, CBPeripheralManagerDelegate,
UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *beaconTableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBarBeacon;
@property (nonatomic, strong) NSArray *patients;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;


@end
