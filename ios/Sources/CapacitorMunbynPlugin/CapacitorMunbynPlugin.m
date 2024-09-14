#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(CapacitorMunbynPlugin, "CapacitorMunbyn",
    CAP_PLUGIN_METHOD(connect, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(disconnect, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(newLine, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(cut, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(print, CAPPluginReturnPromise);
)
