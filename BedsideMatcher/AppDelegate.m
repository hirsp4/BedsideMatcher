//
//  AppDelegate.m
//  BedsideMatcher
//
//  Created by Fresh Prince on 10.03.15.
//  Copyright (c) 2015 Berner Fachhochschule. All rights reserved.
//

#import "AppDelegate.h"
#import "snfsdk.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize deviceManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    deviceManager = [[LeDeviceManager alloc] initWithSupportedDevices:@[[LeSnfDevice class]] delegate:self];
    [deviceManager startScan];
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

#pragma LeDeviceManagerDelegate Methods
- (void)leDeviceManager:(LeDeviceManager *)mgr didAddNewDevice:(LeDevice *)dev
{
    //set device delegate for call back
    ((LeSnfDevice *)dev).delegate = self;
    NSLog(@"added a device");
}

//delgate methods that are here for completion but not used

//used for tracking beacons and grouping them (implementation is up to you as no one way would work for everyone)
-(NSArray *)retrieveStoredDeviceUUIDsForLeDeviceManager:(LeDeviceManager *)mgr {
    return nil;
}
-(id)leDeviceManager:(LeDeviceManager *)mgr valueForDeviceUUID:(CFUUIDRef)uuid key:(NSString *)key {return nil;}
-(void)leDeviceManager:(LeDeviceManager *)mgr setValue:(id)value forDeviceUUID:(CFUUIDRef)uuid key:(NSString *)key {

}
-(void)leDeviceManager:(LeDeviceManager *)mgr didDiscoverDevice:(LeDevice *)dev advertisementData:(NSDictionary *)advData RSSI:(NSNumber *)RSSI{}


//this is used incase you have beacons around that are not reconized by the SDK
- (Class) leDeviceManager:(LeDeviceManager *)mgr didDiscoverUnknownPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advData RSSI:(NSNumber *)RSSI
{
    return nil;
}

#pragma LeSnfDeviceDelegate Methods


//this is called everytime the beacon changes state (connected, connecting, disconnected, and during fw updates)
-(void)leSnfDevice:(LeSnfDevice *)dev didChangeState:(int)state{
    switch (state) {
        case LE_DEVICE_STATE_CONNECTED:
            
            break;
            
        case LE_DEVICE_STATE_CONNECTING:
            
            break;
        case LE_DEVICE_STATE_DISCONNECTED:
            
            break;
            
        default: //firmware update
            
            break;
    }
    
}

//this is called when packets are recieved
- (void)didDiscoverLeSnfDevice:(LeSnfDevice *)dev {}

//called when broadcast data is updated
-(void)leSnfDevice:(LeSnfDevice *)dev didUpdateBroadcastData:(NSData *)data
{
}

//all of the didUpdate... methods are callbacks to confirm if something worked on not
-(void)leSnfDevice:(LeSnfDevice *)dev didUpdateBroadcastServiceData:(NSDictionary *)serviceDict {}
-(void)leSnfDevice:(LeSnfDevice *)dev didUpdateBroadcastUUID:(CBUUID *)uuid {}

//update firmware if needed
- (NSData *)firmwareDataForLeSnfDevice:(LeSnfDevice *)dev
{
    return nil;
}


- (NSData *)authenticationKeyforLeSnfDevice:(LeSnfDevice *)dev
{
    return nil;
}

-(BOOL)broadcastAuthStatus:(LeSnfAuthStatus)status forLeSnfDevice:(LeSnfDevice *)dev{
    return NO;
}

-(void)didSetBroadcastDataForLeSnfDevice:(LeSnfDevice *)dev success:(BOOL)success
{
    success == YES ? NSLog(@"written") : NSLog(@"not written");
}

-(void)didReadBroadcastData:(NSDictionary *)dict forLeSnfDevice:(LeSnfDevice *)dev {
    NSLog(@"%@", dict);
}

//several unused delegate methods... here for completion, but not used by this app
-(void)didSetBroadcastKeyForLeSnfDevice:(LeSnfDevice *)dev success:(BOOL)success {}
-(NSData *)broadcastKeyforLeSnfDevice:(LeSnfDevice *)dev atIndex:(int)index {return nil;}

//this method will be called after you click the page me button in the app (assuming the device is connected)
-(void)didEnableAlertForLeSnfDevice:(LeSnfDevice *)dev success:(BOOL)success {}
-(void)didEnableConnectionLossAlertForLeSnfDevice:(LeSnfDevice *)dev success:(BOOL)success {}
-(void)didSetPairingRssiForLeSnfDevice:(LeSnfDevice *)dev success:(BOOL)success {}
-(void)didSetTemperatureCalibrationForLeSnfDevice:(LeSnfDevice *)dev success:(BOOL)success{}
-(void)didReadTemperatureLog:(NSArray *)log forLeSnfDevice:(LeSnfDevice *)dev {}

@end
