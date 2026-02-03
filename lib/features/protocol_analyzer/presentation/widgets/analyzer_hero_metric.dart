import 'package:flutter/material.dart';
import '../../../../core/widgets/app_card.dart';

/// Hero metric display showing current throughput with trend indicator
class AnalyzerHeroMetric extends StatelessWidget {
  const AnalyzerHeroMetric({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppCard(
        padding: const EdgeInsets.all(24),
        color: isDark ? const Color(0xFF392348) : Colors.white,
        borderColor: isDark ? null : theme.dividerColor.withOpacity(0.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CURRENT THROUGHPUT',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: isDark ? const Color(0xFFB292C9) : theme.disabledColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
                Icon(
                  Icons.speed,
                  color: const Color(0xFF00F5D4),
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '124.5',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'kbps',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '+12.4%',
                  style: TextStyle(
                    color: const Color(0xFF00F5D4),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1B1122)
                          : const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.65,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}