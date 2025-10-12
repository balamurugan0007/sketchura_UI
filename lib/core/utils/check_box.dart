// components/checkbox.dart
import 'package:flutter/material.dart';

class SkGlobalCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String? label;
  final Widget? customLabel;
  final Color? activeColor;
  final Color? checkColor;
  final Color? fillColor;
  final bool tristate;
  final bool enabled;
  final EdgeInsetsGeometry padding;
  final MainAxisAlignment alignment;
  final double? size;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final double borderWidth;

  const SkGlobalCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.label,
    this.customLabel,
    this.activeColor,
    this.checkColor,
    this.fillColor,
    this.tristate = false,
    this.enabled = true,
    this.padding = const EdgeInsets.all(8.0),
    this.alignment = MainAxisAlignment.start,
    this.size,
    this.borderRadius,
    this.borderColor,
    this.borderWidth = 2.0,
  }) : super(key: key);

  @override
  State<SkGlobalCheckbox> createState() => _SkGlobalCheckboxState();
}

class _SkGlobalCheckboxState extends State<SkGlobalCheckbox> {
  late bool? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant SkGlobalCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _currentValue = widget.value;
    }
  }

  void _handleTap() {
    if (!widget.enabled) return;

    setState(() {
      if (widget.tristate) {
        if (_currentValue == null) {
          _currentValue = true;
        } else if (_currentValue == true) {
          _currentValue = false;
        } else {
          _currentValue = null;
        }
      } else {
        _currentValue = !(_currentValue ?? false);
      }
    });

    widget.onChanged(_currentValue);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveActiveColor = widget.activeColor ?? theme.primaryColor;
    final effectiveCheckColor =
        widget.checkColor ?? theme.colorScheme.onPrimary;
    final effectiveFillColor = widget.fillColor ?? effectiveActiveColor;
    final effectiveBorderColor = widget.borderColor ?? theme.dividerColor;

    Widget checkbox = Container(
      width: widget.size ?? 24.0,
      height: widget.size ?? 24.0,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(4.0),
        border: Border.all(
          color: widget.enabled ? effectiveBorderColor : effectiveBorderColor,
          width: widget.borderWidth,
        ),
        color: _currentValue == true ? effectiveFillColor : Colors.transparent,
      ),
      child: _currentValue == true
          ? Icon(
              Icons.check,
              size: (widget.size ?? 24.0) - 8.0,
              color: widget.enabled ? effectiveCheckColor : effectiveCheckColor,
            )
          : (widget.tristate && _currentValue == null)
          ? Icon(
              Icons.remove,
              size: (widget.size ?? 24.0) - 8.0,
              color: widget.enabled ? effectiveCheckColor : effectiveCheckColor,
            )
          : null,
    );

    final checkboxWidget = GestureDetector(onTap: _handleTap, child: checkbox);

    if (widget.label == null && widget.customLabel == null) {
      return checkboxWidget;
    }

    final labelWidget =
        widget.customLabel ??
        Text(
          widget.label!,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: widget.enabled
                ? theme.textTheme.bodyMedium?.color
                : theme.textTheme.bodyMedium?.color,
          ),
        );

    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisAlignment: widget.alignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          checkboxWidget,
          const SizedBox(width: 12.0),
          Flexible(child: labelWidget),
        ],
      ),
    );
  }
}

enum CheckboxStyle { material, rounded, circular, custom }

class EnhancedGlobalCheckbox extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool?> onChanged;
  final String? label;
  final Widget? customLabel;
  final Color? activeColor;
  final Color? checkColor;
  final Color? fillColor;
  final bool tristate;
  final bool enabled;
  final EdgeInsetsGeometry padding;
  final MainAxisAlignment alignment;
  final double? size;
  final CheckboxStyle style;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final bool showRippleEffect;
  final Duration animationDuration;
  final Curve animationCurve;

  const EnhancedGlobalCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.label,
    this.customLabel,
    this.activeColor,
    this.checkColor,
    this.fillColor,
    this.tristate = false,
    this.enabled = true,
    this.padding = const EdgeInsets.all(8.0),
    this.alignment = MainAxisAlignment.start,
    this.size,
    this.style = CheckboxStyle.material,
    this.borderRadius,
    this.borderColor,
    this.borderWidth = 2.0,
    this.showRippleEffect = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  }) : super(key: key);

  @override
  State<EnhancedGlobalCheckbox> createState() => _EnhancedGlobalCheckboxState();
}

