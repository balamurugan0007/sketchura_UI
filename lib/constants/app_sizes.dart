import 'package:flutter/material.dart';

class Sksize {
  // Base scale factors for different screen types
  static const double _mobileScale = 1.0;
  static const double _tabletScale = 1.25;
  static const double _desktopScale = 1.5;
  static const double _largeDesktopScale = 1.75;

  // Responsive scaling method
  static double scaleSize(double baseSize, BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 600) {
      return baseSize * _mobileScale; // Mobile
    } else if (width < 900) {
      return baseSize * _tabletScale; // Tablet
    } else if (width < 1200) {
      return baseSize * _desktopScale; // Desktop
    } else {
      return baseSize * _largeDesktopScale; // Large Desktop
    }
  }

  // ===========================================================================
  // CORE SPACING SYSTEM (8px grid system)
  // ===========================================================================

  // Base spacing units
  static const double space0 = 0.0;
  static const double space1 = 1.0;
  static const double space2 = 2.0;
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space56 = 56.0;
  static const double space64 = 64.0;
  static const double space72 = 72.0;
  static const double space80 = 80.0;
  static const double space96 = 96.0;
  static const double space120 = 120.0;
  static const double space128 = 128.0;
  static const double space160 = 160.0;
  static const double space200 = 200.0;
  static const double space240 = 240.0;
  static const double space280 = 280.0;
  static const double space320 = 320.0;

  // ===========================================================================
  // PADDING & MARGIN CONSTANTS
  // ===========================================================================

  // Padding constants (using p prefix)
  static const double p0 = 0.0;
  static const double p1 = 1.0;
  static const double p2 = 2.0;
  static const double p4 = 4.0;
  static const double p8 = 8.0;
  static const double p12 = 12.0;
  static const double p16 = 16.0;
  static const double p20 = 20.0;
  static const double p24 = 24.0;
  static const double p32 = 32.0;
  static const double p40 = 40.0;
  static const double p48 = 48.0;
  static const double p56 = 56.0;
  static const double p64 = 64.0;
  static const double p80 = 80.0;
  static const double p96 = 96.0;
  static const double p120 = 120.0;
  static const double p160 = 160.0;
  static const double max = double.maxFinite;

  // Margin constants (using m prefix)
  static const double m0 = 0.0;
  static const double m2 = 2.0;
  static const double m4 = 4.0;
  static const double m8 = 8.0;
  static const double m12 = 12.0;
  static const double m16 = 16.0;
  static const double m20 = 20.0;
  static const double m24 = 24.0;
  static const double m32 = 32.0;
  static const double m40 = 40.0;
  static const double m48 = 48.0;
  static const double m56 = 56.0;
  static const double m64 = 64.0;
  static const double m80 = 80.0;
  static const double m96 = 96.0;
  static const double m120 = 120.0;
  static const double m160 = 160.0;

  // ===========================================================================
  // BORDER RADIUS
  // ===========================================================================

  // Small radius range
  static const double radiusNone = 0.0;
  static const double radiusXSmall = 2.0;
  static const double radiusSmall = 4.0;
  static const double radiusSmall_6 = 6.0;
  static const double radiusSmall_8 = 8.0;

  // Medium radius range
  static const double radiusMedium = 12.0;
  static const double radiusMedium_16 = 16.0;

  // Large radius range
  static const double radiusLarge = 20.0;
  static const double radiusLarge_24 = 24.0;
  static const double radiusXLarge = 28.0;
  static const double radius2XLarge = 32.0;

  // Extra large radius range
  static const double radius3XLarge = 40.0;
  static const double radius4XLarge = 48.0;
  static const double radius5XLarge = 56.0;
  static const double radius6XLarge = 64.0;

  // Circular radius (for circles)
  static const double radiusCircular = 1000.0;

  // ===========================================================================
  // ICON SIZES
  // ===========================================================================

  // Extra small icons
  static const double iconXSmall = 12.0;
  static const double iconXSmall_14 = 14.0;

  // Small icons
  static const double iconSmall = 16.0;
  static const double iconSmall_18 = 18.0;

  // Medium icons
  static const double iconMedium = 20.0;
  static const double iconMedium_22 = 22.0;
  static const double iconMedium_24 = 24.0;

  // Large icons
  static const double iconLarge = 28.0;
  static const double iconLarge_32 = 32.0;

  // Extra large icons
  static const double iconXLarge = 40.0;
  static const double iconXLarge_48 = 48.0;

  // XXL icons
  static const double icon2XLarge = 56.0;
  static const double icon2XLarge_64 = 64.0;
  static const double icon3XLarge = 72.0;
  static const double icon4XLarge = 96.0;

  // ===========================================================================
  // BUTTON SIZES
  // ===========================================================================

  // Button heights
  static const double buttonHeightXSmall = 32.0;
  static const double buttonHeightSmall = 40.0;
  static const double buttonHeight = 48.0;
  static const double buttonHeightLarge = 56.0;
  static const double buttonHeightXLarge = 64.0;
  static const double buttonHeight2XLarge = 72.0;

  // Button padding
  static const double buttonPaddingXSmall = 12.0;
  static const double buttonPaddingSmall = 16.0;
  static const double buttonPadding = 20.0;
  static const double buttonPaddingLarge = 24.0;
  static const double buttonPaddingXLarge = 32.0;

  // ===========================================================================
  // APP BAR & NAVIGATION
  // ===========================================================================

  // App bar heights
  static const double appBarHeightSmall = 56.0;
  static const double appBarHeight = 64.0;
  static const double appBarHeightLarge = 72.0;
  static const double appBarHeightXLarge = 80.0;

  // Bottom navigation
  static const double bottomNavHeightMobile = 56.0;
  static const double bottomNavHeightTablet = 64.0;
  static const double navRailWidth = 72.0;
  static const double navRailWidthExpanded = 240.0;

  // Desktop navigation
  static const double desktopNavHeight = 64.0;
  static const double desktopSidebarWidth = 280.0;
  static const double desktopSidebarWidthCollapsed = 80.0;

  // ===========================================================================
  // LAYOUT SIZES
  // ===========================================================================

  // Container constraints
  static const double containerXSmall = 320.0;
  static const double containerSmall = 480.0;
  static const double containerMedium = 640.0;
  static const double containerLarge = 768.0;
  static const double containerXLarge = 1024.0;
  static const double container2XLarge = 1280.0;
  static const double container3XLarge = 1440.0;
  static const double container4XLarge = 1920.0;

  // Card sizes
  static const double cardHeightSmall = 120.0;
  static const double cardHeightMedium = 160.0;
  static const double cardHeightLarge = 200.0;
  static const double cardHeightXLarge = 240.0;

  // ===========================================================================
  // TYPOGRAPHY & TEXT SIZES
  // ===========================================================================

  // Text scale factors
  static const double textScaleSmall = 0.9;
  static const double textScaleNormal = 1.0;
  static const double textScaleLarge = 1.1;
  static const double textScaleXLarge = 1.25;

  // Line heights
  static const double lineHeightTight = 1.0;
  static const double lineHeightNormal = 1.2;
  static const double lineHeightRelaxed = 1.4;
  static const double lineHeightLoose = 1.6;

  // ===========================================================================
  // BORDER WIDTHS
  // ===========================================================================

  static const double borderNone = 0.0;
  static const double borderThin = 0.5;
  static const double borderNormal = 1.0;
  static const double borderThick = 2.0;
  static const double borderThicker = 3.0;
  static const double borderThickest = 4.0;

  // ===========================================================================
  // DIVIDER SIZES
  // ===========================================================================

  static const double dividerHeight = 1.0;
  static const double dividerHeightThick = 2.0;
  static const double dividerHeightThicker = 4.0;
  static const double dividerHeightThickest = 8.0;

  // ===========================================================================
  // ELEVATION & SHADOWS
  // ===========================================================================

  static const double elevationNone = 0.0;
  static const double elevationSmall = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationLarge = 8.0;
  static const double elevationXLarge = 16.0;
  static const double elevation2XLarge = 24.0;

  // ===========================================================================
  // ANIMATION & TRANSITION DURATIONS
  // ===========================================================================

  static const Duration durationInstant = Duration(milliseconds: 0);
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);
  static const Duration durationVerySlow = Duration(milliseconds: 700);

  // ===========================================================================
  // PADDING EDGEINSETS
  // ===========================================================================

  // All-around padding
  static const EdgeInsets paddingAll0 = EdgeInsets.all(space0);
  static const EdgeInsets paddingAll4 = EdgeInsets.all(space4);
  static const EdgeInsets paddingAll8 = EdgeInsets.all(space8);
  static const EdgeInsets paddingAll12 = EdgeInsets.all(space12);
  static const EdgeInsets paddingAll16 = EdgeInsets.all(space16);
  static const EdgeInsets paddingAll20 = EdgeInsets.all(space20);
  static const EdgeInsets paddingAll24 = EdgeInsets.all(space24);
  static const EdgeInsets paddingAll32 = EdgeInsets.all(space32);
  static const EdgeInsets paddingAll40 = EdgeInsets.all(space40);
  static const EdgeInsets paddingAll48 = EdgeInsets.all(space48);
  static const EdgeInsets paddingAll64 = EdgeInsets.all(space64);

  // Horizontal padding
  static const EdgeInsets paddingHorizontal4 = EdgeInsets.symmetric(
    horizontal: space4,
  );
  static const EdgeInsets paddingHorizontal8 = EdgeInsets.symmetric(
    horizontal: space8,
  );
  static const EdgeInsets paddingHorizontal12 = EdgeInsets.symmetric(
    horizontal: space12,
  );
  static const EdgeInsets paddingHorizontal16 = EdgeInsets.symmetric(
    horizontal: space16,
  );
  static const EdgeInsets paddingHorizontal20 = EdgeInsets.symmetric(
    horizontal: space20,
  );
  static const EdgeInsets paddingHorizontal24 = EdgeInsets.symmetric(
    horizontal: space24,
  );
  static const EdgeInsets paddingHorizontal32 = EdgeInsets.symmetric(
    horizontal: space32,
  );
  static const EdgeInsets paddingHorizontal40 = EdgeInsets.symmetric(
    horizontal: space40,
  );
  static const EdgeInsets paddingHorizontal48 = EdgeInsets.symmetric(
    horizontal: space48,
  );
  static const EdgeInsets paddingHorizontal64 = EdgeInsets.symmetric(
    horizontal: space64,
  );

  // Vertical padding
  static const EdgeInsets paddingVertical4 = EdgeInsets.symmetric(
    vertical: space4,
  );
  static const EdgeInsets paddingVertical8 = EdgeInsets.symmetric(
    vertical: space8,
  );
  static const EdgeInsets paddingVertical12 = EdgeInsets.symmetric(
    vertical: space12,
  );
  static const EdgeInsets paddingVertical16 = EdgeInsets.symmetric(
    vertical: space16,
  );
  static const EdgeInsets paddingVertical20 = EdgeInsets.symmetric(
    vertical: space20,
  );
  static const EdgeInsets paddingVertical24 = EdgeInsets.symmetric(
    vertical: space24,
  );
  static const EdgeInsets paddingVertical32 = EdgeInsets.symmetric(
    vertical: space32,
  );
  static const EdgeInsets paddingVertical40 = EdgeInsets.symmetric(
    vertical: space40,
  );
  static const EdgeInsets paddingVertical48 = EdgeInsets.symmetric(
    vertical: space48,
  );
  static const EdgeInsets paddingVertical64 = EdgeInsets.symmetric(
    vertical: space64,
  );

  // Symmetric padding
  static const EdgeInsets paddingSymmetricH8V4 = EdgeInsets.symmetric(
    horizontal: space8,
    vertical: space4,
  );
  static const EdgeInsets paddingSymmetricH16V8 = EdgeInsets.symmetric(
    horizontal: space16,
    vertical: space8,
  );
  static const EdgeInsets paddingSymmetricH16V12 = EdgeInsets.symmetric(
    horizontal: space16,
    vertical: space12,
  );
  static const EdgeInsets paddingSymmetricH16V16 = EdgeInsets.symmetric(
    horizontal: space16,
    vertical: space16,
  );
  static const EdgeInsets paddingSymmetricH20V12 = EdgeInsets.symmetric(
    horizontal: space20,
    vertical: space12,
  );
  static const EdgeInsets paddingSymmetricH24V16 = EdgeInsets.symmetric(
    horizontal: space24,
    vertical: space16,
  );
  static const EdgeInsets paddingSymmetricH32V16 = EdgeInsets.symmetric(
    horizontal: space32,
    vertical: space16,
  );
  static const EdgeInsets paddingSymmetricH40V24 = EdgeInsets.symmetric(
    horizontal: space40,
    vertical: space24,
  );

  // ===========================================================================
  // MARGIN EDGEINSETS
  // ===========================================================================

  // All-around margin
  static const EdgeInsets marginAll4 = EdgeInsets.all(space4);
  static const EdgeInsets marginAll8 = EdgeInsets.all(space8);
  static const EdgeInsets marginAll12 = EdgeInsets.all(space12);
  static const EdgeInsets marginAll16 = EdgeInsets.all(space16);
  static const EdgeInsets marginAll20 = EdgeInsets.all(space20);
  static const EdgeInsets marginAll24 = EdgeInsets.all(space24);
  static const EdgeInsets marginAll32 = EdgeInsets.all(space32);
  static const EdgeInsets marginAll40 = EdgeInsets.all(space40);
  static const EdgeInsets marginAll48 = EdgeInsets.all(space48);
  static const EdgeInsets marginAll64 = EdgeInsets.all(space64);

  // Horizontal margin
  static const EdgeInsets marginHorizontal4 = EdgeInsets.symmetric(
    horizontal: space4,
  );
  static const EdgeInsets marginHorizontal8 = EdgeInsets.symmetric(
    horizontal: space8,
  );
  static const EdgeInsets marginHorizontal12 = EdgeInsets.symmetric(
    horizontal: space12,
  );
  static const EdgeInsets marginHorizontal16 = EdgeInsets.symmetric(
    horizontal: space16,
  );
  static const EdgeInsets marginHorizontal20 = EdgeInsets.symmetric(
    horizontal: space20,
  );
  static const EdgeInsets marginHorizontal24 = EdgeInsets.symmetric(
    horizontal: space24,
  );
  static const EdgeInsets marginHorizontal32 = EdgeInsets.symmetric(
    horizontal: space32,
  );
  static const EdgeInsets marginHorizontal40 = EdgeInsets.symmetric(
    horizontal: space40,
  );
  static const EdgeInsets marginHorizontal48 = EdgeInsets.symmetric(
    horizontal: space48,
  );
  static const EdgeInsets marginHorizontal64 = EdgeInsets.symmetric(
    horizontal: space64,
  );

  // Vertical margin
  static const EdgeInsets marginVertical4 = EdgeInsets.symmetric(
    vertical: space4,
  );
  static const EdgeInsets marginVertical8 = EdgeInsets.symmetric(
    vertical: space8,
  );
  static const EdgeInsets marginVertical12 = EdgeInsets.symmetric(
    vertical: space12,
  );
  static const EdgeInsets marginVertical16 = EdgeInsets.symmetric(
    vertical: space16,
  );
  static const EdgeInsets marginVertical20 = EdgeInsets.symmetric(
    vertical: space20,
  );
  static const EdgeInsets marginVertical24 = EdgeInsets.symmetric(
    vertical: space24,
  );
  static const EdgeInsets marginVertical32 = EdgeInsets.symmetric(
    vertical: space32,
  );
  static const EdgeInsets marginVertical40 = EdgeInsets.symmetric(
    vertical: space40,
  );
  static const EdgeInsets marginVertical48 = EdgeInsets.symmetric(
    vertical: space48,
  );
  static const EdgeInsets marginVertical64 = EdgeInsets.symmetric(
    vertical: space64,
  );

  // ===========================================================================
  // GAPS (SIZEDBOX)
  // ===========================================================================

  // Width gaps
  static const SizedBox gapW2 = SizedBox(width: space2);
  static const SizedBox gapW4 = SizedBox(width: space4);
  static const SizedBox gapW8 = SizedBox(width: space8);
  static const SizedBox gapW12 = SizedBox(width: space12);
  static const SizedBox gapW16 = SizedBox(width: space16);
  static const SizedBox gapW20 = SizedBox(width: space20);
  static const SizedBox gapW24 = SizedBox(width: space24);
  static const SizedBox gapW32 = SizedBox(width: space32);
  static const SizedBox gapW40 = SizedBox(width: space40);
  static const SizedBox gapW48 = SizedBox(width: space48);
  static const SizedBox gapW56 = SizedBox(width: space56);
  static const SizedBox gapW64 = SizedBox(width: space64);
  static const SizedBox gapW80 = SizedBox(width: space80);
  static const SizedBox gapW96 = SizedBox(width: space96);

  // Height gaps
  static const SizedBox gapH2 = SizedBox(height: space2);
  static const SizedBox gapH4 = SizedBox(height: space4);
  static const SizedBox gapH8 = SizedBox(height: space8);
  static const SizedBox gapH12 = SizedBox(height: space12);
  static const SizedBox gapH16 = SizedBox(height: space16);
  static const SizedBox gapH20 = SizedBox(height: space20);
  static const SizedBox gapH24 = SizedBox(height: space24);
  static const SizedBox gapH32 = SizedBox(height: space32);
  static const SizedBox gapH40 = SizedBox(height: space40);
  static const SizedBox gapH48 = SizedBox(height: space48);
  static const SizedBox gapH56 = SizedBox(height: space56);
  static const SizedBox gapH64 = SizedBox(height: space64);
  static const SizedBox gapH80 = SizedBox(height: space80);
  static const SizedBox gapH96 = SizedBox(height: space96);
  static const SizedBox gapH120 = SizedBox(height: space120);
  static const SizedBox gapH160 = SizedBox(height: space160);

  // ===========================================================================
  // CUSTOM METHODS
  // ===========================================================================

  // Padding methods
  static EdgeInsets setPaddingAll({required double size}) {
    return EdgeInsets.all(size);
  }

  static EdgeInsets setPaddingSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) {
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  static EdgeInsets setPaddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
  }

  // Margin methods
  static EdgeInsets setMarginAll({required double size}) {
    return EdgeInsets.all(size);
  }

  static EdgeInsets setMarginSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) {
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  static EdgeInsets setMarginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
  }

  // Fixed the missing method
  static EdgeInsets setPaddingSide({required double h, required double v}) {
    return EdgeInsets.symmetric(horizontal: h, vertical: v);
  }

  // Responsive methods
  static double responsiveSize(
    BuildContext context,
    double mobile,
    double tablet,
    double desktop,
  ) {
    final width = MediaQuery.of(context).size.width;

    if (width < 600) {
      return mobile;
    } else if (width < 900) {
      return tablet;
    } else {
      return desktop;
    }
  }

  // Breakpoints for responsive design
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 900;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900;
  static bool isLargeDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;
}
