//
//  snfsdk.h
//  snfsdk
//
//  Created by Arne Hennig on 5/8/13.
//  Copyright (c) 2013 sticknfind. All rights reserved.
//

#import <Foundation/Foundation.h>
#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
#import <CoreBluetooth/CoreBluetooth.h>
#else
#import <IOBluetooth/IOBluetooth.h>
#endif
#import <MapKit/MKMapView.h>

@class LeDeviceManager;
@class LeDevice;



@protocol LeDeviceManagerDelegate <NSObject>
/**
 *  Called when a previously unknown peripheral has been added to the manager's device list as an instance of LeDevice
 *  Only called once per peripheral.
 */
- (void)        leDeviceManager: (LeDeviceManager *) mgr didAddNewDevice:(LeDevice*) dev;

/**
 *  Called when certain key-value pairs are associated with a distinct peripheral identifier
 *  e.g. LeDevice is associated with peripheral. device.peripheralIdentifier = peripheral.identifier
 *  Peripheral Identifier can be used to retrieve the same peripheral in a later session
 *  Key-value pair can be used to assign values to certain device keys after device retrieval
*/
- (void)        leDeviceManager: (LeDeviceManager *) mgr setValue: (id) value forDeviceUUID: (NSUUID *)uuid key:(NSString *)key;
@optional
/**
 *  Requests a list of known peripheral identifiers for which the devices shall be retrieved and added to the device list
 */
- (NSArray *)   retrieveStoredDeviceUUIDsForLeDeviceManager:(LeDeviceManager *)mgr;

/**
 *  Called if a known device was retrieved, but is missing certain values
 *  Requests the appropriate device value for the given key
 */
- (id)          leDeviceManager: (LeDeviceManager *) mgr valueForDeviceUUID: (NSUUID *)uuid key:(NSString *)key;

/**
 *  Called before a new SDK device class instance is added to the manager's device list
 *  Receiver can check the peripheral's details and advertisement data and either allow or prohibit adding the new device
 */
- (BOOL)        leDeviceManager: (LeDeviceManager *) mgr willAddNewDeviceForPeripheral:(CBPeripheral*) peripheral advertisementData: (NSDictionary *) advData;

/**
 *  Called to request an appropriate device class for an unknown peripheral
 *  The manager couldn't determine this device class itself. Either it hasn't been initialized with all the necessary device classes or this device is in fact incompatible.
 *  Receiver can check the peripheral's details and advertisement data to:
 *  - return the correct class and have the manager add a new instance of that class to its device list
 *  - return nil and keep the manager from adding a new device instance
 */
- (Class)       leDeviceManager: (LeDeviceManager *) mgr didDiscoverUnknownPeripheral:(CBPeripheral*) peripheral advertisementData: (NSDictionary *) advData RSSI:(NSNumber *)RSSI;

/**
 *  Called each time the CBCentralManager picks up a broadcast from a given device
 *  Passes on the latest advertisement data and rssi values for that device
 */
- (void)        leDeviceManager: (LeDeviceManager *) mgr didDiscoverDevice:(LeDevice *)dev advertisementData:(NSDictionary *)advData RSSI:(NSNumber *)RSSI;

/**
 *  Called upon changes in the CBCentralManager's state
 *  States can be used to determine whether the app is authorized to act as a Bluetooth central and whether Bluetooth is powered on on the device the app is running on
 */
- (void)        leDeviceManager: (LeDeviceManager *) mgr centralManagerDidChangeState:(CBCentralManagerState)state;

@end


/**
 *  LeDeviceManager is responsible for handling the management of the CBCentralManager class
 *  The main purposes include:
 *  - Scanning for BLE peripherals
 *  - Associating compatible peripherals with the device classes included in this SDK (e.g. LeSnfDevice)
 *  - Creating and storing a list of visible SDK devices
 */
@interface LeDeviceManager : NSObject <CBCentralManagerDelegate>

/**
 *  A list of SDK compatible device class instances (e.g. LeDevice)
 *  The list is recreated in each session and populated with currently visible devices
 *  The list is not persistent in between sessions
 *  A session ends with the dealloc of the LeDeviceManager
*/
@property (nonatomic,strong) NSMutableArray *devList;

/**
 *  The Core Bluetooth Central Manager
 */
@property (nonatomic)        CBCentralManager *btmgr;

/**
 *  LeDeviceManager's delegate
 */
@property (nonatomic,strong) id <LeDeviceManagerDelegate> delegate;

/**
 *  Determines whether the CBCentralManager should scan for distinct Service UUIDs 
 *  (e.g. only for peripherals compatible with the LeSnfDevice class)
 *  If set to YES, CBCentralManager will scan for ANY visible BLE device
 */
@property (nonatomic)        bool blindScan;

@property (nonatomic)        bool isScanning;

/**
 *  LeDeviceManager initialization
 *  Supported devices determine:
 *  - Service UUIDs to scan for if blindScan is set to NO
 *  - Device classes for which the manager can add instances to its device list
 *  For each app, there should only be one instance of LeDeviceManager
 */
- (id)      initWithSupportedDevices: (NSArray *) devCls delegate: (id <LeDeviceManagerDelegate>) del;

/**
 *  Starts the scan for BLE devices
 */
- (void)    startScan;

/**
 *  Stops the scan for BLE devices
 */
- (void)    stopScan;

@end

/**
 *  Standard definition for device completion blocks
 *  Called when:
 *  - A BLE device command was sent and the device received a response (LeDeviceCmdDoneBlock)
 *  - A SDK device class instance has finished a job (LeDeviceDoneBlock)
 */
typedef void (^LeDeviceCmdDoneBlock)(NSData *data, id context, NSError* error);
typedef void (^LeDeviceDoneBlock)(id context, NSError* error);

/**
 *  Possible beacon advertisement frame types
 *  Used to write individual settings for each possible advertisement type
 *  Command:            CSCMD_BEACON_ADV
 *  Detail Commands:    BCN_CMD_CYCLE_TXPOWER, BCN_CMD_RSP_TYPES
 */
#define BCN_ADV_TYPE_LEGACY                 0x00
#define BCN_ADV_TYPE_SBCNV2                 0x01
#define BCN_ADV_TYPE_IBEACON                0x02
#define BCN_ADV_TYPE_ACCEL_MOTION           0x03
#define BCN_ADV_TYPE_ACCEL_SPEC             0x04
#define BCN_ADV_TYPE_DV_DATA                0x05
#define BCN_ADV_TYPE_IBEACON_LINK           0x06
#define BCN_ADV_TYPE_SBCNV2_LIGHT           0x07
#define BCN_ADV_TYPE_COUNT                  8

