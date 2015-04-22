//
//  MedikamenteViewController.h
//  BedsideMatcher
//
//  Controller to list all scheduled prescriptions of the hospital sectioned in
//  morning, noon, evening and night. The view provides a search bar allowing to search
//  for patient name, patient firstname or the station identifier. Provides a quick overview
//  of the situation for the employees.
//
//  Created by Patrick Hirschi on 11.03.2015.
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
