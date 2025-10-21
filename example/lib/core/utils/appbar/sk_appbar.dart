import 'package:flutter/material.dart';

class SkAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool centerTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final double elevation;
  final Widget? leading;
  final double? height;
  final SkAppBarStyle style;
  final Gradient? gradient;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? titleWidget;
  final double titleSpacing;
  final bool automaticallyImplyLeading;
  final Color? iconThemeColor;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final double toolbarHeight;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final List<BoxShadow>? customShadow;
  final Widget? flexibleSpace;
  final bool transparent;

  const SkAppBar({
    Key? key,
    required this.title,
    this.subtitle,
    this.centerTitle = false,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.elevation = 0,
    this.leading,
    this.height,
    this.style = SkAppBarStyle.standard,
    this.gradient,
    this.showBackButton = true,
    this.onBackPressed,
    this.titleWidget,
    this.titleSpacing = 16,
    this.automaticallyImplyLeading = true,
    this.iconThemeColor,
    this.shadowColor,
    this.shape,
    this.toolbarHeight = kToolbarHeight,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.customShadow,
    this.flexibleSpace,
    this.transparent = false,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(
    height ??
        toolbarHeight +
            (subtitle != null ? 20 : 0) +
            (style == SkAppBarStyle.large ? 30 : 0),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      backgroundColor: _getBackgroundColor(theme, colorScheme),
      elevation: _getElevation(),
      shadowColor: shadowColor,
      shape: shape,
      centerTitle: centerTitle,
      leading: _buildLeading(context),
      automaticallyImplyLeading: automaticallyImplyLeading,
      titleSpacing: titleSpacing,
      toolbarHeight: preferredSize.height,
      iconTheme: IconThemeData(
        color: iconThemeColor ?? _getIconColor(theme, colorScheme),
      ),
      actionsIconTheme: IconThemeData(
        color: iconThemeColor ?? _getIconColor(theme, colorScheme),
      ),
      title: _buildTitle(context, theme, colorScheme),
      actions: actions,
      flexibleSpace: _buildFlexibleSpace(theme, colorScheme),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    if (showBackButton && Navigator.of(context).canPop()) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        splashRadius: 20,
      );
    }
    return null;
  }

  Widget _buildTitle(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    if (titleWidget != null) return titleWidget!;

    final crossAlignment = centerTitle
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: crossAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (style == SkAppBarStyle.large) const SizedBox(height: 8),
        Text(
          title,
          style:
              titleTextStyle ??
              theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: _getTitleColor(theme, colorScheme),
                fontSize: _getTitleFontSize(),
                letterSpacing: -0.5,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            style:
                subtitleTextStyle ??
                theme.textTheme.bodySmall?.copyWith(
                  color: _getSubtitleColor(theme, colorScheme),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget? _buildFlexibleSpace(ThemeData theme, ColorScheme colorScheme) {
    if (flexibleSpace != null) return flexibleSpace;

    if (gradient != null) {
      return Container(decoration: BoxDecoration(gradient: gradient));
    }

    if (customShadow != null || style == SkAppBarStyle.floating) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: customShadow ?? _getCustomShadow(),
        ),
      );
    }

    return null;
  }

  Color _getBackgroundColor(ThemeData theme, ColorScheme colorScheme) {
    if (transparent) return Colors.transparent;

    switch (style) {
      case SkAppBarStyle.standard:
        return backgroundColor ?? colorScheme.primary;
      case SkAppBarStyle.light:
        return backgroundColor ?? colorScheme.surface;
      case SkAppBarStyle.dark:
        return backgroundColor ?? colorScheme.surface;
      case SkAppBarStyle.gradient:
        return backgroundColor ?? Colors.transparent;
      case SkAppBarStyle.floating:
        return backgroundColor ?? theme.cardColor;
      case SkAppBarStyle.transparent:
        return Colors.transparent;
      case SkAppBarStyle.large:
        return backgroundColor ?? colorScheme.primary;
    }
  }

  Color _getTitleColor(ThemeData theme, ColorScheme colorScheme) {
    if (titleColor != null) return titleColor!;

    switch (style) {
      case SkAppBarStyle.standard:
        return Colors.white;
      case SkAppBarStyle.light:
        return colorScheme.onSurface;
      case SkAppBarStyle.dark:
        return Colors.white;
      case SkAppBarStyle.gradient:
        return Colors.white;
      case SkAppBarStyle.floating:
        return colorScheme.onSurface;
      case SkAppBarStyle.transparent:
        return colorScheme.onSurface;
      case SkAppBarStyle.large:
        return Colors.white;
    }
  }

  Color _getSubtitleColor(ThemeData theme, ColorScheme colorScheme) {
    switch (style) {
      case SkAppBarStyle.standard:
        return Colors.white;
      case SkAppBarStyle.light:
        return colorScheme.onSurface;
      case SkAppBarStyle.dark:
        return Colors.white;
      case SkAppBarStyle.gradient:
        return Colors.white;
      case SkAppBarStyle.floating:
        return colorScheme.onSurface;
      case SkAppBarStyle.transparent:
        return colorScheme.onSurface;
      case SkAppBarStyle.large:
        return Colors.white;
    }
  }

  Color _getIconColor(ThemeData theme, ColorScheme colorScheme) {
    if (iconThemeColor != null) return iconThemeColor!;

    switch (style) {
      case SkAppBarStyle.standard:
        return Colors.white;
      case SkAppBarStyle.light:
        return colorScheme.onSurface;
      case SkAppBarStyle.dark:
        return Colors.white;
      case SkAppBarStyle.gradient:
        return Colors.white;
      case SkAppBarStyle.floating:
        return colorScheme.onSurface;
      case SkAppBarStyle.transparent:
        return colorScheme.onSurface;
      case SkAppBarStyle.large:
        return Colors.white;
    }
  }

  double _getElevation() {
    switch (style) {
      case SkAppBarStyle.standard:
        return elevation;
      case SkAppBarStyle.light:
        return 0;
      case SkAppBarStyle.dark:
        return 0;
      case SkAppBarStyle.gradient:
        return 0;
      case SkAppBarStyle.floating:
        return 4;
      case SkAppBarStyle.transparent:
        return 0;
      case SkAppBarStyle.large:
        return 0;
    }
  }

  double _getTitleFontSize() {
    switch (style) {
      case SkAppBarStyle.large:
        return 24;
      default:
        return 18;
    }
  }

  List<BoxShadow>? _getCustomShadow() {
    switch (style) {
      case SkAppBarStyle.floating:
        return [
          BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ];
      default:
        return customShadow;
    }
  }
}

