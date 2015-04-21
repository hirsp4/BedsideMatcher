//
//  MedikamenteViewController.h
//  BedsideMatcher
//
//  Created by Fresh Prince on 11.03.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "ViewController.h"

@interface MedikamenteViewController : ViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *scheduledPrescriptionsMorning;
@property (nonatomic, strong) NSMutableArray *scheduledPrescriptionsEvening;
@property (nonatomic, strong) NSMutableArray *scheduledPrescriptionsNight;
@property (nonatomic, strong) NSMutableArray *scheduledPrescriptionsNoon;
@property (nonatomic, strong) NSMutableArray *scheduledPrescriptions;
@property (weak, nonatomic) IBOutlet UITableView *scheduledPrescriptionsTable;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSArray *patients;
@property (nonatomic, strong) NSArray *medications;

@end
