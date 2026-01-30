import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/connection_ui_state.dart';
import '../providers/connection_provider.dart';
import '../widgets/parameter_card.dart';
import '../widgets/rssi_chart_widget.dart';
import '../widgets/signal_strength_badge.dart';
import '../widgets/toggle_switch_widget.dart';
import '../widgets/connection_state_widget.dart';
import '../../../../core/widgets/app_app_bar.dart';

class ConnectionDashboardScreen extends ConsumerWidget {
  const ConnectionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(connectionNotifierProvider);

    return Scaffold(
      appBar: _buildTopAppBar(state, context),
      body: _buildBodyBasedOnState(state, context, ref),
      bottomNavigationBar: _buildBottomControls(data: state is ConnectionUiStateData ? state : null, ref: ref, context: context),
    );
  }

  PreferredSizeWidget _buildTopAppBar(ConnectionUiState state, BuildContext context) {
    if (state is ConnectionUiStateData) {
      return AppAppBar(
        title: state.deviceName,
        leading: Container(
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.bluetooth_connected,
            color: Theme.of(context).primaryColor,
          ),
        ),
        trailingActions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              // TODO: Show device info
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Open settings
            },
          ),
        ],
      );
    }
    
    return const AppAppBar(
      title: 'Connecting...',
      leading: Icon(Icons.bluetooth_disabled),
    );
  }

  Widget _buildBodyBasedOnState(ConnectionUiState state, BuildContext context, WidgetRef ref) {
    if (state is ConnectionUiStateData) {
      return _buildBody(state, context, ref);
    } else if (state is ConnectionUiStateInitial || state is ConnectionUiStateLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ConnectionUiStateError) {
      return Center(child: Text('Error: ${state.message}'));
    }
    
    return const Center(child: Text('Unknown state')); 
  }

  Widget _buildBody(ConnectionUiStateData data, BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Live RSSI Chart Section
          _buildRssiSection(data, context),
          
          const SizedBox(height: 24),
          
          // Link Parameters Header
          Text(
            'Link Parameters',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).disabledColor,
              letterSpacing: 1.5,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Link Parameters Grid
          _buildLinkParametersGrid(data, context),
          
          const SizedBox(height: 32),
          
          // Connection State Machine Header
          Text(
            'Connection State Machine',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).disabledColor,
              letterSpacing: 1.5,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Connection States
          _buildConnectionStates(data, context, ref),
          
          const SizedBox(height: 80), // Extra space for bottom controls
        ],
      ),
    );
  }

  Widget _buildRssiSection(ConnectionUiStateData data, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Live RSSI (dBm)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).disabledColor,
                      letterSpacing: 1.5,
                      textBaseline: TextBaseline.alphabetic,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      text: '${data.rssiValue.toStringAsFixed(0)} ',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: 'dBm',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SignalStrengthBadge(
                strength: _getSignalStrengthFromRssi(data.rssiValue),
              ),
            ],
          ),
          const SizedBox(height: 16),
          RssiChartWidget(
            currentValue: data.rssiValue,
            history: data.rssiHistory,
          ),
          const SizedBox(height: 12),
          _buildTimeLabels(context),
        ],
      ),
    );
  }

  Widget _buildTimeLabels(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '10s',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).disabledColor,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          '8s',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).disabledColor,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          '6s',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).disabledColor,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          '4s',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).disabledColor,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          '2s',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).disabledColor,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          'Now',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLinkParametersGrid(ConnectionUiStateData data, BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling for grid inside scrollable
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        ParameterCard(
          label: 'MTU Size',
          value: data.mtuSize.toString(),
          unit: 'bytes',
        ),
        ParameterCard(
          label: 'PHY Layer',
          value: data.phyLayer.split(' ')[0], // Just the numeric part
          unit: data.phyLayer.contains(' ') ? data.phyLayer.split(' ')[1] : '', // LE part
        ),
        ParameterCard(
          label: 'Interval',
          value: data.connectionInterval.toStringAsFixed(0),
          unit: 'ms',
        ),
        ParameterCard(
          label: 'Latency',
          value: data.latency.toString(),
          unit: 'ms',
        ),
      ],
    );
  }

  Widget _buildConnectionStates(ConnectionUiStateData data, BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        for (int i = 0; i < data.connectionSteps.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ConnectionStateWidget(
              title: data.connectionSteps[i].title,
              subtitle: data.connectionSteps[i].subtitle,
              state: _mapConnectionStepStatus(data.connectionSteps[i].status),
              showProgressIndicator: data.connectionSteps[i].showProgressIndicator,
            ),
          ),
      ],
    );
  }

  Widget _buildBottomControls({ConnectionUiStateData? data, required WidgetRef ref, BuildContext? context}) {
    if (data == null || context == null) {
      return Container(
        height: 120,
        padding: const EdgeInsets.all(16),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ToggleSwitchWidget(
            value: data.isAutoReconnectEnabled,
            label: 'Auto-reconnect',
            description: 'Restore session on signal loss',
            onChanged: (value) {
              ref.read(connectionNotifierProvider.notifier).toggleAutoReconnect();
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Export logs
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.analytics),
                  label: const Text('Export Logs'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Disconnect from device
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: BorderSide(
                      color: Colors.red.withOpacity(0.2),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.link_off),
                  label: const Text('Disconnect'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SignalStrength _getSignalStrengthFromRssi(double rssi) {
    if (rssi >= -50) {
      return SignalStrength.excellent;
    } else if (rssi >= -60) {
      return SignalStrength.good;
    } else if (rssi >= -70) {
      return SignalStrength.fair;
    } else {
      return SignalStrength.poor;
    }
  }

  ConnectionStateType _mapConnectionStepStatus(ConnectionStepStatus status) {
    switch (status) {
      case ConnectionStepStatus.completed:
        return ConnectionStateType.completed;
      case ConnectionStepStatus.active:
        return ConnectionStateType.active;
      case ConnectionStepStatus.pending:
        return ConnectionStateType.pending;
    }
  }
}