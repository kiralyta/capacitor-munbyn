#import <UIKit/UIKit.h>
#import <Capacitor/Capacitor.h>
#import "POSWIFIManager.h"

// Declare that the CapacitorMunbynPlugin class conforms to CAPPlugin
@interface CapacitorMunbynPlugin : CAPPlugin <POSWIFIManagerDelegate>

// Declare methods that will be called from the JS side
- (void)connect:(CAPPluginCall *)call;
- (void)disconnectWiFiDevice:(CAPPluginCall *)call;
- (void)sendWiFiCommand:(CAPPluginCall *)call;

@end
