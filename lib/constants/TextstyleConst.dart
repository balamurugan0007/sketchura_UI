import 'package:flutter/material.dart';

class TextStyleConst {
  static const String _fontName = "Inter";

  static final TextStyle H1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    fontFamily: _fontName,

    height: 1.4,
  );

  static final TextStyle H2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    fontFamily: _fontName,

    height: 1.4,
  );
  static final TextStyle H3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    fontFamily: _fontName,

    height: 1.4,
  );
  static final TextStyle H4 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: _fontName,

    height: 1.4,
  );
  static final TextStyle H5 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: _fontName,

    height: 1.4,
  );

  static final TextStyle text_Xl = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    fontFamily: _fontName,

    height: 1.4,
  );

  static final TextStyle text_L = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: _fontName,

    height: 1.4,
  );
  static final TextStyle text_M = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: _fontName,

    height: 1.4,
  );
  static final TextStyle text_s = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: _fontName,

    height: 1.4,
  );

  static final TextStyle text_xs = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    fontFamily: _fontName,

    height: 1.4,
  );

  static final TextStyle action_L = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: _fontName,

    height: 1.4,
  );

  static final TextStyle action_M = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontFamily: _fontName,

    height: 1.4,
  );

  static final TextStyle action_s = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    fontFamily: _fontName,

    height: 1.4,
  );

  static final TextStyle caption_M = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    fontFamily: _fontName,

    height: 1.4,
  );

  // Utility methods for dynamic styling
  static TextStyle withColor(TextStyle baseStyle, Color color) =>
      baseStyle.copyWith(color: color);

  static TextStyle withOpacity(TextStyle baseStyle, double opacity) =>
      baseStyle.copyWith(color: baseStyle.color?.withOpacity(opacity));

  static TextStyle withWeight(TextStyle baseStyle, FontWeight weight) =>
      baseStyle.copyWith(fontWeight: weight);
}

// | Style              | Font Size | Weight | Letter Spacing |
// | ------------------ | --------- | ------ | -------------- |
// | **displayLarge**   | 57        | w400   | -0.25          |
// | **displayMedium**  | 45        | w400   | 0.0            |
// | **displaySmall**   | 36        | w400   | 0.0            |
// | **headlineLarge**  | 32        | w400   | 0.0            |
// | **headlineMedium** | 28        | w400   | 0.0            |
// | **headlineSmall**  | 24        | w400   | 0.0            |
// | **titleLarge**     | 22        | w400   | 0.0            |
// | **titleMedium**    | 16        | w500   | 0.15           |
// | **titleSmall**     | 14        | w500   | 0.1            |
// | **bodyLarge**      | 16        | w400   | 0.5            |
// | **bodyMedium**     | 14        | w400   | 0.25           |
// | **bodySmall**      | 12        | w400   | 0.4            |
// | **labelLarge**     | 14        | w500   | 0.1            |
// | **labelMedium**    | 12        | w500   | 0.5            |
// | **labelSmall**     | 11        | w500   | 0.5            |
