import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/gatt_explorer_ui_state.dart';
import '../../domain/entities/gatt_service.dart';

/// Main provider for GATT Explorer UI state
final gattExplorerProvider = StateProvider((ref) {
  return const GattExplorerUiState(
    services: [
      GattService(
        id: 'heart_rate',
        name: 'Heart Rate Service',
        uuid: '0x180D',
        icon: 'favorite',
        iconColor: 'rose',
        characteristics: [
          GattCharacteristic(
            id: 'heart_rate_measurement',
            name: 'Heart Rate Measurement',
            uuid: '2A37-0000-1000-8000-00805F9B34FB',
            properties: [CharacteristicProperty.notify, CharacteristicProperty.indicate],
          ),
          GattCharacteristic(
            id: 'body_sensor_location',
            name: 'Body Sensor Location',
            uuid: '2A38-0000-1000-8000-00805F9B34FB',
            properties: [CharacteristicProperty.read],
          ),
        ],
      ),
      GattService(
        id: 'device_info',
        name: 'Device Information',
        uuid: '0x180A',
        icon: 'info',
        iconColor: 'blue',
        characteristics: [],
      ),
      GattService(
        id: 'custom_command',
        name: 'Custom Command Service',
        uuid: 'FB310001-2234-4567-8901-ABCDE1234567',
        icon: 'settings_remote',
        iconColor: 'primary',
        isExpanded: true,
        characteristics: [
          GattCharacteristic(
            id: 'command_input',
            name: 'Command Input',
            uuid: 'FB310002-2234-4567-8901-ABCDE1234567',
            properties: [CharacteristicProperty.read, CharacteristicProperty.write],
            isActive: true,
            activeStatus: 'ACTIVE',
          ),
        ],
      ),
    ],
  );
});

/// Provider for toggling service expansion
final toggleServiceProvider = Provider<Function(String)>((ref) {
  return (String serviceId) {
    ref.read(gattExplorerProvider.notifier).update((state) {
      return state.copyWith(
        services: [
          for (final service in state.services)
            if (service.id == serviceId)
              service.copyWith(isExpanded: !service.isExpanded)
            else
              service,
        ],
      );
    });
  };
});

/// Provider for selecting characteristic
final selectCharacteristicProvider = Provider<Function(GattCharacteristic)>((ref) {
  return (GattCharacteristic characteristic) {
    ref.read(gattExplorerProvider.notifier).update((state) {
      return state.copyWith(
        selectedCharacteristic: characteristic,
        isWritePanelVisible: true,
      );
    });
  };
});

/// Provider for hiding write panel
final hideWritePanelProvider = Provider<Function()>((ref) {
  return () {
    ref.read(gattExplorerProvider.notifier).update((state) {
      return state.copyWith(isWritePanelVisible: false);
    });
  };
});

/// Provider for toggling connection
final toggleConnectionProvider = Provider<Function()>((ref) {
  return () {
    ref.read(gattExplorerProvider.notifier).update((state) {
      return state.copyWith(isConnected: !state.isConnected);
    });
  };
});