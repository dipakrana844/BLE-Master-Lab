import 'package:flutter/material.dart';
import '../../../../core/utils/app_spacing.dart';

/// A hero section component with animated circuit logo and tagline.
///
/// Features:
/// - Animated minimalist circuit logo
/// - Responsive typography
/// - Theme-aware styling
/// - Performance-optimized animations
class HeroSection extends StatelessWidget {
  final String tagline;
  final String subtitle;

  const HeroSection({
    super.key,
    required this.tagline,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Padding(
      padding: AppSpacing.paddingHorizontalMd,
      child: Column(
        children: [
          AppSpacing.verticalGapXl,
          // Animated circuit logo
          const _CircuitLogo(),
          AppSpacing.verticalGapLg,
          
          // Main tagline
          Text(
            tagline,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineLarge?.copyWith(
              height: 1.2,
            ),
          ),
          AppSpacing.verticalGapSm,
          
          // Subtitle
          SizedBox(
            width: 280,
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark 
                    ? const Color(0xFF8ECCCC) 
                    : theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
          ),
          AppSpacing.verticalGapMd,
        ],
      ),
    );
  }
}

/// Animated circuit logo with pulsing rings and central hub.
class _CircuitLogo extends StatefulWidget {
  const _CircuitLogo();

  @override
  State<_CircuitLogo> createState() => _CircuitLogoState();
}

class _CircuitLogoState extends State<_CircuitLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    
    return RepaintBoundary(
      child: SizedBox(
        width: 128,
        height: 128,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer pulsing ring
            ScaleTransition(
              scale: _pulseAnimation,
              child: Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primaryColor.withOpacity(0.2),
                    width: 2,
                  ),
                ),
              ),
            ),
            
            // Inner rotated square
            Transform.rotate(
              angle: 0.785, // 45 degrees in radians
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor.withOpacity(0.4),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            
            // Central hub with glow
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                Icons.hub,
                size: 48,
                color: primaryColor,
                fill: 1,
              ),
            ),
            
            // Decorative circuit lines
            Positioned(
              left: -48,
              top: 64,
              child: Container(
                width: 48,
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      primaryColor,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: -48,
              top: 64,
              child: Container(
                width: 48,
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      primaryColor,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}