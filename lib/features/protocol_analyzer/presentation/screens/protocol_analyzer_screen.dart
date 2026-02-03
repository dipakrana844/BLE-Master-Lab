import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_status_badge.dart';
import '../widgets/analyzer_hero_metric.dart';
import '../widgets/dual_charts_section.dart';
import '../widgets/packet_flow_timeline.dart';
import '../widgets/error_injection_panel.dart';
import '../providers/analyzer_state_provider.dart';

/// Protocol Analyzer Screen - BLE packet analysis and monitoring
///
/// Features:
/// - Real-time throughput metrics
/// - Dual chart visualization (latency, payload size)
/// - Packet flow timeline viewer
/// - Error injection controls
/// - iOS-style bottom navigation
class ProtocolAnalyzerScreen extends ConsumerWidget {
  const ProtocolAnalyzerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch state for rebuilds when data changes
    ref.watch(analyzerStateProvider);

    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: _TopNavigationBar(),
        ),
        body: const _AnalyzerBody(),
        bottomNavigationBar: const _BottomNavigation(),
      ),
    );
  }
}

class _TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const _TopNavigationBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1A1022).withOpacity(0.8)
            : const Color(0xFFF7F6F8).withOpacity(0.8),
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? const Color(0xFF392348)
                : theme.dividerColor.withOpacity(0.5),
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: theme.colorScheme.primary,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Protocol Analyzer',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withOpacity(0.5),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'LIVE',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings_outlined,
                      color: isDark
                          ? const Color(0xFFB292C9)
                          : theme.disabledColor,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 24);
}

class _AnalyzerBody extends StatelessWidget {
  const _AnalyzerBody();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 80), // Space for bottom nav
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16),
          AnalyzerHeroMetric(),
          SizedBox(height: 8),
          DualChartsSection(),
          SizedBox(height: 16),
          PacketFlowTimeline(),
          SizedBox(height: 16),
          ErrorInjectionPanel(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1A1022).withOpacity(0.8)
            : Colors.white.withOpacity(0.8),
        border: Border(
          top: BorderSide(
            color: isDark
                ? const Color(0xFF392348)
                : theme.dividerColor.withOpacity(0.5),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Icons.analytics,
                    label: 'Analyze',
                    isActive: true,
                  ),
                  _NavItem(
                    icon: Icons.terminal,
                    label: 'Console',
                    isActive: false,
                  ),
                  _NavItem(
                    icon: Icons.bluetooth,
                    label: 'Devices',
                    isActive: false,
                  ),
                  _NavItem(
                    icon: Icons.history,
                    label: 'History',
                    isActive: false,
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = isActive
        ? theme.colorScheme.primary
        : isDark
            ? const Color(0xFFB292C9)
            : theme.disabledColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
      ],
    );
  }
}