@protocol LeDeviceDelegate <NSObject>
/**
 *  LeDevice class instances can have their peripherals reconnect automatically after an unintended disconnect
 *  Receiver can decide whether this reconnect should happen or not
 */
- (BOOL)leDeviceShouldReconnectAfterFailedConnection:(LeDevice *)dev;
@end

/**
 *  SDK device class
 *  This is the base device class for BluVision/StickNFind BLE beacons
 *  Features:
 *  - Handles the assigned CBPeripheral and acts as its delegate
 *  - Handles connection states
 *  - Handles parsing of peripheral advertisements
 *  - Handles reading and writing information from and to the peripheral
 *  - Handled firmware updates
 */
@interface LeDevice : NSObject <CBPeripheralDelegate>

/**
 *  Checks a given peripheral and its advertisement data for compatibility with the LeDevice class
 *  Returns NO for all peripherals as LeDevice is a base class and this method is supposed to be implemented by its subclasses
 */
+ (BOOL) canHandlePeripheral: (CBPeripheral*) peripheral advertisementData: (NSDictionary *)advertisementData;

/**
 *  Returns Service UUIDs the LeDeviceManager should scan for
 *  Returns an empty NSArray instance as LeDevice is a base class and this method is supposed to be implemented by its subclasses
 */
+ (NSArray *)   scanUUIDs;

/**
 *  Returns a unique ID identifying this device class
 */
+ (NSUUID *)    deviceTypeUUID;

/**
 *  LeDevice instance initialization
 *  - Associates a given peripheral with the device class instance
 *  - Registers device class instance as the peripheral's delegate
 *  - Associates LeDeviceManager class instance with the new device class instance
 */
- (id)   initWithPeripheral: (CBPeripheral *) _peripheral mgr: (LeDeviceManager *) __mgr;

/**
 *  Called from LeDeviceManager instance to pass the device class instance updated advertisement data
 *  Used to update analytics such as:
 *  - rssi
 *  - date of last discovery
 */
- (void) handleAdvertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;

/**
 *  Called from LeDeviceManager instance to inform the device class instance of a successful connection to the peripheral
 *  Updates connection state information (Connected)
 *  Triggers initial communication between device class instance and peripheral:
 *  - Service discovery
 *  - Characteristics discovery
 *  - Characteristics values
 */
- (void) didConnect;

/**
 *  Called from LeDeviceManager instance to inform the device class instance that the peripheral has (been) disconnected
 *  Updates connection state information (Disconnected)
 *  Checks for connection errors and reacts appropriately (e.g. by reconnecting)
 */
- (void) didDisconnectWithError: (NSError *) error;

/**
 *  Called from LeDeviceManager instance to inform the device class instance that a peripheral connection attempt has failed
 *  Updates connection state information (Disconnected)
 *  Parses connection error and reacts appropriately (e.g. by reconnecting)
 */
- (void) didFailToConnectWithError: (NSError *) error;

/**
 *  Called when the device class instance has sent a connection command to the peripheral
 */
- (void) didSendConnectCommand;

/**
 *  Called to start service discovery for the device class instance
 *  Service discovery commands for all available services will be sent to the peripheral
 */
- (void) sendDiscoverServiceCommand;

/**
 *  Called once all services of the peripheral have been discovered
 */
- (void) didDiscoverAllServices;

/**
 *  Clears all characteristic values in the device class instance's services dictionary
 *  Called upon connection, disconnection and when a peripheral sends the 'peripheralDidInvalidateServices:' message
 */
- (void) invalidateCharacteristics;

/**
 *  LeDevice instance delegate
 */
@property (nonatomic,strong)    id <LeDeviceDelegate>        delegate;

/**
 *  The CBPeripheral instance and therefore the physical device associated with the device class instance
 */
@property (nonatomic,strong)	CBPeripheral                *peripheral;

/**
 *  The peripheral's name attribute
 */
@property (nonatomic,strong)    NSString                    *name;

/**
 *  The peripheral's unique identifier
 *  This identifier is dynamically generated upon CBCentralManager's first contact with a Bluetooth peripheral
 *  iOS will keep this value and assign the same UUID to the same peripheral every time
 *  This value is persistent for each peripheral on the given iOS device, but will be different across devices
 *  It can not be used as a global cross-device device identifier
 */
@property (nonatomic,strong)    NSUUID                      *peripheralIdentifier;

/**
 *  The LeDeviceManager instance the device class instance was initialized with
 *  This manager handles connection states and callbacks for the device class instance
 */
@property (nonatomic)           LeDeviceManager             *mgr;

/**
 *  An arbitrary custom device description string
 *  Not read from the peripheral
 */
@property (nonatomic,readonly)  NSString                    *deviceDescription;

/**
 *  YES, if the device's peripheral is currently connected
 *  NO,  if the device's peripheral is not currently connected
 */
@property (nonatomic,readonly)  BOOL                        isConnected;

/**
 *  YES, if the device's peripheral should be currently connected
 *  NO,  if the device's peripheral should not be currently connected
 *  Used to determine wrong connection states
 *  e.g. peripheral is still connected after the disconnect command has been sent
 *  e.g. peripheral has been unintentionally disconnected
 */
@property (nonatomic,readonly)  BOOL                        shouldBeConnected;

/**
 *  Current peripheral RSSI value (Received Signal Strength Indication) in dbm
 *  Can be used in combination with other values (e.g. txPower) to determine the proximity of a peripheral
 *  Holds a negative logarithmic value. The larger the value, the stronger the received signal
 *  e.g. -35 = GOOD, -75 = AVERAGE, -90 = BAD
 */
@property (nonatomic,readonly)	int                         rssi;

/**
 *  Internal state when updating firmware
 */
@property (nonatomic,readonly) int                          fwloadState;

/**
 *  Percentual firmware loading progress
 */
@property (nonatomic,readonly) float                        fwloadProgress;

/**
 *  Date of the last peripheral discovery
 *  Gets reset each time an advertisement is picked up and forwarded to this device class instance / peripheral
 */
@property (nonatomic,strong)    NSDate                      *lastDiscoveryTime;

/**
 *  Date of the last peripheral disconnection
 */
@property (nonatomic,strong)    NSDate                      *disconnectionTime;

/**
 *  The number of received advertisements for this device class instance / peripheral
 */
@property (nonatomic,readonly)  uint64_t                    advCount;

/**
 *  Normal peripheral disconnect
 *  Disconnects from the peripheral if no command is currently pending execution
 */
