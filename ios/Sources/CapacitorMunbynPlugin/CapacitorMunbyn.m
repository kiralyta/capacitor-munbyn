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

- (void)load {
    [super load];
    self.isBold = NO; // Start with bold mode off
    self.isUnderlined = NO; // Start with underline mode off
}

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

- (void)toggleBold:(CAPPluginCall *)call {
    NSData *commandData;
    if (self.isBold) {
        // Disable bold mode (set to 0 or 49 depending on your printer's requirements)
        commandData = [PosCommand selectOrCancleBoldModel:48];
    } else {
        // Enable bold mode (set to 1 or 48 depending on your printer's requirements)
        commandData = [PosCommand selectOrCancleBoldModel:49];
    }

    [[POSWIFIManager shareWifiManager] POSWriteCommandWithData:commandData];
    self.isBold = !self.isBold; // Toggle the state
    [call resolve];
}

- (void)toggleUnderline:(CAPPluginCall *)call {
    NSData *commandData;
    if (self.isUnderlined) {
        // Disable underline mode
        commandData = [PosCommand selectOrCancleUnderLineModel:48]; // Replace 48 with the command to disable underline
    } else {
        // Enable underline mode
        commandData = [PosCommand selectOrCancleUnderLineModel:49]; // Replace 49 with the command to enable underline
    }

    [[POSWIFIManager shareWifiManager] POSWriteCommandWithData:commandData];
    self.isUnderlined = !self.isUnderlined; // Toggle the state
    [call resolve];
}


- (void)align:(CAPPluginCall *)call {
    NSString *to = [call getString:@"to" defaultValue:nil];
    NSUInteger alignment = 0; // Left

    if ([to isEqualToString:@"center"]) {
        alignment = 1; // Center
    } else if ([to isEqualToString:@"right"]) {
        alignment = 2; // Right
    }

    NSData *commandData = [PosCommand selectAlignment:alignment];
    [[POSWIFIManager shareWifiManager] POSWriteCommandWithData:commandData];
    [call resolve];
}

- (void)fontSize:(CAPPluginCall *)call {
    NSNumber *size = [call getNumber:@"value" defaultValue:nil];

    NSLog(@"Font size value passed: %@", size);

    int finalSize = 0x00;
    if ([size intValue] == 1) {
        finalSize = 0x11;  // 2x width and height
    } else if ([size intValue] == 2) {
        finalSize = 0x22;  // 3x width and height
    } else if ([size intValue] == 3) {
        finalSize = 0x33;  // 4x width and height
    } else if ([size intValue] == 4) {
        finalSize = 0x44;  // 5x width and height
    } else if ([size intValue] == 0) {
        finalSize = 0x00;  // Normal size (1x width and height)
    }

    NSLog(@"Final size (hex): 0x%X", finalSize);

    NSData *command = [PosCommand selectCharacterSize:finalSize];
    [[POSWIFIManager shareWifiManager] POSWriteCommandWithData:command];
    [call resolve];
}

// Send WiFi Command
- (void)print:(CAPPluginCall *)call {
    NSString *text = [call getString:@"text" defaultValue:nil];
    NSData *textData = [text dataUsingEncoding:NSUTF8StringEncoding];

    [[POSWIFIManager shareWifiManager] POSSendMSGWith:text];
    [call resolve];
}

// Set Logo
- (void)setLogo:(CAPPluginCall *)call {
    NSString *base64Image = [call getString:@"imageData" defaultValue:nil];

    if (base64Image == nil) {
        NSLog(@"Image data is required");
        return;
    }

    // Decode Base64 string to NSData
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:base64Image options:NSDataBase64DecodingIgnoreUnknownCharacters];

    if (imageData == nil) {
        NSLog(@"Invalid base64 image data");
        return;
    }

    UIImage *bmpImage = [UIImage imageWithData:imageData];

    if (bmpImage == nil) {
        NSLog(@"Unable to create image from the provided data");
        return;
    }

    // Based on the assumption of standard BMP type (monochrome) and print type (normal)
    int bmpType = 0;  // Assuming 0 for monochrome or standard BMP format
    int printType = 0;  // Assuming 0 for normal print (not double width or height))

    // Store the logo in flash memory at position 1
    NSData *defineBmpData = [PosCommand definedFlashBmpWithN:1 andBmp:bmpImage andBmpType:bmpType andPrintType:printType];

    if (defineBmpData == nil) {
        NSLog(@"Failed to define BMP data");
        return;
    }

    [[POSWIFIManager shareWifiManager] POSWriteCommandWithData:defineBmpData];
    [call resolve];
}

// Print logo
- (void)printLogo:(CAPPluginCall *)call {
    int flashPosition = 1; // The position where the image was stored, typically 0 for the first image
    int printMode = 0; // Print mode: 0 for normal, 1 for double width, 2 for double height, 3 for double width and height

    NSData *printBmpData = [PosCommand printBmpInFLASHWithN:flashPosition andM:printMode];

    if (printBmpData == nil) {
        NSLog(@"Failed to generate print command");
        return;
    }

    [[POSWIFIManager shareWifiManager] POSWriteCommandWithData:printBmpData];
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

// Check printer status
- (void)checkConnection:(CAPPluginCall *)call {
    // Generate the status command
    NSData *statusCommand = [PosCommand requestRealTimeForPrint:1];

    if (statusCommand == nil) {
        NSLog(@"Failed to generate status command");
        // [call reject:@"Failed to generate status command"];
        return;
    }

    // Send the command to the printer
    [[POSWIFIManager shareWifiManager] POSWriteCommandWithData:statusCommand];
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
