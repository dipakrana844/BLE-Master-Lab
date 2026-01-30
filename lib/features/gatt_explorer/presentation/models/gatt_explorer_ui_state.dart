import 'package:equatable/equatable.dart';
import '../../domain/entities/gatt_service.dart';

/// UI state for the GATT Explorer screen
class GattExplorerUiState extends Equatable {
  final String deviceName;
  final String latency;
  final bool isConnected;
  final List<GattService> services;
  final bool isLoading;
  final String? errorMessage;
  final GattCharacteristic? selectedCharacteristic;
  final bool isWritePanelVisible;

  const GattExplorerUiState({
    this.deviceName = 'Polar H10',
    this.latency = '12ms',
    this.isConnected = true,
    this.services = const [],
    this.isLoading = false,
    this.errorMessage,
    this.selectedCharacteristic,
    this.isWritePanelVisible = false,
  });

  GattExplorerUiState copyWith({
    String? deviceName,
    String? latency,
    bool? isConnected,
    List<GattService>? services,
    bool? isLoading,
    String? errorMessage,
    GattCharacteristic? selectedCharacteristic,
    bool? isWritePanelVisible,
  }) {
    return GattExplorerUiState(
      deviceName: deviceName ?? this.deviceName,
      latency: latency ?? this.latency,
      isConnected: isConnected ?? this.isConnected,
      services: services ?? this.services,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCharacteristic: selectedCharacteristic ?? this.selectedCharacteristic,
      isWritePanelVisible: isWritePanelVisible ?? this.isWritePanelVisible,
    );
  }

  @override
  List<Object?> get props => [
    deviceName,
    latency,
    isConnected,
    services,
    isLoading,
    errorMessage,
    selectedCharacteristic,
    isWritePanelVisible,
  ];
}