- (void) disconnect;

/**
 *  Forced peripheral disconnect
 *  Cancels all pending commands for immediate disconnect
 */
- (void) forceDisconnect;

/** 
 *  Sends connect command to peripheral if peripheral is available and not currently connected or connecting
 */
- (void) connect;

/**
 *  Sends a user specified CSVC command to the peripheral
 *  The cmd value is written as value to the peripheral's CSVCIO characteristic
 *  This characteristic is the peripheral's command interface for reading and writing most beacon settings
 *  A command can either be sent isolated (first call) or with appended data (second call)
 *  Appended data can be used to write settings to a peripheral (e.g. setting up an iBeacon UUID)
 *  Context:    A custom context specified by the method sender that will be returned as an argument in the LeDeviceCmdDoneBlock
 *  Completion: Completion block that returns the data received from the peripheral in response to the sent command, the given context and - if available - a command error
 */
- (void) sendCSVCCommand: (uint8_t) cmd context: (id) context completion: (LeDeviceCmdDoneBlock) done;
- (void) sendCSVCCommand: (uint8_t) cmd bytes: (const void*)b length: (uint8_t) len context: (id) context completion: (LeDeviceCmdDoneBlock) done;

/**
 *  Fire and forget versions of the methods above
 *  These calls don't accept an completion block. Some command responses are handled internally by default. For most, these methods won't return a response
 */
- (void) sendCSVCCommand: (uint8_t) cmd bytes: (const void*)b length: (uint8_t) len;
- (void) sendCSVCCommand: (uint8_t) cmd;

/**
 *  Updates the status of a peripheral's link encryption internally
 *  If no link encryption commands are available for the given peripheral, the completion block will return an error
 */
- (void) readCSVCEncryptionStatus:(id) _context completion: (LeDeviceDoneBlock) _done;

/**
 *  Establishes a secure encrypted link to the device class instance's peripheral using the given key index and key
 *  If no user key is stored on the peripheral, this call will try establishing the secure link with a default unsecure key
 *  Upon first use of a beacon, it won't have a user key. The link is established using the default unsecure key until a user key is written and encryption is re-enabled using that key
 *  Completion block will return with an appropriate error if any step during the link setup fails
 */
- (void) enableCSVCEncryption: (NSData *)key keyIndex: (int) keyIndex context: (id) _context completion: (LeDeviceDoneBlock) _done;

/**
 *  Writes a user specified key to the peripheral that can be used to establish a secure encrypted link
 */
- (void) writeCSVCUserKey: (NSData *)key context: (id) _context completion: (LeDeviceDoneBlock) _done;

/**
 *  Locks or unlocks a peripheral using the user key
 *  _lock == YES -> lock unlocked peripheral
 *  _lock == NO  -> unlock locked peripheral
 *  Before calling this to lock a peripheral, a user key MUST be written to it
 *  If a user key is not available on a locked peripheral, it can no longer be connected using a secure link
 */
- (void) lockCSVCEncryption:(BOOL) _lock context: (id) _context completion: (LeDeviceDoneBlock) _done;

/**
 *  YES if a user key is available on the device class instance's peripheral
 *  NO  if a user key is NOT available on the device class instance's peripheral
 *  Only available once the peripheral is connected and the link encryption status has been read
 */
- (BOOL)linkEncryptionIsKeyAvailable;

/**
 *  YES if the peripheral is connected via secure encrypted link
 *  NO  if the peripheral is NOT connected via secure encrypted link
 *  Only available once the peripheral is connected and the link encryption status has been read
 */
- (BOOL)linkEncryptionIsEnabled;

/**
 *  YES if the peripheral is locked
 *  NO  if the peripheral is NOT locked
 *  Only available once the peripheral is connected and the link encryption status has been read
 */
- (BOOL)linkEncryptionIsActive;

/**
 *  YES if the peripheral is using v2 firmware loader
 *  NO  if the peripheral is NOT using v2 firmware loader
 *  Only available once the peripheral is connected and the firmware load information has been read
 */
- (BOOL)isFwloadV2;

/**
 *  Called when RSSI is updated
 */
- (void) setRssi: (int) rssi;

@end


/**
 *  Status enum for *old* peripheral authentication
 *  Gives feedback about the authentication status during a connection to the peripheral
 */
typedef enum
{
    LeSnfAuthStatusOpen=0,
    LeSnfAuthStatusAuthenticated,
    LeSnfAuthStatusWrongKey,
    LeSnfAuthStatusNoKey
} LeSnfAuthStatus;


@class LeSnfDevice;

@protocol LeSnfDeviceDelegate <LeDeviceDelegate>
@required

/**
 *  Called when the connection state of a device changes.
 */
- (void)        leSnfDevice: (LeSnfDevice *) dev didChangeState: (int) state;

@optional

/**
 *  Called when a broadcast from the device is received.
 */
- (void)        didDiscoverLeSnfDevice: (LeSnfDevice *) dev;

/**
 *  Called when a broadcast from the device is received that contains data set by the user.
 */
- (void)        leSnfDevice:(LeSnfDevice *)dev didUpdateBroadcastData: (NSData *) data;

/**
 *  Called when a service data broadcast from the device is received.
 */
- (void)        leSnfDevice:(LeSnfDevice *)dev didUpdateBroadcastServiceData: (NSDictionary *) serviceDict;

/**
 *  Called when a extra uuid field is received during scan.
 */
- (void)        leSnfDevice:(LeSnfDevice *)dev didUpdateBroadcastUUID: (CBUUID *) uuid;

/**
 *  Called to request firmware update data for the given device whenever 'updateFirmware' is called
 *  If a valid firmware image is given and the revision is higher than the one on the device,
 *  an update will be started either automatically or depending on the delegate's permission
 */
- (NSData *)    firmwareDataForLeSnfDevice: (LeSnfDevice *) dev;

/**
 *  Called to request permission to update firmware if a valid firmware image was given
 *  If permission is denied, no firmware update will be done
 *  If delegate method is not implemented, the firmware update will start automatically
 */
- (BOOL)        leSnfDevice: (LeSnfDevice *) dev shouldUpdateFirmwareRevision:(uint32_t)oldRev withFirmwareRevision:(uint32_t)rev;

/**
 *  Called after firmware was updated successfully
 */
- (void)        didUpdateFirmwareForLeSnfDevice: (LeSnfDevice *) dev;

/**
 *  Called to request an authentication key for the given device during connection.
 *  If the authentication feature was enabled on that device and the key does not match the device key, the connection will fail.
 */
