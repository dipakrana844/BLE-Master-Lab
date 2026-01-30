import 'package:flutter/material.dart';

/// Utility class for consistent spacing throughout the app.
abstract class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  
  // Symmetrical padding
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);
  static const EdgeInsets paddingXxl = EdgeInsets.all(xxl);
  
  // Horizontal padding
  static const EdgeInsets paddingHorizontalXs = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets paddingHorizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets paddingHorizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets paddingHorizontalXl = EdgeInsets.symmetric(horizontal: xl);
  
  // Vertical padding
  static const EdgeInsets paddingVerticalXs = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets paddingVerticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets paddingVerticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets paddingVerticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets paddingVerticalXl = EdgeInsets.symmetric(vertical: xl);
  
  // Symmetrical margin
  static const EdgeInsets marginXs = EdgeInsets.all(xs);
  static const EdgeInsets marginSm = EdgeInsets.all(sm);
  static const EdgeInsets marginMd = EdgeInsets.all(md);
  static const EdgeInsets marginLg = EdgeInsets.all(lg);
  static const EdgeInsets marginXl = EdgeInsets.all(xl);
  static const EdgeInsets marginXxl = EdgeInsets.all(xxl);
  
  // Gap widgets for consistent spacing
  static const Widget gapXs = SizedBox(height: xs, width: xs);
  static const Widget gapSm = SizedBox(height: sm, width: sm);
  static const Widget gapMd = SizedBox(height: md, width: md);
  static const Widget gapLg = SizedBox(height: lg, width: lg);
  static const Widget gapXl = SizedBox(height: xl, width: xl);
  static const Widget gapXxl = SizedBox(height: xxl, width: xxl);
  
  // Horizontal gaps
  static const Widget horizontalGapXs = SizedBox(width: xs);
  static const Widget horizontalGapSm = SizedBox(width: sm);
  static const Widget horizontalGapMd = SizedBox(width: md);
  static const Widget horizontalGapLg = SizedBox(width: lg);
  static const Widget horizontalGapXl = SizedBox(width: xl);
  static const Widget horizontalGapXxl = SizedBox(width: xxl);
  
  // Vertical gaps
  static const Widget verticalGapXs = SizedBox(height: xs);
  static const Widget verticalGapSm = SizedBox(height: sm);
  static const Widget verticalGapMd = SizedBox(height: md);
  static const Widget verticalGapLg = SizedBox(height: lg);
  static const Widget verticalGapXl = SizedBox(height: xl);
  static const Widget verticalGapXxl = SizedBox(height: xxl);
}