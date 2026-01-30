import 'package:equatable/equatable.dart';

abstract class ConnectionUiState extends Equatable {
  const ConnectionUiState();

  @override
  List<Object> get props => [];
}

class ConnectionUiStateInitial extends ConnectionUiState {
  const ConnectionUiStateInitial();
}

class ConnectionUiStateLoading extends ConnectionUiState {
  const ConnectionUiStateLoading();
}

class ConnectionUiStateData extends ConnectionUiState {
  final String deviceName;
  final String deviceId;
  final double rssiValue;
  final List<double> rssiHistory;
  final int mtuSize;
  final String phyLayer;
  final double connectionInterval;
  final int latency;
  final List<ConnectionStep> connectionSteps;
  final bool isAutoReconnectEnabled;

  const ConnectionUiStateData({
    required this.deviceName,
    required this.deviceId,
    required this.rssiValue,
    required this.rssiHistory,
    required this.mtuSize,
    required this.phyLayer,
    required this.connectionInterval,
    required this.latency,
    required this.connectionSteps,
    required this.isAutoReconnectEnabled,
  });

  @override
  List<Object> get props => [
    deviceName,
    deviceId,
    rssiValue,
    rssiHistory,
    mtuSize,
    phyLayer,
    connectionInterval,
    latency,
    connectionSteps,
    isAutoReconnectEnabled,
  ];
}

class ConnectionUiStateError extends ConnectionUiState {
  final String message;

  const ConnectionUiStateError(this.message);

  @override
  List<Object> get props => [message];
}

enum ConnectionStepStatus { completed, active, pending }

class ConnectionStep extends Equatable {
  final String title;
  final String subtitle;
  final ConnectionStepStatus status;
  final bool showProgressIndicator;

  const ConnectionStep({
    required this.title,
    required this.subtitle,
    required this.status,
    this.showProgressIndicator = false,
  });

  @override
  List<Object> get props => [title, subtitle, status, showProgressIndicator];
}