- (NSData *)    authenticationKeyforLeSnfDevice:(LeSnfDevice *)dev;



/*
 Update of the estimated distance from the device.
 */
//- (void)        leSnfDevice:(LeSnfDevice *)dev didUpdateDistanceEstimate: (float) distance;

/*
 Update of the battery level (0 to 100) from the device.
 */
//- (void)        leSnfDevice:(LeSnfDevice *)dev didUpdateBatteryLevel: (int) level;

/*
 Update of the temperature from the device.
 */
//- (void)        leSnfDevice:(LeSnfDevice *)dev didUpdateTemperature: (int) temp;

/**
 *  Called when broadcast data was set
 */
- (void)        didSetBroadcastDataForLeSnfDevice: (LeSnfDevice *) dev success: (BOOL) success;

/**
 *  Called when broadcast key was set
 */
- (void)        didSetBroadcastKeyForLeSnfDevice: (LeSnfDevice *) dev success: (BOOL) success;

/**
 *  Called to request a broadcast key for the given device to authenticate re-writing it.
 */
- (NSData *)    broadcastKeyforLeSnfDevice:(LeSnfDevice *)dev atIndex: (int) index;

/**
 *  Called when authentication for a broadcast key is finished
 *  Return true to retry with a different key
 */
-  (BOOL)       broadcastAuthStatus: (LeSnfAuthStatus) status forLeSnfDevice: (LeSnfDevice *)dev;

/**
 *  Called when broadcast data was read
 */
-  (void)       didReadBroadcastData: (NSDictionary *) dict forLeSnfDevice: (LeSnfDevice *) dev;

/**
 *  Called when broadcast rate was set
 */
- (void)       didSetBroadcastRateForLeSnfDevice: (LeSnfDevice *) dev success: (BOOL) success;

/**
 *  Called when alert was set
 */
- (void)       didEnableAlertForLeSnfDevice: (LeSnfDevice *) dev success: (BOOL) success;

/**
 *  Called when connection loss alert was set
 */
- (void)       didEnableConnectionLossAlertForLeSnfDevice: (LeSnfDevice *) dev success: (BOOL) success;

/**
 *  Called when connection pairing rssi was set
 */
- (void)       didSetPairingRssiForLeSnfDevice: (LeSnfDevice *) dev success: (BOOL) success;

/**
 *  Called when temperature calibration was set
 */
-  (void)      didSetTemperatureCalibrationForLeSnfDevice:(LeSnfDevice *) dev success: (BOOL) success;

/**
 *  Called when temperature log was read
 */
-  (void)       didReadTemperatureLog: (NSArray *) log forLeSnfDevice: (LeSnfDevice *) dev;

/**
 *  Called to request the link encryption user key for the given device
 *  The returned dictionary must contain values for the following keys to be valid:
 *  @"key"      - User Key  (128 bit NSData *)
 *  @"index"    - Key Index (NSNumber *)
 *  Current user key index: 0x04
 */
- (NSDictionary *)  linkEncryptionKeyForLeSnfDevice: (LeSnfDevice *) dev;

/**
 *  Called to inform the delegate about the link encryption status after the link has either been established or failed
 *  Returns an error, if link could not be established
 */
- (void)            linkEncryptionStatusForLeSnfDevice: (LeSnfDevice *) dev error: (NSError *) error;

@end

/**
 *  Peripheral connection state information
 */
enum LE_DEVICE_STATE
{
    LE_DEVICE_STATE_DISCONNECTED=0,
    LE_DEVICE_STATE_CONNECTING,
    LE_DEVICE_STATE_CONNECTED,
    LE_DEVICE_STATE_UPDATING_FIRMWARE
};

/**
 *  Advertisement types
 *  Can be set during v1 advertisement setup
 */
typedef enum
{
    ADV_CONNECTABLE=0,
    ADV_NON_CONNECTABLE=1,
    ADV_SCANABLE=2
}ADV_TYPE;

/**
 *  Advertisement rate and power configuration as written to and read from the device
 *  Once the timeout_fast interval is reached within the device, it will switch from broadcasting with the fast interval to broadcasting with the slow interval
 *  This is called Night Mode or Energy Saving Mode
 *  Advertisement rates are set globally
 *  The individual broadcast rate for each beacon frame (iBeacon, sBeacon etc.) depends on its interleaving rate
 */
typedef struct BLE_ADV_CONFIG_T BLE_ADV_CONFIG_T;
struct BLE_ADV_CONFIG_T
{
    uint16_t	interval;			// normal connection interval
    uint16_t	interval_fast;		// fast connection interval
    uint16_t	interval_slow;		// slow connection interval
    
    uint16_t	timeout_fast;		// timeout for fast connection interval
    uint32_t	delay_slow;			// inactivity timer for slow connection interval
    
    uint16_t	interval_con;		// advertising interval when connected
    
    uint8_t		tx_cfg;				// normal adv tx power and channels
    uint8_t		tx_cfg_con;			// connection adv tx power and channels
};


/**
 *  LeDevice subclass
 *  Base SNF/BluVision beacon class
 */
@interface LeSnfDevice : LeDevice

/**
 *  Distance measurement status
 */
@property (readonly)            BOOL                            distanceMeasurementEnabled;

/**
 *  Current device connection state
 */
@property (nonatomic,readonly)  enum LE_DEVICE_STATE            state;

/**
 *  Device delegate
 */
@property (nonatomic,strong)    id <LeSnfDeviceDelegate>        delegate;

/**
 *  Device's software revision
 *  Available once connected
 */
@property (nonatomic,readonly)  uint32_t                        swRevision;

/**
 *  Percentual device battery level (0 to 100 (%))
 *  Available once connected
 */
@property (nonatomic,readonly)  int                             batteryLevel;

/**
 *  Last measured temperature in dec C
 *  Updated via sBeacon (v2) advertisement
 */
@property (nonatomic,readonly)  float                           temperature;

/**
 *  Last measured raw uncalibrated temperature in deg C
 */
@property (nonatomic,readonly)  float                           temperatureRaw;

/**
 *  Raw temperature values at -10,0,10,20,30,40,50 deg C
 */
@property (nonatomic)           NSArray *                       temperatureCalibrationValues;

/**
 *  Temperature log data
 */
@property (nonatomic,strong)    NSMutableArray *                temperatureLog;

/**
 *  Increments every time the device is tapped
 */
@property (nonatomic,readonly)  int                             buttonCounter;

/**
 *  Estimated distance
 */
@property (nonatomic,readonly)  float                           distanceEstimate;

/**
 *  Increments every time the device is connected
 */
