import 'package:flutter/material.dart';
import '../../constants/color_const.dart';

///
///
/// Example usage:
/// ```dart
// Filled Button (Primary actions)
// SkFilledButton(
//   label: "Submit",

//   onTap: (){},
// )

// // Outlined Button (Secondary actions)
// SkOutlinedButton(
//   label: "Cancel",
//   borderColor: Skcolors.error,
//   onTap: () => (),
// )
/// ```
///
class SkFilledButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final double? w;
  final double? h;
  final double? borderRadius;
  final TextStyle? textStyle;

  final double? elevation;
  final BorderSide? border;
  final ShapeBorder? shape;

  /// Interaction
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autofocus;
  final MouseCursor? mouseCursor;

  const SkFilledButton({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.w,
    this.h,
    this.borderRadius,
    this.textStyle,

    this.elevation,
    this.border,
    this.shape,
    required this.onTap,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.mouseCursor,
  });

  bool get _isEnabled => onTap != null || onLongPress != null;

  @override
  Widget build(BuildContext context) {
    final effectiveShape =
        shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          side: border ?? BorderSide.none,
        );

    return Material(
      elevation: elevation ?? 0,
      color: _isEnabled
          ? (backgroundColor ?? SkColors.primary)
          : Theme.of(context).disabledColor,
      shape: effectiveShape,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        focusNode: focusNode,
        autofocus: autofocus,
        customBorder: effectiveShape,
        mouseCursor:
            mouseCursor ??
            (_isEnabled
                ? SystemMouseCursors.click
                : SystemMouseCursors.forbidden),
        child: Container(
          height: h ?? 40,
          width: w ?? 120,
          alignment: Alignment.center,
          child: Center(
            child: Text(
              label,
              style:
                  textStyle ??
                  Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: _isEnabled
                        ? (textColor ?? SkColors.lightLightest)
                        : SkColors.darklight,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class SkOutlinedButton extends StatelessWidget {
  final String label;
  final Color? borderColor;
  final Color? textColor;
  final double? w;
  final double? h;
  final double? borderRadius;
  final TextStyle? textStyle;

  final double? borderWidth;
  final ShapeBorder? shape;

  /// Interaction
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autofocus;
  final MouseCursor? mouseCursor;

  const SkOutlinedButton({
    super.key,
    required this.label,
    this.borderColor,
    this.textColor,
    this.w,
    this.h,
    this.borderRadius,
    this.textStyle,

    this.borderWidth,
    this.shape,
    required this.onTap,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.mouseCursor,
  });

  bool get _isEnabled => onTap != null || onLongPress != null;

  @override
  Widget build(BuildContext context) {
    final effectiveShape =
        shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          side: BorderSide(
            color: borderColor ?? Theme.of(context).colorScheme.primary,
            width: borderWidth ?? 1.2,
          ),
        );

    return Material(
      color: Colors.transparent,
      shape: effectiveShape,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        focusNode: focusNode,
        autofocus: autofocus,
        customBorder: effectiveShape,
        mouseCursor:
            mouseCursor ??
            (_isEnabled
                ? SystemMouseCursors.click
                : SystemMouseCursors.forbidden),
        child: Container(
          height: h ?? 40,
          width: w ?? 120,
          alignment: Alignment.center,
          child: Center(
            child: Text(
              label,
              style:
                  textStyle ??
                  Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: _isEnabled
                        ? (textColor ?? Theme.of(context).colorScheme.primary)
                        : Colors.black38,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class SkTextButton extends StatelessWidget {
  final String label;
  final Color? textColor;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final TextStyle? textStyle;
  final bool isUnderlined;

  final FocusNode? focusNode;
  final bool autofocus;
  final MouseCursor? mouseCursor;
  final TextAlign textAlign;

  const SkTextButton({
    super.key,
    required this.label,
    this.textColor,
    required this.onTap,
    this.onLongPress,
    this.textStyle,
    this.isUnderlined = false,

    this.focusNode,
    this.autofocus = false,
    this.mouseCursor,
    this.textAlign = TextAlign.center,
  });

  bool get _isEnabled => onTap != null || onLongPress != null;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        focusNode: focusNode,
        autofocus: autofocus,
        mouseCursor:
            mouseCursor ??
            (_isEnabled
                ? SystemMouseCursors.click
                : SystemMouseCursors.forbidden),
        borderRadius: BorderRadius.circular(4),
        child: Center(
          child: Text(
            label,
            textAlign: textAlign,
            style:
                textStyle ??
                Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: _isEnabled
                      ? (textColor ?? Theme.of(context).colorScheme.primary)
                      : Colors.black38,
                  decoration: isUnderlined
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
          ),
        ),
      ),
    );
  }
}

class SkIconButton extends StatelessWidget {
  final String label;
  final bool isRounded;
  final Color backgroundColor;
  final Color? textColor;
  final bool isOutlined;
  final Color borderColor;
  final double w;
  final double h;
  final double borderRadius;
  final VoidCallback? onTap;
  final Icon icon;
  final bool isPrefixIcon;
  final TextStyle? textStyle;

  final double spacing;
  final double borderWidth;

  const SkIconButton({
    super.key,
    required this.label,
    this.isRounded = true,
    this.backgroundColor = Colors.blue,
    this.borderColor = Colors.blue,
    this.isOutlined = false,
    this.textColor,
    required this.h,
    required this.w,
    required this.onTap,
    this.borderRadius = 12,
    required this.icon,
    this.isPrefixIcon = true,
    this.textStyle,

    this.spacing = 8,
    this.borderWidth = 1.5,
  });

  bool get _isEnabled => onTap != null;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      side: isOutlined
          ? BorderSide(color: borderColor, width: borderWidth)
          : BorderSide.none,
    );

    return Material(
      color: isOutlined ? Colors.transparent : backgroundColor,
      shape: shape,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: Container(
          height: h,
          width: w,
          child: Center(
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isPrefixIcon) icon,
                  if (isPrefixIcon) SizedBox(width: spacing),
                  Flexible(
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style:
                          textStyle ??
                          Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: _isEnabled
                                ? (textColor ?? Colors.white)
                                : Colors.black38,
                          ),
                    ),
                  ),
                  if (!isPrefixIcon) SizedBox(width: spacing),
                  if (!isPrefixIcon) icon,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// after delete

