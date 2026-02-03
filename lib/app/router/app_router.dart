import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/mode_selector/presentation/screens/mode_selector_screen.dart';
import '../../features/device_discovery/presentation/screens/device_discovery_screen.dart';
import '../../features/gatt_explorer/presentation/screens/gatt_explorer_screen.dart';
import '../../features/simulation_hub/presentation/screens/simulation_hub_screen.dart';
import '../../features/protocol_analyzer/presentation/screens/protocol_analyzer_screen.dart';
import '../../core/constants/router_constants.dart';
final appRouterProvider = Provider<GoRouter>((ref) => GoRouter(
    initialLocation: RouterConstants.deviceDiscovery,
    routes: [
      GoRoute(
        path: RouterConstants.modeSelector,
        name: RouterConstants.modeSelectorName,
        builder: (context, state) => const ModeSelectorScreen(),
      ),
      GoRoute(
        path: RouterConstants.deviceDiscovery,
        name: RouterConstants.deviceDiscoveryName,
        builder: (context, state) => const DeviceDiscoveryScreen(),
      ),
      GoRoute(
        path: RouterConstants.bleScan,
        name: RouterConstants.bleScanName,
        builder: (context, state) => const Scaffold(body: Center(child: Text('BLE Scan'))),
      ),
      GoRoute(
        path: RouterConstants.bleConnection,
        name: RouterConstants.bleConnectionName,
        builder: (context, state) => const Scaffold(body: Center(child: Text('BLE Connection'))),
      ),
      GoRoute(
        path: RouterConstants.gattExplorer,
        name: RouterConstants.gattExplorerName,
        builder: (context, state) => const GattExplorerScreen(),
      ),
      GoRoute(
        path: RouterConstants.bleSimulation,
        name: RouterConstants.bleSimulationName,
        builder: (context, state) => const Scaffold(body: Center(child: Text('BLE Simulation'))),
      ),
      GoRoute(
        path: RouterConstants.bleAnalyzer,
        name: RouterConstants.bleAnalyzerName,
        builder: (context, state) => const Scaffold(body: Center(child: Text('BLE Analyzer'))),
      ),
      GoRoute(
        path: RouterConstants.otaUpdate,
        name: RouterConstants.otaUpdateName,
        builder: (context, state) => const Scaffold(body: Center(child: Text('OTA Update'))),
      ),
      GoRoute(
        path: RouterConstants.beaconLab,
        name: RouterConstants.beaconLabName,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Beacon Lab'))),
      ),
      GoRoute(
        path: RouterConstants.logsConsole,
        name: RouterConstants.logsConsoleName,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Logs Console'))),
      ),
      GoRoute(
        path: RouterConstants.simulationHub,
        name: RouterConstants.simulationHubName,
        builder: (context, state) => const SimulationHubScreen(),
      ),
      // Protocol Analyzer route
      GoRoute(
        path: RouterConstants.protocolAnalyzer,
        name: RouterConstants.protocolAnalyzerName,
        builder: (context, state) => const ProtocolAnalyzerScreen(),
      ),
    ],
  ));