@property (nonatomic,readonly)  int                             connectionCounter;

/**
 *  Increments every time the device is connected successfully
 */
@property (nonatomic,readonly)  int                             connectionSuccessCounter;

/**
 *  Raw device ID value
 *  Read via CSCMD_DEVICE_ID
 */
@property (nonatomic,readonly)  NSData*                         devid;

/**
 *  Device battery type
 *  Available once connected
 */
@property (nonatomic,readonly)  uint8_t                         batteryType;

/**
 *  Device type
 *  Available once connected
 */
@property (nonatomic,readonly)  uint8_t                         deviceType;

/**
 *  Device capabilities
 *  Available once connected
 */
@property (nonatomic,readonly)  uint16_t                        deviceCaps;

/**
 *  Device battery voltage
 *  Available once connected
 */
@property (nonatomic,readonly)  uint16_t                        batteryVoltage;

/**
 *  YES = Call 'updateFirmware' automatically once connected
 *  NO  = Don't call 'updateFirmware' automatically once connected
 */
@property (nonatomic)           BOOL                            firmwareUpdateOnConnect;

/**
 *  YES = Allow firmware updates with lower revisions than installed on the peripheral
 *  NO  = Don't allow firmware updates with lower revisions than installed on the peripheral
 */
@property (nonatomic)           BOOL                            allowFirmwareDowngrade;

/**
 *  Increments every time an authentication attempt is made during one connection
 *  If this counter exceeds the maximum retry value (AUTH_MAX_RETRIES), the auth key is considered wrong and the delegate will be called with an updated auth status
 *  - (BOOL)broadcastAuthStatus:(LeSnfAuthStatus)status forLeSnfDevice:(LeSnfDevice *)dev
 *  Status: LeSnfAuthStatusWrongKey
 */
@property (nonatomic,readonly)  int                             authCounter;

/*
    Flags for enabling dynamic data in broadcast packets
    The data is put in the order shown below.
*/
#define LeSnfDeviceBroadcastDynTemperature          0x01        /* include 1 signed byte for temperature in deg C */
#define LeSnfDeviceBroadcastDynBatteryLevel         0x02        /* include 1 byte for battery level in % */
#define LeSnfDeviceBroadcastDynButtonCounter1       0x04        /* include 1 byte for number of taps */
#define LeSnfDeviceBroadcastDynButtonCounter2       0x08        /* include 2 bytes for number of taps */
#define LeSnfDeviceBroadcastDynButtonCounter4       0x0C        /* include 4 bytes for number of taps */

/**
 *  Human readable tx power definitions for device values
 */
#define LeSnfDeviceTxPowerNeg40dBm          0
#define LeSnfDeviceTxPowerNeg20dBm          1
#define LeSnfDeviceTxPowerNeg16dBm          2
#define LeSnfDeviceTxPowerNeg12dBm          3
#define LeSnfDeviceTxPowerNeg8dBm           4
#define LeSnfDeviceTxPowerNeg4dBm           5
#define LeSnfDeviceTxPower0dBm              6
#define LeSnfDeviceTxPowerPos4dBm           7
#define LeSnfDeviceTxPowerDefault          -1

/**
 *  Human readable broadcast setting definitions for device values
 */
#define LeSnfDeviceBroadcastV2dynBatteryLevel       0x01
#define LeSnfDeviceBroadcastV2dynBatteryVoltage		0x02
#define LeSnfDeviceBroadcastV2dynTemperature        0x03
#define LeSnfDeviceBroadcastV2dynLinkLossCounter	0x04
#define LeSnfDeviceBroadcastV2dynScanDeviceCount	0x05
#define LeSnfDeviceBroadcastV2dynScanTime			0x06
#define LeSnfDeviceBroadcastV2dynStateTime			0x07
#define LeSnfDeviceBroadcastV2dynGbcnID             0x08
#define LeSnfDeviceBroadcastV2dynGbcnMAC            0x09

#define LeSnfDeviceBroadcastV2dynRssiValue			0x0C
#define LeSnfDeviceBroadcastV2dynRssiCalibration	0x0D
#define LeSnfDeviceBroadcastV2dynRssiCalibrationCh	0x0E
#define LeSnfDeviceBroadcastV2dynRssiCalibrationChId	0x0F
#define LeSnfDeviceBroadcastV2dynRssiValueDec3B     0x10


#define LeSnfDeviceBroadcastV2dynButtonCounter		0x20
#define LeSnfDeviceBroadcastV2dynStartupCounter		0x24
#define LeSnfDeviceBroadcastV2dynPacketCounter		0x28
#define LeSnfDeviceBroadcastV2dynAdvCounter			0x2C
#define LeSnfDeviceBroadcastV2dynScanCounter		0x30
#define LeSnfDeviceBroadcastV2dynFirmwareRevision	0x34
#define LeSnfDeviceBroadcastV2dynSystemTime			0x38
#define LeSnfDeviceBroadcastV2dynTapCounter         0x3C

/**
 *  Human readable battery type definitions for device values
 */
#define LeSnfDeviceBatteryTypeUnknown       0xFF
#define LeSnfDeviceBatteryTypeCR2016		0x00
#define LeSnfDeviceBatteryTypeCR2032		0x01
#define LeSnfDeviceBatteryTypeCR2477		0x02
#define LeSnfDeviceBatteryTypeER14505       0x03
#define LeSnfDeviceBatteryTypeAC            0xF0

/**
 *  Human readable device type definitions for device values
 */
#define LeSnfDeviceTypeUnknown              0xFF
#define LeSnfDeviceTypeTag24mm              0x01
#define LeSnfDeviceTypeTag27mm              0x02
#define LeSnfDeviceTypeTagAA                0x03
#define LeSnfDeviceTypeTagHQ                0x10
#define LeSnfDeviceTypeTagCC24mm            0x21
#define LeSnfDeviceTypeTagCC27mm            0x22
#define LeSnfDeviceTypeTagCCaa              0x23
#define LeSnfDeviceTypeBle2Wifi             0x28
#define LeSnfDeviceTypeBle2WifiV2           0x29

/**
 *  Human readable device capability definitions for device values
 */
#define LeSnfDeviceCapBuzzer                0x01
#define LeSnfDeviceCapLed                   0x02
#define LeSnfDeviceCapAccel                 0x04
#define LeSnfDeviceCapExtTempSensor         0x08

/**
 *  Human readable definitions for device advertisement types
 *  Used to parse advertisement manufacturer data
 */
