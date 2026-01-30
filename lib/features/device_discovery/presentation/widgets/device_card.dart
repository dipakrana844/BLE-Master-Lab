import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/device_discovery_ui_state.dart';
import '../providers/device_discovery_provider.dart';
import '../../domain/entities/device.dart';
import 'signal_strength_indicator.dart';

/// A reusable card widget for displaying device information
class DeviceCard extends ConsumerWidget {
  final Device device;
  final VoidCallback? onConnectPressed;

  const DeviceCard({
    super.key,
    required this.device,
    this.onConnectPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Add subtle animation for newly discovered devices
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        border: device.isNewlyDiscovered
            ? Border.all(
                color: theme.colorScheme.primary.withOpacity(0.3),
                width: 2,
              )
            : null,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Card(
            color: _getCardColor(theme, isDark),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: device.isNewlyDiscovered
                  ? BorderSide(
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      width: 2,
                    )
                  : BorderSide.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, ref),
                  const SizedBox(height: 12),
                  _buildDeviceInfo(context),
                  const SizedBox(height: 12),
                  _buildSignalProgress(context),
                  const SizedBox(height: 12),
                  _buildActionRow(context, ref),
                ],
              ),
            ),
          ),
          // New device indicator
          if (device.isNewlyDiscovered) _buildNewDeviceIndicator(context),
        ],
      ),
    );
  }

  /// Build the header section with status badge and signal indicator
  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status badge
              _buildStatusBadge(context),
              const SizedBox(height: 4),
              // Device name
              Text(
                device.name.isNotEmpty ? device.name : 'Unnamed Device',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: device.name.isNotEmpty
                          ? null
                          : Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                    ),
              ),
              // MAC address
              Text(
                device.macAddress,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                    ),
              ),
            ],
          ),
        ),
        // Signal strength indicator
        SignalStrengthIndicator(
          device: device,
          style: SignalStrengthIndicatorStyle.compact,
        ),
      ],
    );
  }

  /// Build status badge (Connectable/Non-Connectable)
  Widget _buildStatusBadge(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: device.isConnectable
            ? const Color(0xFF10B981).withOpacity(isDark ? 0.2 : 0.1)
            : const Color(0xFF64748B).withOpacity(isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (device.isConnectable) ...[
            Icon(
              Icons.bluetooth_connected,
              size: 14,
              color: const Color(0xFF10B981),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            device.isConnectable ? 'Connectable' : 'Non-Connectable',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: device.isConnectable
                  ? const Color(0xFF10B981)
                  : const Color(0xFF64748B),
              letterSpacing: 1.2,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  /// Build device information section
  Widget _buildDeviceInfo(BuildContext context) {
    return const SizedBox.shrink(); // Reserved for future expansion
  }

  /// Build signal strength progress bar
  Widget _buildSignalProgress(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9999),
      child: LinearProgressIndicator(
        value: device.signalPercentage / 100,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E293B) // slate-800
            : const Color(0xFFF1F5F9), // slate-100
        valueColor: AlwaysStoppedAnimation<Color>(device.signalStrength.color),
        minHeight: 6,
      ),
    );
  }

  /// Build action buttons row
  Widget _buildActionRow(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: _buildConnectButton(context, ref),
        ),
      ],
    );
  }

  /// Build connect button
  Widget _buildConnectButton(BuildContext context, WidgetRef ref) {
    final isScanning = ref.watch(deviceDiscoveryUiStateProvider.select((state) => state.isScanning));
    final theme = Theme.of(context);
    
    return ElevatedButton(
      onPressed: device.isConnectable && !isScanning ? onConnectPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: device.isConnectable 
            ? theme.colorScheme.primary 
            : (theme.brightness == Brightness.dark 
                ? const Color(0xFF1E293B) 
                : const Color(0xFFF1F5F9)),
        foregroundColor: device.isConnectable 
            ? theme.colorScheme.onPrimary 
            : (theme.brightness == Brightness.dark 
                ? const Color(0xFF94A3B8) 
                : const Color(0xFF94A3B8)),
        minimumSize: const Size(0, 36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            device.isConnectable ? Icons.link : Icons.link_off,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            'Connect',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// Build new device indicator with animation
  Widget _buildNewDeviceIndicator(BuildContext context) {
    return Positioned(
      top: -6,
      right: -6,
      child: Container(
        width: 12,
        height: 12,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF1132d4), // primary color from HTML
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Pulsing background
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1132d4),
                ),
              ),
            ),
            // Solid dot
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1132d4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get appropriate card background color
  Color _getCardColor(ThemeData theme, bool isDark) {
    if (device.isNewlyDiscovered) {
      return isDark
          ? const Color(0xFF191e33) // from HTML design
          : Colors.white;
    }
    
    return isDark
        ? const Color(0xFF191e33)
        : Colors.white;
  }
}