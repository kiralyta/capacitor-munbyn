#import <UIKit/UIKit.h>
#import <Capacitor/Capacitor.h>
#import "POSWIFIManager.h"

// Declare that the CapacitorMunbynPlugin class conforms to CAPPlugin
@interface CapacitorMunbynPlugin : CAPPlugin <POSWIFIManagerDelegate>

@property (nonatomic, assign) BOOL isBold;
@property (nonatomic, assign) BOOL isUnderlined;
@property (nonatomic, assign) POSWIFIManager wifiManager;

// Declare methods that will be called from the JS side
- (void)connect:(CAPPluginCall *)call;
- (void)disconnect:(CAPPluginCall *)call;
- (void)newLine:(CAPPluginCall *)call;
- (void)cut:(CAPPluginCall *)call;
- (void)align:(CAPPluginCall *)call;
- (void)print:(CAPPluginCall *)call;
- (void)tableHeader:(CAPPluginCall *)call;

@end