class _EnhancedGlobalCheckboxState extends State<EnhancedGlobalCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: widget.animationCurve),
    );
  }

  @override
  void didUpdateWidget(covariant EnhancedGlobalCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _currentValue = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  BorderRadius _getBorderRadius() {
    switch (widget.style) {
      case CheckboxStyle.rounded:
        return BorderRadius.circular(8.0);
      case CheckboxStyle.circular:
        return BorderRadius.circular(50.0);
      case CheckboxStyle.custom:
        return widget.borderRadius ?? BorderRadius.circular(4.0);
      case CheckboxStyle.material:
      default:
        return BorderRadius.circular(2.0);
    }
  }

  void _handleTap() async {
    if (!widget.enabled) return;

    // Trigger scale animation
    if (widget.showRippleEffect) {
      await _controller.forward();
      await _controller.reverse();
    }

    // Manage value transitions
    setState(() {
      if (widget.tristate) {
        if (_currentValue == null) {
          _currentValue = true;
        } else if (_currentValue == true) {
          _currentValue = false;
        } else {
          _currentValue = null;
        }
      } else {
        _currentValue = !(_currentValue ?? false);
      }
    });

    widget.onChanged(_currentValue);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveActiveColor = widget.activeColor ?? theme.primaryColor;
    final effectiveCheckColor =
        widget.checkColor ?? theme.colorScheme.onPrimary;
    final effectiveFillColor = widget.fillColor ?? effectiveActiveColor;
    final effectiveBorderColor = widget.borderColor ?? theme.dividerColor;

    final isChecked = _currentValue == true;
    final isIndeterminate = widget.tristate && _currentValue == null;

    Widget checkbox = AnimatedContainer(
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      width: widget.size ?? 24.0,
      height: widget.size ?? 24.0,
      decoration: BoxDecoration(
        borderRadius: _getBorderRadius(),
        border: Border.all(
          color: widget.enabled ? effectiveBorderColor : effectiveBorderColor,
          width: widget.borderWidth,
        ),
        color: isChecked || isIndeterminate
            ? (widget.enabled ? effectiveFillColor : effectiveFillColor)
            : Colors.transparent,
      ),
      child: AnimatedScale(
        scale: _scaleAnimation.value,
        duration: widget.animationDuration,
        child: Center(
          child: isChecked
              ? Icon(
                  Icons.check,
                  size: (widget.size ?? 24.0) - 8.0,
                  color: effectiveCheckColor,
                )
              : isIndeterminate
              ? Icon(
                  Icons.remove,
                  size: (widget.size ?? 24.0) - 8.0,
                  color: effectiveCheckColor,
                )
              : null,
        ),
      ),
    );

    // Add ripple effect
    final child = widget.showRippleEffect
        ? Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: _getBorderRadius(),
              onTap: _handleTap,
              child: checkbox,
            ),
          )
        : GestureDetector(onTap: _handleTap, child: checkbox);

    // If no label → just checkbox
    if (widget.label == null && widget.customLabel == null) {
      return child;
    }

    final labelWidget =
        widget.customLabel ??
        Text(
          widget.label!,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: widget.enabled
                ? theme.textTheme.bodyMedium?.color
                : theme.textTheme.bodyMedium?.color,
          ),
        );

    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisAlignment: widget.alignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          const SizedBox(width: 10),
          Flexible(child: labelWidget),
        ],
      ),
    );
  }
}
