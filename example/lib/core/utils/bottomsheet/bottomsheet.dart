import 'package:flutter/material.dart';
import '../../../constants/color_const.dart';

class SkBottomSheet extends StatelessWidget {
  final String title;
  final Widget content;
  final double? height;
  final Color? backgroundColor;
  final double? borderRadius;

  const SkBottomSheet({
    super.key,
    required this.title,
    required this.content,
    this.height,
    this.backgroundColor,
    this.borderRadius,
  });

  /// Call this static function to show the sheet
  static Future<void> show(
    BuildContext context, {
    required String title,
    required Widget content,
    double? height,
    Color? backgroundColor,
    double? borderRadius,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius ?? 20),
        ),
      ),
      backgroundColor: backgroundColor ?? Colors.white,
      builder: (context) {
        return SkBottomSheet(
          title: title,
          content: content,
          height: height,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius ?? 20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sheet handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: SkColors.darkLightest,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          // Title
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          // Main content
          Expanded(child: content),
        ],
      ),
    );
  }
}
