// utils/progress_utils.dart
import 'package:flutter/material.dart';
import 'progress_slider.dart';

class SkProgressUtils {
  static Widget buildLinearProgress({
    required double value,
    double max = 100.0,
    double height = 8.0,
    Color? backgroundColor,
    Color? progressColor,
    bool showPercentage = true,
    bool showValue = false,
  }) {
    return SkProgressSlider(
      value: value,
      max: max,
      height: height,
      backgroundColor: backgroundColor,
      progressColor: progressColor,
      showPercentage: showPercentage,
      showValue: showValue,
    );
  }

  static Widget buildCircularProgress({
    required double value,
    double max = 100.0,
    double size = 40.0,
    double strokeWidth = 4.0,
    Color? backgroundColor,
    Color? progressColor,
    bool showPercentage = true,
  }) {
    return EnhancedSkProgressSlider(
      value: value,
      max: max,
      height: size,
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      isCircular: true,
      strokeWidth: strokeWidth,
      showPercentage: showPercentage,
      showValue: false,
    );
  }

  static Widget buildGradientProgress({
    required double value,
    required List<Color> gradientColors,
    double max = 100.0,
    double height = 12.0,
  }) {
    return EnhancedSkProgressSlider(
      value: value,
      max: max,
      height: height,
      gradientColors: gradientColors,
      style: ProgressStyle.gradient,
      showPercentage: true,
    );
  }

  static Widget buildModernProgress({
    required double value,
    double max = 100.0,
    double height = 10.0,
    Color? progressColor,
    bool showGlow = true,
  }) {
    return EnhancedSkProgressSlider(
      value: value,
      max: max,
      height: height,
      progressColor: progressColor,
      style: ProgressStyle.modern,
      showGlow: showGlow,
      showPercentage: true,
    );
  }
}

// components/sk_progress_slider.dart

class SkProgressSlider extends StatelessWidget {
  final double value;
  final double max;
  final double height;
  final Color? backgroundColor;
  final Color? progressColor;
  final Color? glowColor;
  final BorderRadiusGeometry? borderRadius;
  final bool showPercentage;
  final bool showValue;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final bool animate;

  const SkProgressSlider({
    Key? key,
    required this.value,
    this.max = 100.0,
    this.height = 12.0,
    this.backgroundColor,
    this.progressColor,
    this.glowColor,
    this.borderRadius,
    this.showPercentage = false,
    this.showValue = false,
    this.textStyle,
    this.padding = EdgeInsets.zero,
    this.animate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.surfaceVariant;
    final effectiveProgressColor = progressColor ?? theme.primaryColor;
    final effectiveGlowColor = glowColor ?? progressColor ?? theme.primaryColor;
    final percentage = (value / max).clamp(0.0, 1.0);

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress bar
          Stack(
            children: [
              // Background track
              Container(
                height: height,
                decoration: BoxDecoration(
                  color: effectiveBackgroundColor,
                  borderRadius:
                      borderRadius ?? BorderRadius.circular(height / 2),
                ),
              ),
              // Progress track
              AnimatedContainer(
                duration: animate
                    ? const Duration(milliseconds: 300)
                    : Duration.zero,
                curve: Curves.easeOut,
                height: height,
                width: MediaQuery.of(context).size.width * percentage,
                decoration: BoxDecoration(
                  color: effectiveProgressColor,
                  borderRadius:
                      borderRadius ?? BorderRadius.circular(height / 2),
                  boxShadow: [
                    BoxShadow(
                      color: effectiveGlowColor,
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Text indicators
          if (showPercentage || showValue) ...[
            const SizedBox(height: 8),
            _buildTextIndicators(context, percentage),
          ],
        ],
      ),
    );
  }

  Widget _buildTextIndicators(BuildContext context, double percentage) {
    final theme = Theme.of(context);
    final effectiveTextStyle = textStyle ?? theme.textTheme.bodySmall;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (showValue)
          Text(
            '${value.toStringAsFixed(1)} / ${max.toStringAsFixed(1)}',
            style: effectiveTextStyle?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        if (showPercentage)
          Text(
            '${(percentage * 100).toStringAsFixed(0)}%',
            style: effectiveTextStyle?.copyWith(
              fontWeight: FontWeight.w600,
              color: progressColor ?? theme.primaryColor,
            ),
          ),
      ],
    );
  }
}
