import 'package:flutter/material.dart';

class SkResponsive {
  // ===========================================================================
  // BREAKPOINTS (Tailwind inspired)
  // ===========================================================================
  static const double xs = 480.0; // Extra small mobile
  static const double sm = 640.0; // Small mobile
  static const double md = 768.0; // Medium tablet
  static const double lg = 1024.0; // Large laptop
  static const double xl = 1280.0; // XL desktop
  static const double xxl = 1536.0; // 2XL large desktop

  // ===========================================================================
  // SCREEN SIZE IDENTIFICATION
  // ===========================================================================

  static String getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < xs) return 'xs';
    if (width < sm) return 'sm';
    if (width < md) return 'md';
    if (width < lg) return 'lg';
    if (width < xl) return 'xl';
    return 'xxl';
  }

  static bool isXs(BuildContext context) =>
      MediaQuery.of(context).size.width < xs;
  static bool isSm(BuildContext context) =>
      MediaQuery.of(context).size.width >= sm &&
      MediaQuery.of(context).size.width < md;
  static bool isMd(BuildContext context) =>
      MediaQuery.of(context).size.width >= md &&
      MediaQuery.of(context).size.width < lg;
  static bool isLg(BuildContext context) =>
      MediaQuery.of(context).size.width >= lg &&
      MediaQuery.of(context).size.width < xl;
  static bool isXl(BuildContext context) =>
      MediaQuery.of(context).size.width >= xl &&
      MediaQuery.of(context).size.width < xxl;
  static bool isXxl(BuildContext context) =>
      MediaQuery.of(context).size.width >= xxl;

  // Device type identification
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < md;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= md &&
      MediaQuery.of(context).size.width < lg;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= lg;

  // ===========================================================================
  // FIXED SkRESPONSIVE VALUE METHODS
  // ===========================================================================

  /// Gets Skresponsive double value based on screen size
  /// Gets Skresponsive double value based on screen size
  static double valueDouble(
    BuildContext context, {
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final width = MediaQuery.of(context).size.width;

    // Priority to specific breakpoints
    if (xxl != null && width >= SkResponsive.xxl) return xxl;
    if (xl != null && width >= SkResponsive.xl) return xl;
    if (lg != null && width >= SkResponsive.lg) return lg;
    if (md != null && width >= SkResponsive.md) return md;
    if (sm != null && width >= SkResponsive.sm) return sm;
    if (xs != null && width >= SkResponsive.xs) return xs;

    // Fallback to device type - use the class constants instead of parameters
    if (desktop != null && width >= SkResponsive.lg) return desktop;
    if (tablet != null && width >= SkResponsive.md) return tablet;

    return mobile;
  }

  /// Gets Skresponsive int value based on screen size
  /// Gets Skresponsive int value based on screen size
  static int valueInt(
    BuildContext context, {
    int? xs,
    int? sm,
    int? md,
    int? lg,
    int? xl,
    int? xxl,
    required int mobile,
    int? tablet,
    int? desktop,
  }) {
    final width = MediaQuery.of(context).size.width;

    // Priority to specific breakpoints
    if (xxl != null && width >= SkResponsive.xxl) return xxl;
    if (xl != null && width >= SkResponsive.xl) return xl;
    if (lg != null && width >= SkResponsive.lg) return lg;
    if (md != null && width >= SkResponsive.md) return md;
    if (sm != null && width >= SkResponsive.sm) return sm;
    if (xs != null && width >= SkResponsive.xs) return xs;

    // Fallback to device type - use the class constants instead of parameters
    if (desktop != null && width >= SkResponsive.lg) return desktop;
    if (tablet != null && width >= SkResponsive.md) return tablet;

    return mobile;
  }

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (width >= lg) return desktop ?? tablet ?? mobile;
    if (width >= md) return tablet ?? mobile;
    return mobile;
  }

  // ===========================================================================
  // SkRESPONSIVE SIZING IDENTIFICATION
  // ===========================================================================

  /// Identify padding based on screen size
  static EdgeInsets identifyPadding(BuildContext context) {
    final padding = valueDouble(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );

    return EdgeInsets.all(padding);
  }

  /// Identify horizontal padding
  static EdgeInsets identifyHorizontalPadding(BuildContext context) {
    final padding = valueDouble(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );

    return EdgeInsets.symmetric(horizontal: padding);
  }

  /// Identify font size based on screen size
  static double identifyFontSize(BuildContext context) {
    return valueDouble(context, mobile: 14.0, tablet: 16.0, desktop: 18.0);
  }

  /// Identify container width based on screen size
  static double identifyContainerWidth(BuildContext context) {
    return valueDouble(
      context,
      mobile: MediaQuery.of(context).size.width * 0.9,
      tablet: MediaQuery.of(context).size.width * 0.8,
      desktop: MediaQuery.of(context).size.width * 0.6,
    );
  }

  /// Identify gap size based on screen size
  static SizedBox identifyGap(BuildContext context) {
    final gapSize = valueDouble(
      context,
      mobile: 8.0,
      tablet: 16.0,
      desktop: 24.0,
    );

    return SizedBox(height: gapSize);
  }

  /// Identify icon size based on screen size
  static double identifyIconSize(BuildContext context) {
    return valueDouble(context, mobile: 24.0, tablet: 28.0, desktop: 32.0);
  }

  // ===========================================================================
  // UTILITY METHODS FOR IDENTIFICATION
  // ===========================================================================

  /// Get current breakpoint name
  static String currentBreakpoint(BuildContext context) {
    return getScreenSize(context);
  }

  /// Check if current screen is larger than a breakpoint
  static bool isLargerThan(BuildContext context, String breakpoint) {
    final width = MediaQuery.of(context).size.width;

    switch (breakpoint) {
      case 'xs':
        return width >= xs;
      case 'sm':
        return width >= sm;
      case 'md':
        return width >= md;
      case 'lg':
        return width >= lg;
      case 'xl':
        return width >= xl;
      case 'xxl':
        return width >= xxl;
      default:
        return false;
    }
  }

  /// Check if current screen is smaller than a breakpoint
  static bool isSmallerThan(BuildContext context, String breakpoint) {
    final width = MediaQuery.of(context).size.width;

    switch (breakpoint) {
      case 'xs':
        return width < xs;
      case 'sm':
        return width < sm;
      case 'md':
        return width < md;
      case 'lg':
        return width < lg;
      case 'xl':
        return width < xl;
      case 'xxl':
        return width < xxl;
      default:
        return false;
    }
  }

  /// Get scale factor for Skresponsive sizing
  static double getScaleFactor(BuildContext context) {
    return valueDouble(context, mobile: 1.0, tablet: 1.2, desktop: 1.4);
  }
}
