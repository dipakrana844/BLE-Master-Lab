import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/router_constants.dart';

/// Centralized navigation helpers for the entire application
///
/// Provides type-safe navigation methods for all registered routes.
/// Follows the pattern: goTo[RouteName]() and push[RouteName]()
class AppNavigation {
  // MARK: - Mode Selector Routes
  
  /// Navigate to Mode Selector screen
  static void goToModeSelector(BuildContext context) {
    context.goNamed(RouterConstants.modeSelectorName);
  }

  /// Push Mode Selector screen
  static void pushModeSelector(BuildContext context) {
    context.pushNamed(RouterConstants.modeSelectorName);
  }

  // MARK: - Device Discovery Routes
  
  /// Navigate to Device Discovery screen
  static void goToDeviceDiscovery(BuildContext context) {
    context.goNamed(RouterConstants.deviceDiscoveryName);
  }

  /// Push Device Discovery screen
  static void pushDeviceDiscovery(BuildContext context) {
    context.pushNamed(RouterConstants.deviceDiscoveryName);
  }

  // MARK: - BLE Routes
  
  /// Navigate to BLE Scan screen
  static void goToBleScan(BuildContext context) {
    context.goNamed(RouterConstants.bleScanName);
  }

  /// Push BLE Scan screen
  static void pushBleScan(BuildContext context) {
    context.pushNamed(RouterConstants.bleScanName);
  }

  /// Navigate to BLE Connection screen
  static void goToBleConnection(BuildContext context) {
    context.goNamed(RouterConstants.bleConnectionName);
  }

  /// Push BLE Connection screen
  static void pushBleConnection(BuildContext context) {
    context.pushNamed(RouterConstants.bleConnectionName);
  }

  // MARK: - GATT Explorer Routes
  
  /// Navigate to GATT Explorer screen
  static void goToGattExplorer(BuildContext context) {
    context.goNamed(RouterConstants.gattExplorerName);
  }

  /// Push GATT Explorer screen
  static void pushGattExplorer(BuildContext context) {
    context.pushNamed(RouterConstants.gattExplorerName);
  }

  // MARK: - Simulation Routes
  
  /// Navigate to BLE Simulation screen
  static void goToBleSimulation(BuildContext context) {
    context.goNamed(RouterConstants.bleSimulationName);
  }

  /// Push BLE Simulation screen
  static void pushBleSimulation(BuildContext context) {
    context.pushNamed(RouterConstants.bleSimulationName);
  }

  /// Navigate to Simulation Hub screen
  static void goToSimulationHub(BuildContext context) {
    context.goNamed(RouterConstants.simulationHubName);
  }

  /// Push Simulation Hub screen
  static void pushSimulationHub(BuildContext context) {
    context.pushNamed(RouterConstants.simulationHubName);
  }

  // MARK: - Protocol Analyzer Routes
  
  /// Navigate to Protocol Analyzer screen
  static void goToProtocolAnalyzer(BuildContext context) {
    context.goNamed(RouterConstants.protocolAnalyzerName);
  }

  /// Push Protocol Analyzer screen
  static void pushProtocolAnalyzer(BuildContext context) {
    context.pushNamed(RouterConstants.protocolAnalyzerName);
  }

  // MARK: - BLE Analyzer Routes
  
  /// Navigate to BLE Analyzer screen
  static void goToBleAnalyzer(BuildContext context) {
    context.goNamed(RouterConstants.bleAnalyzerName);
  }

  /// Push BLE Analyzer screen
  static void pushBleAnalyzer(BuildContext context) {
    context.pushNamed(RouterConstants.bleAnalyzerName);
  }

  // MARK: - OTA Update Routes
  
  /// Navigate to OTA Update screen
  static void goToOtaUpdate(BuildContext context) {
    context.goNamed(RouterConstants.otaUpdateName);
  }

  /// Push OTA Update screen
  static void pushOtaUpdate(BuildContext context) {
    context.pushNamed(RouterConstants.otaUpdateName);
  }

  // MARK: - Beacon Lab Routes
  
  /// Navigate to Beacon Lab screen
  static void goToBeaconLab(BuildContext context) {
    context.goNamed(RouterConstants.beaconLabName);
  }

  /// Push Beacon Lab screen
  static void pushBeaconLab(BuildContext context) {
    context.pushNamed(RouterConstants.beaconLabName);
  }

  // MARK: - Logs Console Routes
  
  /// Navigate to Logs Console screen
  static void goToLogsConsole(BuildContext context) {
    context.goNamed(RouterConstants.logsConsoleName);
  }

  /// Push Logs Console screen
  static void pushLogsConsole(BuildContext context) {
    context.pushNamed(RouterConstants.logsConsoleName);
  }
}