enum SkAppBarStyle {
  standard,
  light,
  dark,
  gradient,
  floating,
  transparent,
  large,
}

// Pre-styled AppBar variations for quick use
class SkAppBarVariations {
  static AppBar light({
    required String title,
    String? subtitle,
    List<Widget>? actions,
    bool centerTitle = false,
  }) => AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: centerTitle,
    title: Column(
      crossAxisAlignment: centerTitle
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
      ],
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
    actions: actions,
  );

  static AppBar gradient({
    required String title,
    Gradient? gradient,
    List<Widget>? actions,
  }) => AppBar(
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient:
            gradient ??
            LinearGradient(
              colors: [Colors.blue.shade600, Colors.purple.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
      ),
    ),
    elevation: 0,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    actions: actions,
  );

  static AppBar floating({
    required String title,
    required BuildContext context,
    List<Widget>? actions,
    double elevation = 8,
  }) => AppBar(
    backgroundColor: Theme.of(context).cardColor,
    elevation: elevation,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    title: Text(
      title,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
    ),
    iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
    actions: actions,
  );

  static AppBar transparent({
    required String title,
    List<Widget>? actions,
    Color? titleColor,
  }) => AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(
        color: titleColor ?? Colors.black87,
        fontWeight: FontWeight.w600,
      ),
    ),
    iconTheme: IconThemeData(color: titleColor ?? Colors.black87),
    actions: actions,
  );

  static AppBar large({
    required String title,
    String? subtitle,
    List<Widget>? actions,
    Color? backgroundColor,
  }) => AppBar(
    backgroundColor: backgroundColor ?? Colors.blue,
    elevation: 0,
    toolbarHeight: kToolbarHeight + 30,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
      ],
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    actions: actions,
  );
}

// Usage Examples:
/*
// 1. Standard AppBar
SkAppBar(
  title: 'Home',
  style: SkAppBarStyle.standard,
)

// 2. Light AppBar
SkAppBar(
  title: 'Profile',
  subtitle: 'Manage your account',
  style: SkAppBarStyle.light,
)

// 3. Gradient AppBar
SkAppBar(
  title: 'Dashboard',
  style: SkAppBarStyle.gradient,
  gradient: LinearGradient(...),
)

// 4. Floating AppBar
SkAppBar(
  title: 'Settings',
  style: SkAppBarStyle.floating,
)

// 5. Transparent AppBar
SkAppBar(
  title: 'Gallery',
  style: SkAppBarStyle.transparent,
)

// 6. Large AppBar
SkAppBar(
  title: 'Product Details',
  subtitle: 'All product information',
  style: SkAppBarStyle.large,
)

// Quick variations
SkAppBarVariations.light(title: 'Light Theme')
SkAppBarVariations.gradient(title: 'Gradient Style')
SkAppBarVariations.floating(title: 'Floating', context: context)
*/