#define SNF_ID_SBEACON_LEGACY               0x13
#define SNF_ID_SBEACON_V2                   0x01
#define SNF_ID_DF_DATA                      0x10
#define SNF_ID_ACCEL_MOTION                 0x42
#define SNF_ID_IBEACON_LINK_A               0x08
#define SNF_ID_IBEACON_LINK_B               0x09


/**
 *  UNTESTED
 *  Used to write an 64 bit sBeacon v2 ID (id64) to the peripheral
 *  ID value must be within a valid range
 *  Most SNF/BluVision beacons already have a factory ID that is not supposed to be changed
 *  Only call this for devices with 0xFFFFFFFFFFFFFFFF or 0x0000000000000000 IDs
 *  Can only be used once
 *  Returns NO, if the write process could not be started successfully
 *  LeDeviceDoneBlock will be called if either the operation has been completed successfully or has failed
 */
- (bool) setSBeaconID: (NSNumber *)sID
              context: (id) doneContext
           completion: (LeDeviceDoneBlock) done;


/**
 *  Used to switch on peripheral broadcasts for the given advertisement type (beacon frame)
 *  'rate' specifies the individual interleaving pattern for the specified beacon advertisement frame
 *  - e.g. if the iBeacon frame has a rate of 20 and the sBeacon frame a rate of 1, 20 iBeacon advertisements will be broadcast for 1 sBeacon broadcast
 *  - This results in individual broadcast rates for each beacon frame
 *  - In this case: iBeacon broadcast rate = broadcast rate / 21 * 20
 *  'txPower' specifies the individual transmit power for the specified beacon advertisement frame
 *  Returns NO, if the write process could not be started successfully
 *  LeDeviceDoneBlock will be called if either the operation has been completed successfully or has failed
 */
- (bool) setBeaconRate:(uint8_t) rate
               txPower: (int8_t) txPower
            beaconType: (uint8_t) type
               context: (id) donecontext
            completion: (LeDeviceDoneBlock) done;

/**
 *  See above
 *  Recent device firmwares allow setting individual 'rate' and 'txPower' values for energy saving mode
 *  As soon as a device enters energy saving mode, those 'night values' will be used instead of their 'day' counterparts
 */
- (bool) setBeaconRateDay:(uint8_t)  rateDay
               txPowerDay: (int8_t)  txPowerDay
                rateNight: (uint8_t) rateNight
             txPowerNight: (int8_t)  txPowerNight
               beaconType: (uint8_t) type
                  context: (id) donecontext
               completion: (LeDeviceDoneBlock) done;


/**
 *  Used to switch on iBeacon broadcasts for the peripheral with the given iBeacon UUID, Major and Minor values
 *  Calls 'setBeaconRate:' method for the iBeacon frame after setting up the UUID, Major and Minor on the device
 *  Returns NO, if the write process could not be started successfully
 *  LeDeviceDoneBlock will be called if either the operation has been completed successfully or has failed
 */
- (bool) enableIbeaconBroadcast: (NSUUID *) uuid
                          major: (uint16_t) major
                          minor: (uint16_t) minor
                           rate: (uint8_t) rate
                        txPower: (int8_t) txPower
                        context: (id) donecontext
                     completion: (LeDeviceDoneBlock) done;

/**
 *  Used to switch on iBeacon broadcasts for the peripheral with the given iBeacon UUID, Major and Minor values
 *  Calls 'setBeaconRateDay:' method for the iBeacon frame after setting up the UUID, Major and Minor on the device
 *  Returns NO, if the write process could not be started successfully
 *  LeDeviceDoneBlock will be called if either the operation has been completed successfully or has failed
 */
- (bool) enableIbeaconBroadcast: (NSUUID *) uuid
                          major: (uint16_t) major
                          minor: (uint16_t) minor
                        rateDay: (uint8_t) rateDay
                     txPowerDay: (int8_t)  txPowerDay
                      rateNight: (uint8_t) rateNight
                   txPowerNight: (int8_t) txPowerNight
                        context: (id) donecontext
                     completion: (LeDeviceDoneBlock) done;

/**
 *  Convenience method to set up the sBeacon v2 broadcast
 *  Calls 'setBeaconRate:' method for the sBeacon frame
 *  Returns NO, if the write process could not be started successfully
 *  LeDeviceDoneBlock will be called if either the operation has been completed successfully or has failed
 */
- (bool) setSbeaconRate: (uint8_t) rate
                txPower: (int8_t) txPower
                context: (id) donecontext
             completion: (LeDeviceDoneBlock) done;

/**
 *  Convenience method to set up the sBeacon v2 broadcast
 *  Calls 'setBeaconRateDay:' method for the sBeacon frame
 *  Returns NO, if the write process could not be started successfully
 *  LeDeviceDoneBlock will be called if either the operation has been completed successfully or has failed
 */
- (bool) setSbeaconRateDay: (uint8_t) rateDay
                txPowerDay: (int8_t)  txPowerDay
                 rateNight: (uint8_t) rateNight
              txPowerNight: (int8_t) txPowerNight
                   context: (id) donecontext
                completion: (LeDeviceDoneBlock) done;

/**
 *  Sets up the specified beacon frame with individual rates for:
 *  - Connectable       advertisements
 *  - Non-connectable   advertisements
 *  - Scan-response     advertisements
 *  The actual broadcast rate for each of those advertisement types is based on the global broadcast rate and the frame's interleave rate
 *  Returns NO, if the write process could not be started successfully
 *  LeDeviceDoneBlock will be called if either the operation has been completed successfully or has failed
 */
- (bool) setBeaconRspRateConnectable: (uint8_t) con
                           scannable: (uint8_t) scan
                      nonconnectable: (uint8_t) nocon
                                type: (uint8_t) type
                             context: (id) donecontext
                          completion: (LeDeviceDoneBlock) done;

/**
 *  Disables any v1 broadcasts for the given device
 *  Returns NO, if the write process could not be started successfully
 *  LeDeviceDoneBlock will be called if either the operation has been completed successfully or has failed
 */
- (BOOL) disableLegacyBroadcasting:(id)donecontext
                        completion:(LeDeviceDoneBlock)done;



/*
 V1 Call:
 Sets the broadcast data.
 dynData contains flags that enable the replacement of sections in the given data with dynamically created data
 like battery level or temperature.
 dynOfs is the offset at which the insertion of the dynamic data takes place.
 
 The device can transmit up to 4 different broadcast messages, identified by the index (0 to 3).
 Calling with nil as data will disable the broadcast message.
 
 The user is responsible for implementing a way of differentiating among the different broadcast messages on reception.

 The maximum data length is 29 Bytes.
 
 */
