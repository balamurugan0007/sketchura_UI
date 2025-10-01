import 'package:flutter/material.dart';

class SkBreadcrumbs extends StatelessWidget {
  final List<String> items;
  final ValueChanged<int>? onTap; // to know which item clicked
  final TextStyle? textStyle;
  final TextStyle? activeStyle;
  final Widget separator;
  final bool isunderlineRequired;

  const SkBreadcrumbs({
    super.key,
    required this.items,
    this.onTap,
    this.textStyle,
    this.activeStyle,
    this.isunderlineRequired = false,
    this.separator = const Icon(
      Icons.chevron_right,
      size: 16,
      color: Colors.grey,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(items.length * 2 - 1, (index) {
        if (index.isOdd) {
          return separator; // separator between items
        }
        final itemIndex = index ~/ 2;
        final isLast = itemIndex == items.length - 1;

        return GestureDetector(
          onTap: isLast ? null : () => onTap?.call(itemIndex),
          child: Text(
            items[itemIndex],
            style: isLast
                ? (activeStyle ??
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ))
                : (textStyle ??
                      TextStyle(
                        color: Colors.blue,
                        decoration: isunderlineRequired
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      )),
          ),
        );
      }),
    );
  }
}
