import 'package:flutter/material.dart';
import 'package:sketchura_ui/constants/color_const.dart';

/// A global, reusable dialog container with customization options.
// utils/dialog_utils.dart
// components/sk_dialog.dart

enum DialogType { info, success, warning, error, custom }

enum DialogSize { small, medium, large, custom }

class SkDialog extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;
  final bool enableScroll;
  final AlignmentGeometry alignment;
  final Duration animationDuration;
  final Curve animationCurve;
  final DialogType type;
  final Color? overlayColor;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final Widget? icon;
  final Color? borderColor;
  final double borderWidth;

  const SkDialog({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.width,
    this.height,
    this.radius,
    this.padding,
    this.boxShadow,
    this.enableScroll = false,
    this.alignment = Alignment.center,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOutBack,
    this.type = DialogType.custom,
    this.overlayColor,
    this.showCloseButton = false,
    this.onClose,
    this.icon,
    this.borderColor,
    this.borderWidth = 0,
  }) : super(key: key);

  Color _getTypeColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (type) {
      case DialogType.success:
        return Colors.green;
      case DialogType.error:
        return Colors.red;
      case DialogType.warning:
        return Colors.orange;
      case DialogType.info:
        return theme.primaryColor;
      case DialogType.custom:
        return theme.primaryColor;
    }
  }

  Widget _getTypeIcon(BuildContext context) {
    switch (type) {
      case DialogType.success:
        return Icon(
          Icons.check_circle,
          color: _getTypeColor(context),
          size: 32,
        );
      case DialogType.error:
        return Icon(Icons.error, color: _getTypeColor(context), size: 32);
      case DialogType.warning:
        return Icon(Icons.warning, color: _getTypeColor(context), size: 32);
      case DialogType.info:
        return Icon(Icons.info, color: _getTypeColor(context), size: 32);
      case DialogType.custom:
        return icon ?? const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor =
        backgroundColor ?? theme.dialogBackgroundColor;
    final hasIcon = type != DialogType.custom || icon != null;

    final dialogContent = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(radius ?? 20),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: SkColors.darkDarkest,
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: -5,
              ),
            ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showCloseButton)
            Align(
              alignment: Alignment.topRight,
              child: _buildCloseButton(context),
            ),
          if (hasIcon) Center(child: _getTypeIcon(context)),
          if (hasIcon) const SizedBox(height: 16),
          Flexible(
            child: enableScroll
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: child,
                  )
                : child,
          ),
        ],
      ),
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(24),
      child: _buildAnimatedDialog(dialogContent),
    );
  }

  Widget _buildAnimatedDialog(Widget content) {
    return AnimatedPadding(
      padding: const EdgeInsets.all(24),
      duration: animationDuration,
      curve: animationCurve,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            duration: animationDuration,
            curve: animationCurve,
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: Curves.easeInOutBack.transform(value),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: content,
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return GestureDetector(
      onTap: onClose ?? () => Navigator.of(context).pop(),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        child: Icon(
          Icons.close,
          size: 18,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }
}

class SkDialogUtils {
  static Future<T?> showSkDialog<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color? barrierColor,
    DialogType type = DialogType.custom,
    DialogSize size = DialogSize.medium,
    bool showCloseButton = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
      builder: (context) {
        final dialogContent = builder(context);
        return SkDialog(
          type: type,
          showCloseButton: showCloseButton,
          width: _getDialogWidth(size),
          child: dialogContent,
        );
      },
    );
  }

  static double _getDialogWidth(DialogSize size) {
    switch (size) {
      case DialogSize.small:
        return 300;
      case DialogSize.medium:
        return 400;
      case DialogSize.large:
        return 500;
      case DialogSize.custom:
        return 400;
    }
  }

  // FIXED: This is the new function name to use instead of SkAlertDialog
  static Future<void> showSkAlertDialog({
    required BuildContext context,
    String? title,
    String? message,
    Widget? content,
    String confirmText = "OK",
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    DialogType type = DialogType.info,
    DialogSize size = DialogSize.medium,
    Color? backgroundColor,
    double? radius,
    bool barrierDismissible = true,
    bool showCloseButton = true,
    EdgeInsetsGeometry? padding,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
    bool destructiveAction = false,
  }) {
    return showSkDialog(
      context: context,
      type: type,
      size: size,
      barrierDismissible: barrierDismissible,
      showCloseButton: showCloseButton,
      builder: (context) {
        final theme = Theme.of(context);
        final typeColor = _getTypeColor(type, theme);

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: typeColor,
                ),
              ),
            if (message != null || content != null) ...[
              if (title != null) const SizedBox(height: 12),
              content ??
                  Text(
                    message!,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      height: 1.4,
                    ),
                  ),
            ],
            const SizedBox(height: 24),
            _buildDialogActions(
              context: context,
              cancelText: cancelText,
              confirmText: confirmText,
              onCancel: onCancel,
              onConfirm: onConfirm,
              destructiveAction: destructiveAction,
              confirmButtonColor: confirmButtonColor ?? typeColor,
            ),
          ],
        );
      },
    );
  }

  static Future<void> showSkSuccessDialog({
    required BuildContext context,
    required String title,
    String? message,
    String confirmText = "Great!",
    VoidCallback? onConfirm,
  }) {
    return showSkAlertDialog(
      context: context,
      title: title,
      message: message,
      confirmText: confirmText,
      type: DialogType.success,
      onConfirm: onConfirm,
    );
  }

  static Future<void> showSkErrorDialog({
    required BuildContext context,
    required String title,
    String? message,
    String confirmText = "Try Again",
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showSkAlertDialog(
      context: context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      type: DialogType.error,
      onConfirm: onConfirm,
      onCancel: onCancel,
      destructiveAction: true,
    );
  }

  static Future<bool?> showSkConfirmationDialog({
    required BuildContext context,
    required String title,
    String? message,
    String confirmText = "Confirm",
    String cancelText = "Cancel",
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool destructive = false,
  }) {
    return showSkDialog<bool>(
      context: context,
      type: destructive ? DialogType.warning : DialogType.info,
      builder: (context) {
        final theme = Theme.of(context);
        final typeColor = _getTypeColor(
          destructive ? DialogType.warning : DialogType.info,
          theme,
        );

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: typeColor,
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 12),
              Text(
                message,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  height: 1.4,
                ),
              ),
            ],
            const SizedBox(height: 24),
            _buildDialogActions(
              context: context,
              cancelText: cancelText,
              confirmText: confirmText,
              onCancel: onCancel,
              onConfirm: onConfirm,
              destructiveAction: destructive,
              confirmButtonColor: typeColor,
            ),
          ],
        );
      },
    );
  }

  static Widget _buildDialogActions({
    required BuildContext context,
    required String? cancelText,
    required String confirmText,
    required VoidCallback? onCancel,
    required VoidCallback? onConfirm,
    required bool destructiveAction,
    Color? confirmButtonColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (cancelText != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onCancel?.call();
            },
            child: Text(
              cancelText,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        const SizedBox(width: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: destructiveAction
                ? Theme.of(context).colorScheme.error
                : confirmButtonColor,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm?.call();
          },
          child: Text(confirmText),
        ),
      ],
    );
  }

  static Color _getTypeColor(DialogType type, ThemeData theme) {
    switch (type) {
      case DialogType.success:
        return Colors.green;
      case DialogType.error:
        return theme.colorScheme.error;
      case DialogType.warning:
        return Colors.orange;
      case DialogType.info:
        return theme.primaryColor;
      case DialogType.custom:
        return theme.primaryColor;
    }
  }
}
