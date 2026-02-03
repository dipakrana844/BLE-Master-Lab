import 'package:equatable/equatable.dart';

/// Represents the simulation mode options
enum SimulationMode {
  hardware('Hardware Mode'),
  simulation('Simulation Lab');

  const SimulationMode(this.displayName);
  final String displayName;
}

/// Represents different sensor types in the system
enum SensorType {
  heartRate('Heart Rate', 'BPM'),
  temperature('Ambient Temp', 'Celsius'),
  battery('Internal Battery', '%');

  const SensorType(this.displayName, this.unit);
  final String displayName;
  final String unit;
}

/// Represents sensor data with value and metadata
class SensorData extends Equatable {

  const SensorData({
    required this.type,
    required this.value,
    required this.timestamp,
    this.isActive = true,
  });
  final SensorType type;
  final double value;
  final DateTime timestamp;
  final bool isActive;

  SensorData copyWith({
    SensorType? type,
    double? value,
    DateTime? timestamp,
    bool? isActive,
  }) => SensorData(
      type: type ?? this.type,
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
      isActive: isActive ?? this.isActive,
    );

  @override
  List<Object?> get props => [type, value, timestamp, isActive];
}

/// Configuration parameters for simulation
class SimulationConfig extends Equatable { // milliseconds

  const SimulationConfig({
    this.dataNoise = 0.12,
    this.refreshRateMs = 500,
  });
  final double dataNoise; // 0.0 to 1.0
  final int refreshRateMs;

  SimulationConfig copyWith({
    double? dataNoise,
    int? refreshRateMs,
  }) => SimulationConfig(
      dataNoise: dataNoise ?? this.dataNoise,
      refreshRateMs: refreshRateMs ?? this.refreshRateMs,
    );

  @override
  List<Object?> get props => [dataNoise, refreshRateMs];
}

/// Main state for the simulation hub
class SimulationHubState extends Equatable {

  const SimulationHubState({
    this.mode = SimulationMode.simulation,
    this.sensorData = const {},
    this.config = const SimulationConfig(),
    this.isSimulationRunning = false,
    this.isLoading = false,
    this.errorMessage,
  });
  final SimulationMode mode;
  final Map<SensorType, SensorData> sensorData;
  final SimulationConfig config;
  final bool isSimulationRunning;
  final bool isLoading;
  final String? errorMessage;

  SimulationHubState copyWith({
    SimulationMode? mode,
    Map<SensorType, SensorData>? sensorData,
    SimulationConfig? config,
    bool? isSimulationRunning,
    bool? isLoading,
    String? errorMessage,
  }) => SimulationHubState(
      mode: mode ?? this.mode,
      sensorData: sensorData ?? this.sensorData,
      config: config ?? this.config,
      isSimulationRunning: isSimulationRunning ?? this.isSimulationRunning,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );

  @override
  List<Object?> get props => [
        mode,
        sensorData,
        config,
        isSimulationRunning,
        isLoading,
        errorMessage,
      ];
}