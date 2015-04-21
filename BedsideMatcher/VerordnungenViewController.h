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
@property (nonatomic, strong) NSArray *patients;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;



@end
