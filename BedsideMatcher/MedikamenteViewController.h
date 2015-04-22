//
//  MedikamenteViewController.h
//  BedsideMatcher
//
//  Created by Fresh Prince on 11.03.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "ViewController.h"

@interface MedikamenteViewController : ViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate>
@property (nonatomic, strong) NSMutableArray *scheduledPrescriptionsMorning;
@property (nonatomic, strong) NSMutableArray *scheduledPrescriptionsEvening;
@property (nonatomic, strong) NSMutableArray *scheduledPrescriptionsNight;
@property (nonatomic, strong) NSMutableArray *scheduledPrescriptionsNoon;
@property (nonatomic, strong) NSMutableArray *searchResultsMorning;
@property (nonatomic, strong) NSMutableArray *searchResultsEvening;
@property (nonatomic, strong) NSMutableArray *searchResultsNoon;
@property (nonatomic, strong) NSMutableArray *searchResultsNight;
@property (nonatomic, strong) NSMutableArray *scheduledPrescriptions;
@property (weak, nonatomic) IBOutlet UITableView *scheduledPrescriptionsTable;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSArray *patients;
@property (nonatomic, strong) NSArray *medications;

@end
