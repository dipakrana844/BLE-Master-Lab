import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/device_discovery_ui_state.dart';
import '../../domain/entities/device.dart';

/// Main provider for device discovery UI state
final deviceDiscoveryUiStateProvider =
    NotifierProvider<DeviceDiscoveryNotifier, DeviceDiscoveryUiState>(
  () {
    return DeviceDiscoveryNotifier();
  },
);

/// State notifier for managing device discovery state
class DeviceDiscoveryNotifier extends Notifier<DeviceDiscoveryUiState> {
  @override
  DeviceDiscoveryUiState build() {
    return const DeviceDiscoveryUiState();
  }

  /// Start scanning for devices
  void startScanning() {
    if (state.isScanning) return;
    
    state = state.copyWith(
      isScanning: true,
      errorMessage: null,
    );
    
    // TODO: Integrate with actual BLE scanning logic
    // This is where you would call the BLE service to start scanning
  }

  /// Stop scanning for devices
  void stopScanning() {
    if (!state.isScanning) return;
    
    state = state.copyWith(isScanning: false);
    
    // TODO: Integrate with actual BLE scanning logic
    // This is where you would call the BLE service to stop scanning
  }

  /// Toggle scanning state
  void toggleScanning() {
    if (state.isScanning) {
      stopScanning();
    } else {
      startScanning();
    }
  }

  /// Update the list of discovered devices
  void updateDevices(List<Device> devices) {
    state = state.copyWith(devices: devices);
  }

  /// Add a new device to the list
  void addDevice(Device device) {
    final existingIndex =
        state.devices.indexWhere((d) => d.id == device.id);
    
    if (existingIndex != -1) {
      // Update existing device
      final updatedDevices = List<Device>.from(state.devices)
        ..[existingIndex] = device.copyWith(isNewlyDiscovered: false);
      state = state.copyWith(devices: updatedDevices);
    } else {
      // Add new device
      final newDevices = List<Device>.from(state.devices)
        ..add(device.copyWith(isNewlyDiscovered: true));
      state = state.copyWith(devices: newDevices);
    }
  }

  /// Remove a device from the list
  void removeDevice(String deviceId) {
    final updatedDevices = state.devices
        .where((device) => device.id != deviceId)
        .toList();
    state = state.copyWith(devices: updatedDevices);
  }

  /// Set active filter
  void setActiveFilter(DeviceFilter filter) {
    state = state.copyWith(activeFilter: filter);
  }

  /// Update search query
  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Set loading state
  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  /// Set error message
  void setError(String? errorMessage) {
    state = state.copyWith(
      errorMessage: errorMessage,
      isLoading: false,
      isScanning: false,
    );
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Reset state to initial
  void reset() {
    state = const DeviceDiscoveryUiState();
  }
}