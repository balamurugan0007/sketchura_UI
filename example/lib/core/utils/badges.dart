import 'package:flutter/material.dart';
import '../../constants/color_const.dart';

///
///
/// Example usage:
/// ```dart
// Basic badge on an icon
// SkGlobalBadge(
//   value: "5",
//   child: Icon(Icons.notifications, size: 30),
// )

// // Badge on custom widget
// SkGlobalBadge(
//   value: "New",
//   child: Container(
//     width: 50,
//     height: 50,
//     decoration: BoxDecoration(
//       color: Colors.blue,
//       borderRadius: BorderRadius.circular(8),
//     ),
//   ),
// )
// )
/// )
/// ```
class SkGlobalBadge extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? badgeColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final bool showBadge;

  const SkGlobalBadge({
    Key? key,
    required this.child,
    required this.value,
    this.badgeColor,
    this.textColor,
    this.borderRadius = 10.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    this.showBadge = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!showBadge || value.isEmpty) {
      return child;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: -4,
          top: -4,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: badgeColor ?? Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: SkColors.darkLightest,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
