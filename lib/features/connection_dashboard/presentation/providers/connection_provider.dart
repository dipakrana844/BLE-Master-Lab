
import 'package:flutter_riverpod/legacy.dart';

import '../models/connection_ui_state.dart';

// State notifier provider for connection data
final connectionNotifierProvider =
    StateNotifierProvider<ConnectionNotifier, ConnectionUiState>((ref) => ConnectionNotifier());

class ConnectionNotifier extends StateNotifier<ConnectionUiState> {
  ConnectionNotifier() : super(const ConnectionUiStateInitial()) {
    // Initialize with sample data
    state = const ConnectionUiStateData(
      deviceName: 'Nordic_UART_01',
      deviceId: 'F8:33:A1:02',
      rssiValue: -65.0,
      rssiHistory: [-68, -67, -66, -65, -64, -65, -66, -67, -66, -65],
      mtuSize: 247,
      phyLayer: '2M LE',
      connectionInterval: 15.0,
      latency: 0,
      connectionSteps: [
        ConnectionStep(
          title: 'Scanning & Discovery',
          subtitle: 'Device found: F8:33:A1:02',
          status: ConnectionStepStatus.completed,
        ),
        ConnectionStep(
          title: 'ACL Connection Established',
          subtitle: 'Handshake successful in 142ms',
          status: ConnectionStepStatus.completed,
        ),
        ConnectionStep(
          title: 'Service Discovery',
          subtitle: 'Enumerating GATT services (85%)',
          status: ConnectionStepStatus.active,
          showProgressIndicator: true,
        ),
        ConnectionStep(
          title: 'Security Exchange',
          subtitle: 'Bonding and encryption pending',
          status: ConnectionStepStatus.pending,
        ),
      ],
      isAutoReconnectEnabled: true,
    );
  }

  // Method to toggle auto reconnect
  void toggleAutoReconnect() {
    final currentState = state;
    if (currentState is ConnectionUiStateData) {
      state = ConnectionUiStateData(
        deviceName: currentState.deviceName,
        deviceId: currentState.deviceId,
        rssiValue: currentState.rssiValue,
        rssiHistory: currentState.rssiHistory,
        mtuSize: currentState.mtuSize,
        phyLayer: currentState.phyLayer,
        connectionInterval: currentState.connectionInterval,
        latency: currentState.latency,
        connectionSteps: currentState.connectionSteps,
        isAutoReconnectEnabled: !currentState.isAutoReconnectEnabled,
      );
    }
  }

  // Method to update RSSI value
  void updateRssi(double newValue, List<double> newHistory) {
    final currentState = state;
    if (currentState is ConnectionUiStateData) {
      state = ConnectionUiStateData(
        deviceName: currentState.deviceName,
        deviceId: currentState.deviceId,
        rssiValue: newValue,
        rssiHistory: newHistory,
        mtuSize: currentState.mtuSize,
        phyLayer: currentState.phyLayer,
        connectionInterval: currentState.connectionInterval,
        latency: currentState.latency,
        connectionSteps: currentState.connectionSteps,
        isAutoReconnectEnabled: currentState.isAutoReconnectEnabled,
      );
    }
  }

  // Method to update connection steps
  void updateConnectionSteps(List<ConnectionStep> newSteps) {
    final currentState = state;
    if (currentState is ConnectionUiStateData) {
      state = ConnectionUiStateData(
        deviceName: currentState.deviceName,
        deviceId: currentState.deviceId,
        rssiValue: currentState.rssiValue,
        rssiHistory: currentState.rssiHistory,
        mtuSize: currentState.mtuSize,
        phyLayer: currentState.phyLayer,
        connectionInterval: currentState.connectionInterval,
        latency: currentState.latency,
        connectionSteps: newSteps,
        isAutoReconnectEnabled: currentState.isAutoReconnectEnabled,
      );
    }
  }
}