- (BOOL) setBroadcastData: (NSData *)data atIndex: (int) index dynData: (int) dyn dynOfs: (int) dynofs;

/*
 V1 Call:
 Sets the broadcast data with encryption.
 The encryptionRange section of the data will be encrypted with the key at keyIndex and randomlength bytes of random data as IV during each broadcast.
 The random data will be appended at the end of the given range, and will overwrite any data at those positions.
 */
- (BOOL) setEncryptedBroadcastData: (NSData *)data atIndex: (int) index dynData: (int) dyn dynOfs: (int) dynofs keyIndex: (int) kidx encryptionRange: (NSRange) encr randomLength: (int) rlen;

/*
 V1 Call:
 send raw broadcast data to device, formated as per Bluetooth spec
 */

- (BOOL) setEncryptedRawBroadcastData: (NSData *)  data         // the raw advertisement packet data
                              atIndex: (int)       index        // index of the packet
                         intervalSkip: (int)       intervalSkip // number of intervals to skip for interleaving
                               hwAddr: (NSData *)  hwAddr       // mac address is overriden when present
                         hwAddrPublic: (BOOL)      hwAddrPublic // type of mac address
                             advType:  (ADV_TYPE)  advType      // advertising type
                              txPower: (int)       txPower      // transmit power control
                               dynOfs: (int)       dynofs       // start of dynamic data
                            dynLength: (int)       dynLength    // length of dynamic data
                             keyIndex: (int)       kidx         // key index
                      encryptionRange: (NSRange)   encr         // range of data to encrypt
                         randomLength: (int)       rlen;        // number of random bytes to append



/*
 V1 Call:
 setup to broadcast as an apple iBeacon
 */
- (BOOL) setIBeaconBroadcastDataAtIndex: (int) index proximityUUID: (NSUUID *) proximityUUID major:(uint16_t)major minor:(uint16_t)minor signalAt1m: (int8_t) signal;

/*
 V1 Call:
 Sets one of the 128 bit AES encryption keys for encrypting broadcasts.
 */
- (BOOL) setBroadcastKey: (NSData *) key atIndex: (int) index;


/*
 V1 Call:
 Initiates a readback of broadcast data set at a given index
 */
- (BOOL) readBroadcastDataAtIndex: (int) index;

/**
 *  Reads back the details of a given range of advertisement frames
 *  If range is specified as (0,0), all available frames will be read
 *  Returns NO, if the write process could not be started successfully
 *  LeDeviceDoneBlock will be called if either the operation has been completed successfully or has failed
 *  LeDeviceDoneBlock returns an instance of NSDictionary as context. This dictionary includes:
 *  - an NSDictionary instance for each advertisement frame type
 *  - the original context (key: @"context")
 */
- (BOOL) readBeaconAdvRange:(NSRange)range context:(id)context completion:(LeDeviceDoneBlock)done;

/*
 Sets the 128 bit authentication key.
 If set, the device will only connect to previously paired clients and those that provide the
 given key during connection.
 
 To allow any device to connect using that key, also set the pairingRssi to a low enough value
 as it will still limit the range for any new connection.
 
 The feature is is only enabled for stickers with OEM firmware.
 */
- (BOOL) setAuthenticationKey: (NSData *) authkey context:(id)donecontext completion:(LeDeviceDoneBlock)done;

/*
 Sets the number of broadcast data transmissions per second.
 The rate will change to the rate2 after timeout seconds.
 
 The range for the rate is from 0.1Hz to 100Hz.
 The setting will affect the power usage / battery life when not connected.
 Use low rates to save battery life.
 
 The minimum timeout value is 1.
 */
- (BOOL) setBroadcastRate: (float) rate
                  timeout: (float) timeout
                    rate2: (float) rate2
                  context: (id) donecontext
             completion: (LeDeviceDoneBlock) done;

- (BOOL) setBroadcastInterval: (uint16_t) interval timeout: (float) timeout interval2: (uint16_t) interval2 timeout2: (int) timeout2 interval3: (uint16_t) interval3 txPower: (uint8_t) txPower;

/*
 Enables the measurement of rssi based distance.
 */
- (BOOL) enableDistanceMeasurement: (BOOL) enable;

/*
 Set the number of data transmissions per second (1,2,5 or 10)
 The rate will influence the battery life during connection and the response speed
 of commands sent to the device.
 */
- (BOOL) setConnectionRate: (int) rate;

/*
 minimum required signal strength to allow a connection to a non-paired client.
 by default, the device is set to -60dBm, allowing pairing / initial connection only from close distance.
 
 it can be set to a lower value to allow for more range.
 */
- (BOOL) setPairingRssi: (int) level;


/*
 enables the audible and/or light alert on the device.
 */
- (BOOL) enableAlertSound: (BOOL) snd light: (BOOL) light;

/*
 enables the audible and/or light alert on the device when a connection is lost.
 This can be used as a leash feature.
 The alert will not be activated if the device is disconnected on purpose using
 the disconnect call.
 */
- (BOOL) enableConnectionLossAlertSound: (BOOL) snd light: (BOOL) light;

/*
 initiates a read of the temperature from the device
 */
- (BOOL) readTemperature;

/*
 set the real temperature in deg C to calibrate a device temperature sensor
 */
- (BOOL) setTemperatureCalibration: (float) realTemperature;

/*
 set the temperature difference between board sensor and real temperature in K
 */
- (BOOL) writeTemperatureCalibration;


/*
 initiates a read of the battery level from the device
 */
- (BOOL) readBatteryLevel;

/*
 Decrypts received broadcast data.
 The settings have to match the ones used in setEncryptedBroadcastData.
 */
- (NSData *) decryptBroadcastData: (NSData *) d key: (NSData *) keydata encryptionRange: (NSRange) encr randomLength: (int) rlen;

/*
 Decrypts received broadcast data in ECB mode, used for adv index 4
 The settings have to match the ones used in setEncryptedRawBroadcastData.
 */
+ (NSData *) decryptECBBroadcastData: (NSData *) d key: (NSData *) keydata encryptionRange: (NSRange) encr;


/*
 V1 Call:
 Enable broadcast at given index in format:
 USER_ADV_DATA_T
 */
- (BOOL) setBroadcastDataName: (NSData *)data atIndex: (int) index;

/**
 *  Enables device temperature logging with given interval
 */
- (BOOL) enableTemperatureLoggingWithInterval: (uint16_t) interval;

/**
 *  Returns calibrated temperature value for given raw value in dec C
 */
- (float) calibratedTemperatureValue: (int16_t) raw_value;

