class AppConstants {
  static const String appName = 'BLE Master Lab';
  static const String appVersion = '1.0.0';
  
  // BLE Constants
  static const int bleScanTimeout = 10000; // 10 seconds
  static const int bleConnectionTimeout = 15000; // 15 seconds
  static const int maxDevicesToScan = 50;
  
  // Storage Keys
  static const String userPreferencesKey = 'user_preferences';
  static const String bleDeviceHistoryKey = 'ble_device_history';
  static const String appSettingsKey = 'app_settings';
  
  // Navigation Routes
  static const String modeSelectorRoute = '/mode-selector';
  static const String bleScanRoute = '/ble-scan';
  static const String bleConnectionRoute = '/ble-connection';
  static const String gattExplorerRoute = '/gatt-explorer';
  static const String bleSimulationRoute = '/ble-simulation';
  static const String bleAnalyzerRoute = '/ble-analyzer';
  static const String otaUpdateRoute = '/ota-update';
  static const String beaconLabRoute = '/beacon-lab';
  static const String logsConsoleRoute = '/logs-console';
}