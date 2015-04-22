//
//  AppDelegate.m
//  BedsideMatcher
//
//  Created by Patrick Hirschi on 10.03.2015.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "AppDelegate.h"
#import "Patient.h"
#import "SupplyChainServicePortBinding.h"
#import "gender.h"
#import "bloodgroup.h"
#import "trspPatient.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // delete all core data patients and get the newest patient list from the webservice
    [self resetPatients];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "bfh.BedsideMatcher" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BedsideMatcher" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BedsideMatcher.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

/**
 *  deletes the stored patient objects in coredata and saves the newest patient list
 *  from the webservice.
 */
-(void)resetPatients
{
    // reset the core data patients
    [self deleteAllObjects:@"Patient"];
    // get a connection to supply chain service
    SupplyChainServicePortBinding* service = [[SupplyChainServicePortBinding alloc]init];
    // fetch all patients
    getPatientsResponse *result=[service getPatients:nil];
    // iterate and store all patients in core data
    for(int i=0;i<result.count;i++){
        [self savePatient:[result objectAtIndex:i]];
    }
    
}
/**
 *  saves a trspPatient object to core data
 *
 *  @param trsppatient an object of class trspPatient
 */
-(void)savePatient:(trspPatient *)trsppatient{
    // initialize a managed object inherited patient
    Patient *patient = [NSEntityDescription insertNewObjectForEntityForName:@"Patient"
                                                     inManagedObjectContext:self.managedObjectContext];
    // set the values of trspPatient to Patient
    [patient setValue:trsppatient.birthDate forKey:@"birthdate"];
    [patient setValue:trsppatient.beaconID forKey:@"minorid"];
    [patient setValue:trsppatient.lastname forKey:@"name"];
    [patient setValue:trsppatient.firstname forKey:@"firstname"];
    [patient setValue:[NSString stringWithFormat:@"%d", trsppatient.pid] forKey:@"polypointPID"];
    // convert the gender enumeration value to german strings
    gender *patientgender=trsppatient.gender;
    NSString *genderString;
    if([[patientgender stringValue]isEqualToString:@"male"]){
        genderString = @"männlich";
    }else genderString=@"weiblich";
    [patient setValue:genderString forKey:@"gender"];
    [patient setValue:trsppatient.stationName forKey:@"station"];
    [patient setValue:trsppatient.room forKey:@"room"];
    BOOL flag = trsppatient.getReaState;
    // convert the reha boolean enumeration value to german strings
    NSString *string = flag ? @"Ja" : @"Nein";
    [patient setValue:string forKey:@"reastate"];
    [patient setValue:[NSString stringWithFormat:@"%d",trsppatient.fid] forKey:@"caseID"];
    [patient setValue:[trsppatient.getBloodGroup stringValue] forKey:@"bloodgroup"];

    // insert the object in the managed object context
    [self.managedObjectContext insertObject:patient];
    NSError *error;
    // save the context
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
}

/**
 *  deletes managed objects for the given entity description (string)
 *
 *  @param entityDescription NSString value for the description of the core data entity
 */
- (void) deleteAllObjects: (NSString *) entityDescription  {
    // build the fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // set the entity description
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    // execute the fetch request
    NSError *error;
    NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    // delete all objects in the list
    for (NSManagedObject *managedObject in items) {
        [self.managedObjectContext deleteObject:managedObject];
    }
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to delete - error: %@", [error localizedDescription]);
    }
    
}

@end
