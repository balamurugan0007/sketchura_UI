import 'package:flutter/material.dart';
import '../../../constants/color_const.dart';
import '../sk_button/sk_button.dart';

class SkSnackbar {
  // Success, Error, Info, Warning colors
  static const Color successColor = SkColors.success;
  static const Color errorColor = SkColors.error;
  static const Color infoColor = SkColors.primary;
  static const Color warningColor = SkColors.warning;

  /// Show a snackbar
  static void show({
    required BuildContext context,
    required String message,
    Color backgroundColor = SkColors.primary,
    Duration duration = const Duration(seconds: 3),
    bool isFloating = true,
    TextStyle? textStyle,
    String? actionLabel,
    TextStyle? btnTextStyle,
    double? radius,
    VoidCallback? onTap,
  }) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              message,
              style:
                  textStyle ??
                  Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: SkColors.infoLight),
            ),
          ),
          // Action button
          SkTextButton(
            label: actionLabel ?? "Cancel",
            textStyle:
                btnTextStyle ??
                Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: SkColors.lightLightest),
            onTap: () {
              // Execute custom callback if provided
              if (onTap != null) {
                onTap();
              }
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 12),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Shortcut methods for different types
  static void success(
    BuildContext context,
    String message, {
    VoidCallback? onTap,
  }) {
    show(
      context: context,
      message: message,
      backgroundColor: successColor,
      onTap: onTap,
    );
  }

  static void error(BuildContext context, String message) {
    show(context: context, message: message, backgroundColor: errorColor);
  }

  static void info(BuildContext context, String message) {
    show(context: context, message: message, backgroundColor: infoColor);
  }

  static void warning(BuildContext context, String message) {
    show(context: context, message: message, backgroundColor: warningColor);
  }
}
