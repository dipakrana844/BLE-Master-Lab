import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_card.dart';
import '../providers/analyzer_state_provider.dart';

/// Packet flow timeline visualization showing TX/RX packet sequence
class PacketFlowTimeline extends ConsumerWidget {
  const PacketFlowTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(analyzerStateProvider);
    final notifier = ref.read(analyzerStateProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.swap_vert,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Packet Flow',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: notifier.clearPacketFlow,
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Clear',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          AppCard(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF251630)
                : Colors.white,
            borderColor: Theme.of(context).brightness == Brightness.dark
                ? null
                : Theme.of(context).dividerColor.withOpacity(0.3),
            child: SizedBox(
              height: 320,
              child: SingleChildScrollView(
                child: _PacketTimelineList(packets: state.packetFlow),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PacketTimelineList extends StatelessWidget {
  final List<PacketEntry> packets;

  const _PacketTimelineList({required this.packets});

  @override
  Widget build(BuildContext context) {
    if (packets.isEmpty) {
      return const Center(
        child: Text('No packets captured'),
      );
    }

    return Column(
      children: [
        for (int i = 0; i < packets.length; i++) ...[
          _PacketTimelineItem(
            packet: packets[i],
            isLast: i == packets.length - 1,
          ),
          if (i < packets.length - 1) const SizedBox(height: 24),
        ],
      ],
    );
  }
}

class _PacketTimelineItem extends StatelessWidget {
  final PacketEntry packet;
  final bool isLast;

  const _PacketTimelineItem({
    required this.packet,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final (icon, color, bgColor) = _getPacketStyle(packet);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator column
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            if (!isLast)
              Container(
                width: 1.5,
                height: 32,
                color: isDark ? const Color(0xFF513267) : const Color(0xFFE0E0E0),
              ),
          ],
        ),
        const SizedBox(width: 12),
        // Content column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${packet.direction.name.toUpperCase()}: ${packet.operationType} (${packet.characteristicHandle})',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_formatTime(packet.timestamp)} • ${packet.dataSize}B • ${packet.metadata}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: isDark ? const Color(0xFFB292C9) : theme.disabledColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  (IconData, Color, Color) _getPacketStyle(PacketEntry packet) {
    final baseColor = packet.direction == PacketDirection.tx
        ? const Color(0xFF8311D4)
        : const Color(0xFF00F5D4);

    final bgColor = baseColor.withOpacity(0.2);

    return switch (packet.status) {
      PacketStatus.success => (
          packet.direction == PacketDirection.tx
              ? Icons.arrow_upward
              : Icons.arrow_downward,
          baseColor,
          bgColor
        ),
      PacketStatus.failure || PacketStatus.timeout => (
          Icons.error,
          Colors.red,
          Colors.red.withOpacity(0.2)
        ),
      PacketStatus.pending => (
          Icons.hourglass_empty,
          Colors.orange,
          Colors.orange.withOpacity(0.2)
        ),
    };
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}.${time.millisecond.toString().padLeft(3, '0')}';
  }
}