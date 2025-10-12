// components/enhanced_sk_progress_slider.dart
import 'package:flutter/material.dart';

enum ProgressStyle { linear, rounded, gradient, striped, modern, neumorphic }

class EnhancedSkProgressSlider extends StatefulWidget {
  final double value;
  final double max;
  final double height;
  final Color? backgroundColor;
  final Color? progressColor;
  final List<Color>? gradientColors;
  final BorderRadiusGeometry? borderRadius;
  final bool showPercentage;
  final bool showValue;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final bool animate;
  final ProgressStyle style;
  final bool showGlow;
  final double strokeWidth; // For circular style
  final bool isCircular; // Circular progress indicator
  final double? width;

  const EnhancedSkProgressSlider({
    Key? key,
    required this.value,
    this.max = 100.0,
    this.height = 12.0,
    this.backgroundColor,
    this.progressColor,
    this.gradientColors,
    this.borderRadius,
    this.showPercentage = false,
    this.showValue = false,
    this.textStyle,
    this.padding = EdgeInsets.zero,
    this.animate = true,
    this.style = ProgressStyle.linear,
    this.showGlow = false,
    this.strokeWidth = 4.0,
    this.isCircular = false,
    this.width,
  }) : super(key: key);

  @override
  State<EnhancedSkProgressSlider> createState() =>
      _EnhancedSkProgressSliderState();
}

class _EnhancedSkProgressSliderState extends State<EnhancedSkProgressSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    if (widget.animate) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(EnhancedSkProgressSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && widget.value != oldWidget.value) {
      _animation = Tween<double>(begin: oldWidget.value, end: widget.value)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeOut,
            ),
          );
      _animationController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: widget.isCircular
          ? _buildCircularProgress(context)
          : _buildLinearProgress(context),
    );
  }

  Widget _buildLinearProgress(BuildContext context) {
    final theme = Theme.of(context);
    final percentage = (widget.value / widget.max).clamp(0.0, 1.0);
    final animatedPercentage = _animation.value / widget.max;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress bar
        Container(
          width: widget.width,
          height: widget.height,
          decoration: _buildTrackDecoration(context),
          child: Stack(
            children: [
              // Progress
              AnimatedContainer(
                duration: widget.animate
                    ? const Duration(milliseconds: 500)
                    : Duration.zero,
                curve: Curves.easeOut,
                width:
                    (widget.width ?? MediaQuery.of(context).size.width) *
                    (widget.animate ? animatedPercentage : percentage),
                decoration: _buildProgressDecoration(context),
              ),
              // Stripes for striped style
              if (widget.style == ProgressStyle.striped)
                _buildStripes(context, percentage),
            ],
          ),
        ),
        // Text indicators
        if (widget.showPercentage || widget.showValue) ...[
          const SizedBox(height: 8),
          _buildTextIndicators(context, percentage),
        ],
      ],
    );
  }

  Widget _buildCircularProgress(BuildContext context) {
    final theme = Theme.of(context);
    final percentage = (widget.value / widget.max).clamp(0.0, 1.0);
    final animatedPercentage = _animation.value / widget.max;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Background circle
            Container(
              width: widget.height,
              height: widget.height,
              decoration: BoxDecoration(
                color:
                    widget.backgroundColor ?? theme.colorScheme.surfaceVariant,
                shape: BoxShape.circle,
              ),
            ),
            // Progress circle
            SizedBox(
              width: widget.height,
              height: widget.height,
              child: CircularProgressIndicator(
                value: widget.animate ? animatedPercentage : percentage,
                strokeWidth: widget.strokeWidth,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.progressColor ?? theme.primaryColor,
                ),
              ),
            ),
            // Percentage text in center
            if (widget.showPercentage)
              Text(
                '${(percentage * 100).toStringAsFixed(0)}%',
                style:
                    widget.textStyle ??
                    theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
          ],
        ),
        if (widget.showValue) ...[
          const SizedBox(height: 8),
          Text(
            '${widget.value.toStringAsFixed(1)} / ${widget.max.toStringAsFixed(1)}',
            style: widget.textStyle ?? theme.textTheme.bodySmall,
          ),
        ],
      ],
    );
  }

  BoxDecoration _buildTrackDecoration(BuildContext context) {
    final theme = Theme.of(context);
    final baseDecoration = BoxDecoration(
      color: widget.backgroundColor ?? theme.colorScheme.surfaceVariant,
      borderRadius:
          widget.borderRadius ?? BorderRadius.circular(widget.height / 2),
    );

    switch (widget.style) {
      case ProgressStyle.neumorphic:
        return baseDecoration.copyWith(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
            BoxShadow(
              color: Colors.white,
              blurRadius: 4,
              offset: const Offset(-2, -2),
            ),
          ],
        );
      default:
        return baseDecoration;
    }
  }

  BoxDecoration _buildProgressDecoration(BuildContext context) {
    final theme = Theme.of(context);
    final baseDecoration = BoxDecoration(
      borderRadius:
          widget.borderRadius ?? BorderRadius.circular(widget.height / 2),
    );

    switch (widget.style) {
      case ProgressStyle.gradient:
        return baseDecoration.copyWith(
          gradient: LinearGradient(
            colors:
                widget.gradientColors ??
                [theme.primaryColor, theme.primaryColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        );
      case ProgressStyle.modern:
        return baseDecoration.copyWith(
          color: widget.progressColor ?? theme.primaryColor,
          boxShadow: widget.showGlow
              ? [
                  BoxShadow(
                    color: (widget.progressColor ?? theme.primaryColor),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        );
      default:
        return baseDecoration.copyWith(
          color: widget.progressColor ?? theme.primaryColor,
        );
    }
  }

  Widget _buildStripes(BuildContext context, double percentage) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final containerWidth = constraints.maxWidth;
        final stripeWidth = 10.0;
        final stripeSpacing = 5.0;
        final stripeCount = (containerWidth / (stripeWidth + stripeSpacing))
            .ceil();

        return ClipRRect(
          borderRadius:
              widget.borderRadius ?? BorderRadius.circular(widget.height / 2),
          child: Row(
            children: List.generate(stripeCount, (index) {
              return Container(
                width: stripeWidth,
                height: widget.height,
                margin: EdgeInsets.only(right: stripeSpacing),
                color: index.isEven ? Colors.white : Colors.white,
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildTextIndicators(BuildContext context, double percentage) {
    final theme = Theme.of(context);
    final effectiveTextStyle = widget.textStyle ?? theme.textTheme.bodySmall;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.showValue)
          Text(
            '${widget.value.toStringAsFixed(1)} / ${widget.max.toStringAsFixed(1)}',
            style: effectiveTextStyle?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        if (widget.showPercentage)
          Text(
            '${(percentage * 100).toStringAsFixed(0)}%',
            style: effectiveTextStyle?.copyWith(
              fontWeight: FontWeight.w600,
              color: widget.progressColor ?? theme.primaryColor,
            ),
          ),
      ],
    );
  }
}
