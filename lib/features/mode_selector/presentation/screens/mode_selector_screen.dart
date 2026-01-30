import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/utils/app_spacing.dart';
import '../widgets/hero_section.dart';
import '../widgets/mode_card.dart';
import '../providers/mode_selector_provider.dart';
import '../models/mode_selector_ui_state.dart';
import '../../domain/entities/mode.dart';

/// Main screen for selecting BLE operation modes.
///
/// Features:
/// - iOS-style app bar with settings icon
/// - Animated hero section with circuit logo
/// - Interactive mode cards with selection states
/// - Loading, error, and empty states
/// - Performance-optimized with Riverpod state management
class ModeSelectorScreen extends ConsumerWidget {
  const ModeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            _ModeSelectorAppBar(),
            
            // Hero Section
            HeroSection(
              tagline: 'Explore. Simulate. Master BLE.',
              subtitle: 'The flagship Bluetooth Low Energy development platform for mobile professionals.',
            ),
            
            // Section Header
            _SectionHeader(),
            
            // Content Area
            Expanded(
              child: _ModeSelectorContent(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom app bar for the mode selector screen.
class _ModeSelectorAppBar extends StatelessWidget {
  const _ModeSelectorAppBar();

  @override
  Widget build(BuildContext context) {
    return AppAppBar(
      title: 'BLE Master Lab',
      trailingActions: const [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: null, // TODO: Implement settings navigation
        ),
      ],
    );
  }
}

/// Section header with "Select Your Experience" text.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: AppSpacing.paddingMd,
      child: Text(
        'SELECT YOUR EXPERIENCE',
        textAlign: TextAlign.center,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
          fontSize: 12,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}

/// Main content area that handles different UI states.
class _ModeSelectorContent extends ConsumerWidget {
  const _ModeSelectorContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(modeSelectorUiStateProvider);
    
    return switch (uiState.status) {
      ModeSelectorStatus.loading => const _LoadingState(),
      ModeSelectorStatus.success => _SuccessState(uiState: uiState),
      ModeSelectorStatus.error => _ErrorState(errorMessage: uiState.errorMessage),
      ModeSelectorStatus.empty => const _EmptyState(),
    };
  }
}

/// Loading state with shimmer effect.
class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
          AppSpacing.verticalGapSm,
          Text('Loading modes...'),
        ],
      ),
    );
  }
}

/// Success state showing the mode cards.
class _SuccessState extends ConsumerWidget {
  final ModeSelectorUiState uiState;

  const _SuccessState({required this.uiState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: AppSpacing.paddingHorizontalMd,
      child: Column(
        children: [
          ...uiState.availableModes.map(
            (mode) => ModeCard(
              key: ValueKey(mode.id),
              mode: mode,
              isSelected: uiState.isModeSelected(mode.id),
              showRecommendedBadge: mode.type == ModeType.beginner,
              onTap: () {
                ref.read(modeSelectorUiStateProvider.notifier).selectMode(mode.id);
                // TODO: Add navigation logic here
              },
            ),
          ),
          AppSpacing.verticalGapXl,
        ],
      ),
    );
  }
}

/// Error state with retry capability.
class _ErrorState extends ConsumerWidget {
  final String? errorMessage;

  const _ErrorState({this.errorMessage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red,
          ),
          AppSpacing.verticalGapMd,
          const Text(
            'Failed to load modes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (errorMessage != null) ...[
            AppSpacing.verticalGapSm,
            Padding(
              padding: AppSpacing.paddingHorizontalMd,
              child: Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
          AppSpacing.verticalGapLg,
          ElevatedButton(
            onPressed: () => ref.read(modeSelectorUiStateProvider.notifier).retry(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

/// Empty state when no modes are available.
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 48,
            color: Colors.grey,
          ),
          AppSpacing.verticalGapMd,
          Text(
            'No modes available',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          AppSpacing.verticalGapSm,
          Text(
            'Check your permissions and try again',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}