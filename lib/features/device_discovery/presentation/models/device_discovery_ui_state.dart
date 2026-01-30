import 'package:equatable/equatable.dart';
import '../../domain/entities/device.dart';

/// UI state model for device discovery screen
class DeviceDiscoveryUiState extends Equatable {
  final List<Device> devices;
  final bool isScanning;
  final DeviceFilter activeFilter;
  final String searchQuery;
  final bool isLoading;
  final String? errorMessage;

  const DeviceDiscoveryUiState({
    this.devices = const [],
    this.isScanning = false,
    this.activeFilter = DeviceFilter.all,
    this.searchQuery = '',
    this.isLoading = false,
    this.errorMessage = null,
  });

  /// Filtered devices based on active filter
  List<Device> get filteredDevices {
    List<Device> result = List<Device>.from(devices);

    // Apply filter
    result = switch (activeFilter) {
      DeviceFilter.all => result,
      DeviceFilter.strongSignal => result.where((d) => d.rssi > -70).toList(),
      DeviceFilter.named => result.where((d) => d.name.isNotEmpty).toList(),
      DeviceFilter.uuid => result, // TODO: Implement UUID filtering
    };

    // Apply search query
    if (searchQuery.isNotEmpty) {
      result = result
          .where((d) =>
              d.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              d.macAddress.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    // Sort by signal strength (strongest first) then by name
    result.sort((a, b) {
      if (a.rssi != b.rssi) return b.rssi.compareTo(a.rssi);
      return a.name.compareTo(b.name);
    });

    return result;
  }

  /// Count of devices matching current filter
  int get deviceCount => filteredDevices.length;

  /// Count of connectable devices
  int get connectableDeviceCount =>
      filteredDevices.where((d) => d.isConnectable).length;

  DeviceDiscoveryUiState copyWith({
    List<Device>? devices,
    bool? isScanning,
    DeviceFilter? activeFilter,
    String? searchQuery,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DeviceDiscoveryUiState(
      devices: devices ?? this.devices,
      isScanning: isScanning ?? this.isScanning,
      activeFilter: activeFilter ?? this.activeFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        devices,
        isScanning,
        activeFilter,
        searchQuery,
        isLoading,
        errorMessage,
      ];
}