//
//  AppDelegate.h
//  BedsideMatcher
//
//  Created by Fresh Prince on 10.03.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "snfsdk.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,  LeSnfDeviceDelegate, LeDeviceManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) LeDeviceManager* deviceManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

