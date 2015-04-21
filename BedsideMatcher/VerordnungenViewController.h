//
//  VerordnungenViewController.h
//  BedsideMatcher
//
//  Created by Fresh Prince on 11.03.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "ViewController.h"

@interface VerordnungenViewController : ViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *searchPrescriptionField;
@property (weak, nonatomic) IBOutlet UITableView *tableViewVerordnungen;
@property (nonatomic, strong) NSArray *patientsA;
@property (nonatomic, strong) NSArray *patientsB;
@property (nonatomic, strong) NSMutableArray *listPatientsA;
@property (nonatomic, strong) NSMutableArray *listPatientsB;
@property (nonatomic, strong) NSMutableArray *listPatients;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;



@end
