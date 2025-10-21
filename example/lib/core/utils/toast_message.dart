import 'package:flutter/material.dart';
import '../../constants/color_const.dart';

class SkToast {
  static const String successToast = 'success';
  static const String warningToast = 'warning';
  static const String errToast = 'error';
  static const String infoToast = 'info';

  static void show({
    required BuildContext context,
    required String message,
    required String title,
    bool showCloseButton = true,
    Duration duration = const Duration(seconds: 3),
    String type = successToast,
    bool isTittleShow = false,
    bool isDesShow = true,

    // 🔥 Adjustable Parameters
    double? width,
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(horizontal: 16),
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 12,
    ),
    double borderRadius = 14,
    double elevation = 10,
    double iconSize = 22,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    double verticalOffset = 20, // Distance from top
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        final theme = Theme.of(context);

        return Positioned(
          top: MediaQuery.of(context).padding.top + verticalOffset,
          left: margin is EdgeInsets ? margin.left : 16,
          right: margin is EdgeInsets ? margin.right : 16,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: -50, end: 0),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, value),
                child: Opacity(opacity: value == 0 ? 1 : 0.9, child: child),
              );
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: width,
                padding: padding,
                decoration: BoxDecoration(
                  color: type == successToast
                      ? Colors.green.shade100
                      : type == warningToast
                      ? Colors.orange.shade100
                      : type == errToast
                      ? Colors.red.shade100
                      : Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: elevation,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔥 Icon inside circle
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: SkColors.lightMedium,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        type == successToast
                            ? Icons.check_circle_rounded
                            : type == warningToast
                            ? Icons.warning_amber_rounded
                            : type == errToast
                            ? Icons.error_rounded
                            : Icons.info_rounded,
                        color: type == successToast
                            ? Colors.green
                            : type == warningToast
                            ? Colors.orange
                            : type == errToast
                            ? Colors.red
                            : Colors.blue,
                        size: iconSize,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // 🔥 Title & Message
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isTittleShow)
                            Text(
                              title,
                              style:
                                  titleStyle ??
                                  theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                            ),
                          if (isDesShow)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                message,
                                style:
                                    messageStyle ??
                                    theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.black87,
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // 🔥 Close button
                    if (showCloseButton)
                      IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          overlayEntry.remove();
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);

    // Auto remove after duration
    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}
