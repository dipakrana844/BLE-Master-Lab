import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/simulation_hub_provider.dart';
import '../widgets/mode_toggle_widget.dart';
import '../widgets/sensor_data_card.dart';
import '../widgets/simulation_control_card.dart';
import '../widgets/fixed_bottom_panel.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../domain/entities/simulation_config.dart';

/// Main screen for the Simulation & Data Hub.
///
/// Features:
/// - Mode toggle between Hardware and Simulation modes
/// - Live sensor data visualization
/// - Simulation configuration controls
/// - Fixed action panel for simulation control
/// - Theme-aware responsive design
/// - Performance-optimized with Riverpod state management
class SimulationHubScreen extends ConsumerStatefulWidget {
  const SimulationHubScreen({super.key});

  @override
  ConsumerState<SimulationHubScreen> createState() => _SimulationHubScreenState();
}

class _SimulationHubScreenState extends ConsumerState<SimulationHubScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();

    // Start simulation update timer
    _startSimulationTimer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startSimulationTimer() {
    // Update sensor data every 500ms when simulation is running
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        ref.read(simulationHubProvider.notifier).simulateSensorUpdates();
        _startSimulationTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: const _SimulationHubAppBar(),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: const _SimulationHubContent(),
      ),
      bottomSheet: const FixedBottomPanel(),
      // Add padding to account for fixed bottom panel
      resizeToAvoidBottomInset: false,
    );
}

/// Custom app bar for the simulation hub
class _SimulationHubAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _SimulationHubAppBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return AppBar(
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          Icons.bluetooth_searching,
          color: theme.colorScheme.primary,
        ),
      ),
      title: const Text(
        'Simulation & Data Hub',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Navigate to settings
          },
          icon: const Icon(Icons.settings),
        ),
      ],
      backgroundColor: isDark
          ? const Color(0xFF101322).withOpacity(0.8)
          : Colors.white.withOpacity(0.8),
      foregroundColor: theme.appBarTheme.foregroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.grey.withOpacity(0.2),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Main content area with all simulation components
class _SimulationHubContent extends ConsumerWidget {
  const _SimulationHubContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) => const SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 100), // Space for bottom panel
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mode toggle
          ModeToggleWidget(),
          AppSpacing.verticalGapMd,
          
          // Live sensor data section
          _LiveSensorDataSection(),
          AppSpacing.verticalGapLg,
          
          // Simulation controls section
          _SimulationControlsSection(),
        ],
      ),
    );
}

/// Live sensor data section with cards
class _LiveSensorDataSection extends StatelessWidget {
  const _LiveSensorDataSection();

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          title: 'Live Sensor Data',
          status: _SectionStatus.active,
        ),
        AppSpacing.verticalGapSm,
        // Grid of sensor cards
        Padding(
          padding: AppSpacing.paddingHorizontalMd,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Responsive grid - 2 columns on wide screens, 1 on narrow
              final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
              final spacing = AppSpacing.md;
              
              return GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  SensorDataCard(sensorType: SensorType.heartRate),
                  SensorDataCard(sensorType: SensorType.temperature),
                  SensorDataCard(sensorType: SensorType.battery),
                ],
              );
            },
          ),
        ),
      ],
    );
}

/// Simulation controls section
class _SimulationControlsSection extends StatelessWidget {
  const _SimulationControlsSection();

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.paddingHorizontalMd,
          child: const Text(
            'Simulation Config',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        AppSpacing.verticalGapMd,
        Padding(
          padding: AppSpacing.paddingHorizontalMd,
          child: Column(
            children: const [
              SimulationControlCard(
                controlType: SimulationControlType.dataNoise,
              ),
              AppSpacing.verticalGapMd,
              SimulationControlCard(
                controlType: SimulationControlType.refreshRate,
              ),
            ],
          ),
        ),
      ],
    );
}

/// Section header with title and status badge
class _SectionHeader extends StatelessWidget {
  final String title;
  final _SectionStatus status;

  const _SectionHeader({
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: AppSpacing.paddingHorizontalMd,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          _StatusBadge(status: status),
        ],
      ),
    );
}

/// Status badge widget
class _StatusBadge extends StatelessWidget {
  final _SectionStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (text, color) = switch (status) {
      _SectionStatus.active => ('Active', const Color(0xFF10B981)),
      _SectionStatus.inactive => ('Inactive', const Color(0xFF9CA3AF)),
      _SectionStatus.error => ('Error', const Color(0xFFEF4444)),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// Section status enum
enum _SectionStatus {
  active,
  inactive,
  error,
}