import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Represents a Bluetooth device discovered during scanning
class Device extends Equatable {
  final String id;
  final String name;
  final String macAddress;
  final int rssi;
  final bool isConnectable;
  final DateTime discoveredAt;
  final bool isNewlyDiscovered;

  const Device({
    required this.id,
    required this.name,
    required this.macAddress,
    required this.rssi,
    required this.isConnectable,
    required this.discoveredAt,
    this.isNewlyDiscovered = false,
  });

  /// Signal strength category based on RSSI value
  SignalStrength get signalStrength {
    if (rssi >= -50) return SignalStrength.excellent;
    if (rssi >= -60) return SignalStrength.good;
    if (rssi >= -70) return SignalStrength.fair;
    if (rssi >= -80) return SignalStrength.poor;
    return SignalStrength.veryPoor;
  }

  /// Signal strength as percentage (0-100)
  double get signalPercentage {
    // Map RSSI range (-100 to -30) to percentage
    final normalized = ((rssi + 100) / 70).clamp(0.0, 1.0);
    return normalized * 100;
  }

  Device copyWith({
    String? id,
    String? name,
    String? macAddress,
    int? rssi,
    bool? isConnectable,
    DateTime? discoveredAt,
    bool? isNewlyDiscovered,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      macAddress: macAddress ?? this.macAddress,
      rssi: rssi ?? this.rssi,
      isConnectable: isConnectable ?? this.isConnectable,
      discoveredAt: discoveredAt ?? this.discoveredAt,
      isNewlyDiscovered: isNewlyDiscovered ?? this.isNewlyDiscovered,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        macAddress,
        rssi,
        isConnectable,
        discoveredAt,
        isNewlyDiscovered,
      ];
}

/// Signal strength categories for BLE devices
enum SignalStrength {
  excellent,
  good,
  fair,
  poor,
  veryPoor;

  String get displayName => switch (this) {
        SignalStrength.excellent => 'Excellent',
        SignalStrength.good => 'Good',
        SignalStrength.fair => 'Fair',
        SignalStrength.poor => 'Poor',
        SignalStrength.veryPoor => 'Very Poor',
      };

  Color get color => switch (this) {
        SignalStrength.excellent => const Color(0xFF10B981), // emerald
        SignalStrength.good => const Color(0xFF10B981), // emerald
        SignalStrength.fair => const Color(0xFF3B82F6), // blue
        SignalStrength.poor => const Color(0xFFF59E0B), // amber
        SignalStrength.veryPoor => const Color(0xFFEF4444), // red
      };
}

/// Filter options for device discovery
enum DeviceFilter {
  all,
  strongSignal, // RSSI > -70dBm
  named,
  uuid;

  String get displayName => switch (this) {
        DeviceFilter.all => 'All Devices',
        DeviceFilter.strongSignal => 'RSSI > -70dBm',
        DeviceFilter.named => 'Named',
        DeviceFilter.uuid => 'UUID',
      };
}