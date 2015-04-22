//
//  VerordnungenViewController.h
//  BedsideMatcher
//
//  Controller to list the patients sectioned in stations with the corresponding count of
//  open prescriptions.
//
//  Created by Patrick Hirschi on 11.03.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "ViewController.h"

@interface VerordnungenViewController : ViewController <UITableViewDelegate, UITableViewDataSource,UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewVerordnungen;
@property (nonatomic, strong) NSArray *patientsA;
@property (nonatomic, strong) NSArray *patientsB;
@property (nonatomic, strong) NSMutableArray *listPatientsA;
@property (nonatomic, strong) NSMutableArray *listPatientsB;
@property (nonatomic, strong) NSMutableArray *listPatients;
@property (nonatomic, strong) NSMutableArray *searchResultsA;
@property (nonatomic, strong) NSMutableArray *searchResultsB;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;



@end
