import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/device_discovery_provider.dart';
import '../widgets/device_card.dart';
import '../widgets/filter_chips.dart';
import '../../domain/entities/device.dart';
import '../models/device_discovery_ui_state.dart';

/// Main screen for device discovery functionality
class DeviceDiscoveryScreen extends ConsumerWidget {
  const DeviceDiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(deviceDiscoveryUiStateProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF101322) : const Color(0xFFF6F6F8),
      appBar: _buildAppBar(context, ref, uiState),
      body: SafeArea(
        child: Column(
          children: [
            // Filter chips section
            const SizedBox(height: 16),
            const FilterChips(),
            const SizedBox(height: 16),
            
            // Search field
            const SearchField(),
            const SizedBox(height: 16),
            
            // Device list
            Expanded(
              child: _buildDeviceList(context, ref, uiState),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildScanFab(context, ref, uiState),
      bottomNavigationBar: _buildBottomNavigation(context, ref),
    );
  }

  /// Build custom app bar
  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    WidgetRef ref,
    DeviceDiscoveryUiState uiState,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF101322).withOpacity(0.8)
              : const Color(0xFFF6F6F8).withOpacity(0.8),
          // backdropFilter: uiState.isScanning
          //     ? BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10))
          //     : null,
          border: Border(
            bottom: BorderSide(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Discovery',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${uiState.deviceCount} Devices Found',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              // Scan button
              _buildScanButton(context, ref, uiState),
            ],
          ),
        ),
      ),
    );
  }

  /// Build scan button in app bar
  Widget _buildScanButton(
    BuildContext context,
    WidgetRef ref,
    DeviceDiscoveryUiState uiState,
  ) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: () => ref.read(deviceDiscoveryUiStateProvider.notifier).toggleScanning(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: uiState.isScanning
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedRotation(
              turns: uiState.isScanning ? 1 : 0,
              duration: const Duration(seconds: 1),
              curve: Curves.linear,
              child: Icon(
                Icons.radar,
                size: 18,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              uiState.isScanning ? 'SCANNING' : 'SCAN',
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build device list
  Widget _buildDeviceList(
    BuildContext context,
    WidgetRef ref,
    DeviceDiscoveryUiState uiState,
  ) {
    if (uiState.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Discovering devices...'),
          ],
        ),
      );
    }

    if (uiState.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error occurred',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              uiState.errorMessage!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(deviceDiscoveryUiStateProvider.notifier).clearError(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (uiState.filteredDevices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              uiState.isScanning ? Icons.bluetooth_searching : Icons.bluetooth_disabled,
              size: 48,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              uiState.isScanning
                  ? 'Scanning for devices...'
                  : 'No devices found',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
            ),
            if (!uiState.isScanning) ...[
              const SizedBox(height: 8),
              Text(
                'Start scanning to discover nearby Bluetooth devices',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: uiState.filteredDevices.length,
      itemBuilder: (context, index) {
        final device = uiState.filteredDevices[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DeviceCard(
            device: device,
            onConnectPressed: () => _onDeviceConnect(context, device),
          ),
        );
      },
    );
  }

  /// Build floating action button for advanced settings
  Widget _buildScanFab(
    BuildContext context,
    WidgetRef ref,
    DeviceDiscoveryUiState uiState,
  ) {
    return FloatingActionButton(
      onPressed: () {
        // TODO: Open advanced scanning settings
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Advanced settings coming soon')),
        );
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(Icons.tune, size: 28),
    );
  }

  /// Build bottom navigation bar
  Widget _buildBottomNavigation(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF101322).withOpacity(0.9)
            : const Color(0xFFF6F6F8).withOpacity(0.9),
        // backdropFilter: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20)),
        border: Border(
          top: BorderSide(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, 'Discovery', Icons.explore, true),
            _buildNavItem(context, 'Logs', Icons.history, false),
            _buildNavItem(context, 'Favorites', Icons.star, false),
            _buildNavItem(context, 'Settings', Icons.settings, false),
          ],
        ),
      ),
    );
  }

  /// Build individual navigation item
  Widget _buildNavItem(
    BuildContext context,
    String label,
    IconData icon,
    bool isSelected,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to selected screen
        if (!isSelected) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Navigate to $label')),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected
                ? theme.colorScheme.primary
                : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF94A3B8)),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? theme.colorScheme.primary
                  : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF94A3B8)),
            ),
          ),
        ],
      ),
    );
  }

  /// Handle device connect action
  void _onDeviceConnect(BuildContext context, Device device) {
    // TODO: Implement actual connection logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connecting to ${device.name}...'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
    
    // Simulate connection process
    Future.delayed(const Duration(seconds: 2), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connected to ${device.name}'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }
}