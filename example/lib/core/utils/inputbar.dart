import 'package:flutter/material.dart';
import '../../constants/app_sizes.dart';
import '../../constants/color_const.dart';

/// A reusable input component for forms and general text input.
///
/// Features:
/// - Optional title with required indicator
/// - Prefix and suffix icons
/// - Obscure text for passwords
/// - Validation support
/// - Outlined style with focused/error states
class SkInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final bool isOutlined;
  final String? title;
  final bool isTitle;
  final String? Function(String?)? validator;
  final bool isRequired;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final TextStyle? titleTextStyle;
  final double? border;
  final Color? borderColor;
  final double? radious;

  const SkInput({
    Key? key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.isOutlined = false,
    this.isTitle = true,
    this.title,
    this.validator,
    this.isRequired = false,
    this.backgroundColor,
    this.height,
    this.width,
    this.textStyle,
    this.hintTextStyle,
    this.titleTextStyle,
    this.border,
    this.borderColor,
    this.radious,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width ?? 200,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isTitle && title != null) _buildTitleSection(context, theme),
          Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? SkColors.errorMedium,
              border: (border != null && border! > 0)
                  ? Border.all(
                      width: border!,
                      color: borderColor ?? SkColors.primary, // fallback color
                    )
                  : Border.all(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(radious ?? 0),
              // no visible border
            ),

            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              onChanged: onChanged,
              validator: validator,
              style:
                  textStyle ??
                  theme.textTheme.bodyMedium?.copyWith(
                    color: SkColors.darkDark,
                  ),
              decoration: _buildInputDecoration(context, theme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style:
                titleTextStyle ??
                theme.textTheme.bodyLarge?.copyWith(color: SkColors.darkDark),
            children: [
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: SkColors.error,
                  ),
                ),
            ],
          ),
        ),
        Sksize.gapH12,
      ],
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context, ThemeData theme) {
    return InputDecoration(
      hintText: hintText,
      hintStyle:
          hintTextStyle ??
          theme.textTheme.bodyMedium?.copyWith(color: SkColors.darklight),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: prefixIcon,
            )
          : null,
      suffixIcon: suffixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 8, right: 12),
              child: suffixIcon,
            )
          : null,
      border: _buildBorder(),
      enabledBorder: _buildEnabledBorder(),
      focusedBorder: _buildFocusedBorder(),
      errorBorder: _buildErrorBorder(),
    );
  }

  InputBorder? _buildBorder() {
    if (!isOutlined) return InputBorder.none;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: SkColors.darkLightest, width: 1.0),
    );
  }

  InputBorder? _buildEnabledBorder() {
    if (!isOutlined) return InputBorder.none;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: SkColors.darkLightest, width: 1.0),
    );
  }

  InputBorder? _buildFocusedBorder() {
    if (!isOutlined) return InputBorder.none;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: SkColors.primaryDark, width: 2.0),
    );
  }

  InputBorder? _buildErrorBorder() {
    if (!isOutlined) return InputBorder.none;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: SkColors.error, width: 1.0),
    );
  }
}