/**
 *  Reads device temperature log and stores it in 'temperatureLog' property
 */
- (BOOL) readTemperatureLog;

/**
 *  Clears device temperature log
 */
- (BOOL) eraseTemperatureLog;

/**
 *  Writes specified name to device
 */
- (void) writeDeviceName: (NSString*) name;

/**
 *  Read device advertisement stats
 *  Returns NO, if the write process could not be started successfully
 *  LeDeviceDoneBlock will be called if either the operation has been completed successfully or has failed
 *  LeDeviceDoneBlock returns an instance of NSDictionary as context. This dictionary includes:
 *  - each stats value
 *  - the original context (key: @"context")
 */
- (void) readAdvStatsContext:(id)context completion:(LeDeviceDoneBlock)done;


/**
 *  Read device advertisement settings
 *  Returns NO, if the write process could not be started successfully
 *  LeDeviceDoneBlock will be called if either the operation has been completed successfully or has failed
 *  LeDeviceDoneBlock returns an instance of NSDictionary as context. This dictionary includes:
 *  - NSData instance containing the settings (broadcast rates etc.)
 *  - the original context (key: @"context")
 */
- (void) readAdvSettingsContext:(id)context completion:(LeDeviceDoneBlock)done;

/**
 *  Returns a human readable battery type string for the device's battery type
 */
- (NSString *) batteryTypeString;

/**
 *  Returns the firmware revision from a given firmware image
 */
+ (uint32_t) revisionForFirmwareData: (NSData *) firmwareData;

/**
 *  Returns the actual firmware size in bytes from a given firmware image
 *  This value differs from the firmware image size
 */
+ (uint32_t) sizeForFirmwareData: (NSData *) firmwareData;

/**
 *  Set the device time value
 */
- (BOOL) setDeviceTime: (uint32_t) time;

/**
 *  Starts a firmware update
 *  Retrieves a firmware image from the device delegate
 *  Requests permission to start firmware update from the device delegate
 */
- (BOOL) updateFirmware;

/**
 *  Set a time interval for the device power off
 */
- (BOOL) setPowerOffTimeout: (uint32_t) timeout;

/**
 *  Sets different device broadcast modes
 *  e.g.: broadcast with or without manufacturer data
 */
- (void) setBroadcastMode: (uint8_t) mode;

/**
 *  V1 Call
 *  Used to setup sBeacon and iBeacon v1 advertisement data on the device
 *  Either including iBeacon major and minor values or not
 *  This method does not enable broadcasting. It only writes the advertised data to the device
 *  sBcnSkip and iBcnSkip work the opposite way of the v2 interleave rates:
 *  - iBcnSkip = 20 == iBeaconRate = 1
 *  - sBcnSkip = 1  == sBeaconRate = 20
 */
- (void) writeSnfBeaconPacketWithId: (uint64_t) sID
                            txPower: (int)      txPower
                           sBcnSkip: (uint8_t)  sBcnSkip
                        iBeaconUUID: (NSUUID *) uuid
                           iBcnSkip: (uint8_t)  iBcnSkip;

- (void) writeSnfBeaconPacketWithId: (uint64_t) sID
                            txPower: (int)      txPower
                           sBcnSkip: (uint8_t)  sBcnSkip
                        iBeaconUUID: (NSUUID *) uuid
                           iBcnSkip: (uint8_t)  iBcnSkip
                              major: (uint16_t) major
                              minor: (uint16_t) minor;

@end


@class LeBlutrackerDevice;
@protocol LeBlutrackerDeviceDelegate <LeDeviceDelegate>

/*
 called when a broadcast from the device is received that contains data set by the user.
 */
- (void)        leBlutrackerDevice:(LeBlutrackerDevice *)dev didUpdateBroadcastData: (NSData *) data;

/*
 called when a broadcast from the device is received. the key index corresponds to the index in the array sent when the broadcastKeyForLeBlutrackerDevice method was called. if keyIndex = -1 it means no key was able to decrypt advertisement data.
 */
- (void)        didDiscoverLeBlutrackerDevice: (LeBlutrackerDevice *) dev withKeyIndex:(int)keyIndex;

/*
 called to request firmware update data.
 if a valid firmware image is given and the version is newer than the one on the device,
 an update will happen on the next connection.
 */
- (NSData *)    firmwareDataForLeBlutrackerDevice: (LeBlutrackerDevice *) dev;

/*
 called after firmware is updated.
 */
- (void)        didUpdateFirmwareForLeSnfDevice: (LeSnfDevice *) dev;

/*
 called when the connection state of a device changes.
 */
- (void)        leBlutrackerDevice: (LeBlutrackerDevice *) dev didChangeState: (int) state;

/*
 called to request the broadcast encryption key for the given device.
 It is used to decrypt the loacation broadcast.
 */
- (NSArray *)    broadcastKeyForLeBlutrackerDevice:(LeBlutrackerDevice *)dev;


/*
 called to request the broadcast encryption key for the given device.
 It is used to decrypt the loacation broadcast.
 */
- (NSData *)    newBroadcastKeyForLeBlutrackerDevice:(LeBlutrackerDevice *)dev;

/*
 called when key was written to device
 */
- (void)    didWriteBroadcastKeyForLeBlutrackerDevice:(LeBlutrackerDevice *)dev;


- (void)    didReadGpsLog: (NSArray *) log forLeBlutrackerDevice:(LeBlutrackerDevice *)dev;

@end



@interface LeBlutrackerDevice : LeDevice  <MKAnnotation>
{
    CLLocationCoordinate2D _coord;
}

@property (nonatomic,readonly,copy)	NSString *title;
@property (nonatomic,readonly,copy)	NSString *subtitle;
@property (nonatomic,readonly)	CLLocationCoordinate2D coordinate;

@property (nonatomic, strong)       NSString *svInfo;
@property (nonatomic, strong)       NSString *navInfo;

@property (nonatomic,readonly)  enum LE_DEVICE_STATE                state;                      /* status of connection to device */
@property (nonatomic,strong)    id <LeBlutrackerDeviceDelegate>     delegate;                   /* the delegate */

@property (readonly)            BOOL                                bcKeyEnabled;               /* broadcast key enabled */

@property (readonly)            BOOL                                gpsEnabled;
@property (readonly)            BOOL                                logEnabled;


- (BOOL) writeBroadcastKey: (NSData *) key;
- (BOOL) startLogging: (uint16_t) interval;
- (BOOL) readLogs;
- (BOOL) enableGps;
- (BOOL) disableGps;


@end






















