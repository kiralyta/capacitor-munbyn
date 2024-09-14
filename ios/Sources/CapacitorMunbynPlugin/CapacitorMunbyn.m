#import <Capacitor/Capacitor.h>
#import "POSWIFIManager.h"
#import "TscCommand.h"
#import "PosCommand.h"
#import "ImageTranster.h"
#import "CapacitorMunbyn.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <Capacitor/Capacitor-Swift.h>
#import <Capacitor/CAPBridgedPlugin.h>
#import <Capacitor/CAPBridgedJSTypes.h>

@implementation CapacitorMunbynPlugin  // Start the @implementation block

// WiFi Connection Method
- (void)connect:(CAPPluginCall *)call {
    NSString *host = [call getString:@"host" defaultValue:nil];
    NSNumber *port = [call getNumber:@"port" defaultValue:nil];

    POSWIFIManager *wifiManager = [POSWIFIManager shareWifiManager];
    [wifiManager POSConnectWithHost:host port:port completion:^(BOOL success) {
        if (success) {
            [call resolve];
        } else {
            // [call reject:@"Failed to connect to WiFi printer"];
        }
    }];
}

// Disconnect WiFi Device
- (void)disconnect:(CAPPluginCall *)call {
    [[POSWIFIManager shareWifiManager] POSDisConnect];
    [call resolve];
}

// Disconnect WiFi Device
- (void)newLine:(CAPPluginCall *)call {
    NSData *commandData = [PosCommand printAndFeedLine];

    [[POSWIFIManager shareWifiManager] POSWriteCommandWithData:commandData];
    [call resolve];
}

- (void)cut:(CAPPluginCall *)call {
    NSData *commandData = [PosCommand selectCutPageModelAndCutpage:48];

    [[POSWIFIManager shareWifiManager] POSWriteCommandWithData:commandData];
    [call resolve];
}


// Send WiFi Command
- (void)print:(CAPPluginCall *)call {
    NSString *text = [call getString:@"text" defaultValue:nil];
    NSData *textData = [text dataUsingEncoding:NSUTF8StringEncoding];

    [[POSWIFIManager shareWifiManager] POSSendMSGWith:text];
    [call resolve];
}

// Event when WiFi Manager connects
- (void)POSWIFIManager:(POSWIFIManager *)manager didConnectedToHost:(NSString *)host port:(UInt16)port {
    [self notifyListeners:@"wifiConnected" data:@{@"host": host, @"port": @(port)}];
}

// Event when data is written to the WiFi device
- (void)POSWIFIManager:(POSWIFIManager *)manager didWriteDataWithTag:(long)tag {
    [self notifyListeners:@"wifiDataWritten" data:@{@"tag": @(tag)}];
}

// Send table header
- (void)tableHeader:(CAPPluginCall *)call {
    id data = [call.options objectForKey:@"data"];

    if ([data isKindOfClass:[NSArray class]]) {
        // Calculate the column width
        NSArray *arrayData = (NSArray *)data;
        NSUInteger totalWidth = 50;  // Total width for the table
        NSUInteger numberOfColumns = [data count];
        NSUInteger columnWidth = numberOfColumns > 0 ? totalWidth / numberOfColumns : 0;

        // Print first line of table
        NSString *text = @"----------------------------------------";
        [[POSWIFIManager shareWifiManager] POSSendMSGWith:text];

        // New line
        // NSData *commandData = [PosCommand printAndFeedLine];
        // [[POSWIFIManager shareWifiManager] POSWriteCommandWithData:commandData];

        // Table Header
        for (NSUInteger i = 0; i < numberOfColumns; i++) {
            NSString *texty = [arrayData objectAtIndex:i];
            NSUInteger currentColumnLength = [texty length] - 1;

            [[POSWIFIManager shareWifiManager] POSSendMSGWith:texty];

            // Ensure 'y' is used as the loop variable
            NSUInteger paddingWidth = columnWidth - currentColumnLength;

            for (NSUInteger y = currentColumnLength; y < paddingWidth; y++) {
                [[POSWIFIManager shareWifiManager] POSSendMSGWith:@" "];
            }
        }

        // New line
        // [[POSWIFIManager shareWifiManager] POSWriteCommandWithData:commandData];

        // Print end line of header
        // [[POSWIFIManager shareWifiManager] POSSendMSGWith:text];

    } else {
        NSLog(@"Data is not an array or is nil.");
    }

    [call resolve];
}

@end
