import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analyzer_state_provider.g.dart';

/// UI state for Protocol Analyzer screen
///
/// Manages:
/// - Throughput metrics
/// - Chart data
/// - Packet flow state
/// - Error injection toggles
class AnalyzerState {
  final double currentThroughput;
  final double latencyMs;
  final int payloadSizeBytes;
  final List<PacketEntry> packetFlow;
  final Map<String, bool> errorInjections;
  final bool isLoading;
  final String? errorMessage;

  const AnalyzerState({
    this.currentThroughput = 124.5,
    this.latencyMs = 45.0,
    this.payloadSizeBytes = 128,
    this.packetFlow = const [],
    this.errorInjections = const {},
    this.isLoading = false,
    this.errorMessage,
  });
}

/// Represents a single packet entry in the flow timeline
class PacketEntry {
  final String id;
  final PacketDirection direction;
  final String operationType;
  final String characteristicHandle;
  final DateTime timestamp;
  final int dataSize;
  final PacketStatus status;
  final String metadata;

  const PacketEntry({
    required this.id,
    required this.direction,
    required this.operationType,
    required this.characteristicHandle,
    required this.timestamp,
    required this.dataSize,
    required this.status,
    required this.metadata,
  });
}

enum PacketDirection { tx, rx }
enum PacketStatus { success, failure, timeout, pending }

/// Riverpod provider for analyzer UI state
@riverpod
class AnalyzerStateNotifier extends _$AnalyzerStateNotifier {
  @override
  AnalyzerState build() {
    // Initialize with sample data for demo
    return AnalyzerState(
      currentThroughput: 124.5,
      latencyMs: 45.0,
      payloadSizeBytes: 128,
      packetFlow: [
        PacketEntry(
          id: '1',
          direction: PacketDirection.tx,
          operationType: 'Write Request',
          characteristicHandle: '0x0012',
          timestamp: DateTime(2024, 1, 1, 12, 4, 1, 234),
          dataSize: 24,
          status: PacketStatus.success,
          metadata: 'MTU 247',
        ),
        PacketEntry(
          id: '2',
          direction: PacketDirection.rx,
          operationType: 'Write Response',
          characteristicHandle: '0x0012',
          timestamp: DateTime(2024, 1, 1, 12, 4, 1, 256),
          dataSize: 0,
          status: PacketStatus.success,
          metadata: 'SUCCESS',
        ),
        PacketEntry(
          id: '3',
          direction: PacketDirection.tx,
          operationType: 'Notification',
          characteristicHandle: '0x0015',
          timestamp: DateTime(2024, 1, 1, 12, 4, 2, 1),
          dataSize: 118,
          status: PacketStatus.success,
          metadata: 'PUSH',
        ),
        PacketEntry(
          id: '4',
          direction: PacketDirection.rx,
          operationType: 'Read Failure',
          characteristicHandle: '0x002A',
          timestamp: DateTime(2024, 1, 1, 12, 4, 2, 150),
          dataSize: 0,
          status: PacketStatus.timeout,
          metadata: 'TIMEOUT',
        ),
      ],
      errorInjections: {
        'dropPacket': true,
        'crcError': false,
        'phySwitch': false,
        'advancedMode': true,
      },
    );
  }

  /// Toggle an error injection setting
  void toggleErrorInjection(String key) {
    final current = state.errorInjections[key] ?? false;
    state = state.copyWith(
      errorInjections: {
        ...state.errorInjections,
        key: !current,
      },
    );
  }

  /// Clear all packets from the timeline
  void clearPacketFlow() {
    state = state.copyWith(packetFlow: []);
  }

  /// Add a new packet to the flow (simulated)
  void addSimulatedPacket() {
    // In a real implementation, this would come from BLE events
    // This is just for demonstration
  }
}

extension AnalyzerStateX on AnalyzerState {
  AnalyzerState copyWith({
    double? currentThroughput,
    double? latencyMs,
    int? payloadSizeBytes,
    List<PacketEntry>? packetFlow,
    Map<String, bool>? errorInjections,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AnalyzerState(
      currentThroughput: currentThroughput ?? this.currentThroughput,
      latencyMs: latencyMs ?? this.latencyMs,
      payloadSizeBytes: payloadSizeBytes ?? this.payloadSizeBytes,
      packetFlow: packetFlow ?? this.packetFlow,
      errorInjections: errorInjections ?? this.errorInjections,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}