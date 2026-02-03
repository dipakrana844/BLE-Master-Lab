import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/simulation_config.dart';

/// Main provider for simulation hub state management
final simulationHubProvider = StateNotifierProvider<SimulationHubNotifier, SimulationHubState>(
  (ref) => SimulationHubNotifier(),
);

/// Provider for simulation mode selection
final simulationModeProvider = Provider<SimulationMode>((ref) {
  return ref.watch(simulationHubProvider).mode;
});

/// Provider for sensor data
final sensorDataProvider = Provider<Map<SensorType, SensorData>>((ref) {
  return ref.watch(simulationHubProvider).sensorData;
});

/// Provider for simulation configuration
final simulationConfigProvider = Provider<SimulationConfig>((ref) {
  return ref.watch(simulationHubProvider).config;
});

/// Provider for simulation running state
final isSimulationRunningProvider = Provider<bool>((ref) {
  return ref.watch(simulationHubProvider).isSimulationRunning;
});

/// State notifier for managing simulation hub state
class SimulationHubNotifier extends StateNotifier<SimulationHubState> {
  SimulationHubNotifier() : super(const SimulationHubState()) {
    // Initialize with default sensor data
    _initializeSensorData();
  }

  /// Initialize default sensor data
  void _initializeSensorData() {
    final now = DateTime.now();
    state = state.copyWith(
      sensorData: {
        SensorType.heartRate: SensorData(
          type: SensorType.heartRate,
          value: 72.0,
          timestamp: now,
        ),
        SensorType.temperature: SensorData(
          type: SensorType.temperature,
          value: 24.5,
          timestamp: now,
        ),
        SensorType.battery: SensorData(
          type: SensorType.battery,
          value: 85.0,
          timestamp: now,
        ),
      },
    );
  }

  /// Update simulation mode
  void updateMode(SimulationMode mode) {
    state = state.copyWith(mode: mode);
  }

  /// Update sensor data value
  void updateSensorData(SensorType type, double value) {
    final currentData = state.sensorData[type];
    if (currentData != null) {
      state = state.copyWith(
        sensorData: {
          ...state.sensorData,
          type: currentData.copyWith(
            value: value,
            timestamp: DateTime.now(),
          ),
        },
      );
    }
  }

  /// Update simulation configuration
  void updateConfig(SimulationConfig config) {
    state = state.copyWith(config: config);
  }

  /// Update data noise configuration
  void updateDataNoise(double noise) {
    state = state.copyWith(
      config: state.config.copyWith(dataNoise: noise),
    );
  }

  /// Update refresh rate configuration
  void updateRefreshRate(int refreshRateMs) {
    state = state.copyWith(
      config: state.config.copyWith(refreshRateMs: refreshRateMs),
    );
  }

  /// Toggle simulation running state
  void toggleSimulation() {
    state = state.copyWith(isSimulationRunning: !state.isSimulationRunning);
  }

  /// Start simulation
  void startSimulation() {
    state = state.copyWith(isSimulationRunning: true);
    // TODO: Implement actual simulation logic
  }

  /// Stop simulation
  void stopSimulation() {
    state = state.copyWith(isSimulationRunning: false);
    // TODO: Stop simulation logic
  }

  /// Reset simulation to default state
  void resetSimulation() {
    state = const SimulationHubState();
    _initializeSensorData();
    // TODO: Reset simulation logic
  }

  /// Simulate sensor data updates (for demo purposes)
  void simulateSensorUpdates() {
    if (!state.isSimulationRunning) return;

    final now = DateTime.now();
    final noise = state.config.dataNoise;
    
    // Update heart rate with some variation
    final currentHeartRate = state.sensorData[SensorType.heartRate]?.value ?? 72.0;
    final newHeartRate = currentHeartRate + (noise * 10 * (0.5 - (now.millisecondsSinceEpoch % 1000) / 1000));
    
    // Update temperature with some variation
    final currentTemp = state.sensorData[SensorType.temperature]?.value ?? 24.5;
    final newTemp = currentTemp + (noise * 2 * (0.5 - (now.millisecondsSinceEpoch % 1000) / 1000));
    
    // Update battery (slowly decreasing)
    final currentBattery = state.sensorData[SensorType.battery]?.value ?? 85.0;
    final newBattery = currentBattery - (0.001 * (state.config.refreshRateMs / 1000));

    state = state.copyWith(
      sensorData: {
        ...state.sensorData,
        SensorType.heartRate: SensorData(
          type: SensorType.heartRate,
          value: newHeartRate.clamp(60.0, 120.0),
          timestamp: now,
        ),
        SensorType.temperature: SensorData(
          type: SensorType.temperature,
          value: newTemp.clamp(20.0, 30.0),
          timestamp: now,
        ),
        SensorType.battery: SensorData(
          type: SensorType.battery,
          value: newBattery.clamp(0.0, 100.0),
          timestamp: now,
        ),
      },
    );
  }
}