export interface CapacitorMunbynPlugin {
  // WiFi Methods
  connect(options: ConnectWiFiOptions): Promise<void>;
  disconnect(): Promise<void>;
  newLine(): Promise<void>;
  cut(): Promise<void>;
  print(options: SendCommandOptions): Promise<void>;
  tableHeader(options: TableHeaderOptions): Promise<void>;

  // Event Listener Methods
  addListener(eventName: 'wifiConnected', listenerFunc: (result: WiFiConnectedResult) => void): Promise<PluginListenerHandle>;
  addListener(eventName: 'wifiDataWritten', listenerFunc: (result: WiFiDataWrittenResult) => void): Promise<PluginListenerHandle>;
}

// Define types for sending commands to the BLE or WiFi device
export interface SendCommandOptions {
  text: string; // Command string to send (e.g., text to print or barcode data)
}

// Define types for WiFi connection options
export interface ConnectWiFiOptions {
  host: string;  // IP address of the WiFi printer
  port: number;  // Port number to connect to
}

// Define WiFi connection success result
export interface WiFiConnectedResult {
  host: string;   // IP address of the connected WiFi device
  port: number;   // Port number of the connected WiFi device
}

// Define WiFi data written result
export interface WiFiDataWrittenResult {
  tag: number;    // Tag identifying the data that was written
}

// Define PluginListenerHandle interface (provided by Capacitor)
export interface PluginListenerHandle {
  remove: () => void;
}

// Define types for sending table header
export interface TableHeaderOptions {
  data: Array<string>;
}
