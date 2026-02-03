import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_card.dart';
import '../providers/analyzer_state_provider.dart';

/// Error injection control panel with toggle switches
class ErrorInjectionPanel extends ConsumerWidget {
  const ErrorInjectionPanel({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Row(
              children: [
                Icon(
                  Icons.biotech,
                  color: Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Error Injection',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const _ToggleGrid(),
        ],
      ),
    );
  }
}

class _ToggleGrid extends ConsumerWidget {
  const _ToggleGrid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(analyzerStateProvider);
    final notifier = ref.read(analyzerStateProvider.notifier);

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _ToggleItem(
          label: 'Drop Packet',
          isEnabled: state.errorInjections['dropPacket'] ?? false,
          onChanged: () => notifier.toggleErrorInjection('dropPacket'),
          color: Theme.of(context).colorScheme.primary,
        ),
        _ToggleItem(
          label: 'CRC Error',
          isEnabled: state.errorInjections['crcError'] ?? false,
          onChanged: () => notifier.toggleErrorInjection('crcError'),
          color: Theme.of(context).disabledColor,
        ),
        _ToggleItem(
          label: 'PHY Switch',
          isEnabled: state.errorInjections['phySwitch'] ?? false,
          onChanged: () => notifier.toggleErrorInjection('phySwitch'),
          color: Theme.of(context).disabledColor,
        ),
        _ToggleItem(
          label: 'Advanced Mode',
          isEnabled: state.errorInjections['advancedMode'] ?? false,
          onChanged: () => notifier.toggleErrorInjection('advancedMode'),
          color: const Color(0xFF00F5D4),
          isAdvanced: true,
        ),
      ],
    );
  }
}

class _ToggleItem extends StatefulWidget {
  final String label;
  final bool isEnabled;
  final VoidCallback onChanged;
  final Color color;
  final bool isAdvanced;

  const _ToggleItem({
    required this.label,
    required this.isEnabled,
    required this.onChanged,
    required this.color,
    this.isAdvanced = false,
  });

  @override
  State<_ToggleItem> createState() => _ToggleItemState();
}

class _ToggleItemState extends State<_ToggleItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      onTap: widget.onChanged,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AppCard(
          padding: const EdgeInsets.all(16),
          color: isDark ? const Color(0xFF392348) : Colors.white,
          borderColor: isDark
              ? const Color(0xFF513267)
              : theme.dividerColor.withOpacity(0.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: widget.isAdvanced
                        ? const Color(0xFF00F5D4)
                        : theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 20,
                decoration: BoxDecoration(
                  color: widget.isEnabled
                      ? widget.color.withOpacity(0.2)
                      : isDark
                          ? const Color(0xFF1B1122)
                          : const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AnimatedAlign(
                  alignment: widget.isEnabled
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: Container(
                    width: 16,
                    height: 16,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: widget.isEnabled
                          ? widget.color
                          : isDark
                              ? const Color(0xFF513267)
                              : const Color(0xFF9E9E9E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}