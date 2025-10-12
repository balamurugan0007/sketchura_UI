import 'package:flutter/material.dart';

class SkNavbarDropdownItem {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final Widget? trailing;
  final bool isDivider;
  final bool isHeader;
  final Color? backgroundColor;

  SkNavbarDropdownItem({
    required this.label,
    required this.onTap,
    this.icon,
    this.iconColor,
    this.textColor,
    this.trailing,
    this.isDivider = false,
    this.isHeader = false,
    this.backgroundColor,
  });

  factory SkNavbarDropdownItem.divider() {
    return SkNavbarDropdownItem(label: '', onTap: () {}, isDivider: true);
  }

  factory SkNavbarDropdownItem.header({required String label}) {
    return SkNavbarDropdownItem(label: label, onTap: () {}, isHeader: true);
  }
}

class SkNavbarDropdown extends StatefulWidget {
  final String title;
  final List<SkNavbarDropdownItem> items;
  final TextStyle? textStyle;
  final TextStyle? dropdownTextStyle;
  final Color? backgroundColor;
  final Color? hoverColor;
  final Color? activeColor;
  final double? dropdownWidth;
  final SkNavbarDropdownStyle style;
  final Widget? customTitle;
  final bool showCaret;
  final Duration animationDuration;
  final Curve animationCurve;
  final Alignment dropdownAlignment;
  final double? maxDropdownHeight;
  final BorderRadius? dropdownBorderRadius;
  final List<BoxShadow>? customShadow;
  final EdgeInsetsGeometry? itemPadding;
  final bool closeOnItemTap;

  const SkNavbarDropdown({
    super.key,
    required this.title,
    required this.items,
    this.textStyle,
    this.dropdownTextStyle,
    this.backgroundColor,
    this.hoverColor,
    this.activeColor,
    this.dropdownWidth = 200,
    this.style = SkNavbarDropdownStyle.standard,
    this.customTitle,
    this.showCaret = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.dropdownAlignment = Alignment.topLeft,
    this.maxDropdownHeight,
    this.dropdownBorderRadius,
    this.customShadow,
    this.itemPadding,
    this.closeOnItemTap = true,
  });

  @override
  State<SkNavbarDropdown> createState() => _SkNavbarDropdownState();
}

class _SkNavbarDropdownState extends State<SkNavbarDropdown> {
  bool _isHovered = false;
  bool _isExpanded = false;
  final LayerLink _layerLink = LayerLink();

  void _toggleDropdown() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _closeDropdown() {
    if (_isExpanded) {
      setState(() {
        _isExpanded = false;
      });
    }
  }

  void _handleItemTap(SkNavbarDropdownItem item) {
    item.onTap();
    if (widget.closeOnItemTap) {
      _closeDropdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final actualHoverColor = widget.hoverColor ?? colorScheme.primary;
    final actualActiveColor = widget.activeColor ?? colorScheme.primary;
    final actualBackgroundColor =
        widget.backgroundColor ?? theme.colorScheme.surface;

    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: _toggleDropdown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Navbar title
              _buildTitle(
                theme,
                colorScheme,
                actualHoverColor,
                actualActiveColor,
              ),

              // Dropdown menu (positioned separately)
              if (_isExpanded || _isHovered)
                _buildDropdownMenu(theme, colorScheme, actualBackgroundColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(
    ThemeData theme,
    ColorScheme colorScheme,
    Color hoverColor,
    Color activeColor,
  ) {
    final isActive = _isHovered || _isExpanded;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? hoverColor : Colors.transparent,
        borderRadius: _getTitleBorderRadius(),
      ),
      child:
          widget.customTitle ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style:
                    widget.textStyle ??
                    theme.textTheme.titleMedium?.copyWith(
                      color: isActive ? activeColor : colorScheme.onSurface,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    ),
              ),
              if (widget.showCaret) ...[
                const SizedBox(width: 4),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0,
                  duration: widget.animationDuration,
                  curve: widget.animationCurve,
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 18,
                    color: isActive ? activeColor : colorScheme.onSurface,
                  ),
                ),
              ],
            ],
          ),
    );
  }

  Widget _buildDropdownMenu(
    ThemeData theme,
    ColorScheme colorScheme,
    Color backgroundColor,
  ) {
    return Positioned(
      top: 50, // Adjust based on your navbar height
      left: 0,
      child: CompositedTransformFollower(
        link: _layerLink,
        showWhenUnlinked: false,
        offset: const Offset(0, 0),
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: widget.dropdownWidth,
            constraints: BoxConstraints(
              maxHeight: widget.maxDropdownHeight ?? 300,
            ),
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius:
                  widget.dropdownBorderRadius ?? BorderRadius.circular(12),
              boxShadow: widget.customShadow ?? _getBoxShadow(theme),
            ),
            child: ClipRRect(
              borderRadius:
                  widget.dropdownBorderRadius ?? BorderRadius.circular(12),
              child: AnimatedOpacity(
                opacity: _isExpanded || _isHovered ? 1.0 : 0.0,
                duration: widget.animationDuration,
                curve: widget.animationCurve,
                child: _buildDropdownContent(theme, colorScheme),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownContent(ThemeData theme, ColorScheme colorScheme) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.items.map((item) {
          if (item.isDivider) {
            return Divider(
              height: 1,
              thickness: 0.5,
              color: theme.dividerColor,
            );
          }

          if (item.isHeader) {
            return Container(
              padding:
                  widget.itemPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: colorScheme.surfaceVariant),
              child: Text(
                item.label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          return _buildDropdownItem(item, theme, colorScheme);
        }).toList(),
      ),
    );
  }

  Widget _buildDropdownItem(
    SkNavbarDropdownItem item,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Material(
      color: item.backgroundColor ?? Colors.transparent,
      child: InkWell(
        onTap: () => _handleItemTap(item),
        hoverColor: widget.hoverColor ?? colorScheme.primary,
        splashColor: colorScheme.primary,
        child: Container(
          padding:
              widget.itemPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              if (item.icon != null) ...[
                Icon(
                  item.icon,
                  size: 18,
                  color: item.iconColor ?? colorScheme.onSurface,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  item.label,
                  style:
                      widget.dropdownTextStyle ??
                      theme.textTheme.bodyMedium?.copyWith(
                        color: item.textColor ?? colorScheme.onSurface,
                      ),
                ),
              ),
              if (item.trailing != null) ...[
                const SizedBox(width: 8),
                item.trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius? _getTitleBorderRadius() {
    switch (widget.style) {
      case SkNavbarDropdownStyle.standard:
        return null;
      case SkNavbarDropdownStyle.rounded:
        return BorderRadius.circular(8);
      case SkNavbarDropdownStyle.pill:
        return BorderRadius.circular(20);
    }
  }

  List<BoxShadow> _getBoxShadow(ThemeData theme) {
    switch (widget.style) {
      case SkNavbarDropdownStyle.standard:
        return [
          BoxShadow(
            color: theme.shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ];
      case SkNavbarDropdownStyle.rounded:
        return [
          BoxShadow(
            color: theme.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ];
      case SkNavbarDropdownStyle.pill:
        return [
          BoxShadow(
            color: theme.shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ];
    }
  }
}

enum SkNavbarDropdownStyle { standard, rounded, pill }

// Pre-built dropdown variations
class SkNavbarDropdownVariations {
  static Widget rounded({
    required String title,
    required List<SkNavbarDropdownItem> items,
    required BuildContext context,
    Color? backgroundColor,
  }) {
    return SkNavbarDropdown(
      title: title,
      items: items,
      style: SkNavbarDropdownStyle.rounded,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      dropdownBorderRadius: BorderRadius.circular(12),
    );
  }

  static Widget pill({
    required String title,
    required List<SkNavbarDropdownItem> items,
    required BuildContext context,
  }) {
    return SkNavbarDropdown(
      title: title,
      items: items,
      style: SkNavbarDropdownStyle.pill,
      backgroundColor: Theme.of(context).colorScheme.surface,
      dropdownBorderRadius: BorderRadius.circular(20),
    );
  }

  static Widget dark({
    required String title,
    required List<SkNavbarDropdownItem> items,
  }) {
    return SkNavbarDropdown(
      title: title,
      items: items,
      backgroundColor: Colors.grey.shade900,
      textStyle: const TextStyle(color: Colors.white),
      dropdownTextStyle: const TextStyle(color: Colors.white),
      customShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static Widget withIcons({
    required String title,
    required List<SkNavbarDropdownItem> items,
    required BuildContext context,
  }) {
    return SkNavbarDropdown(
      title: title,
      items: items,
      backgroundColor: Theme.of(context).colorScheme.surface,
      dropdownWidth: 220,
      itemPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    );
  }
}

// Utility methods for common dropdown patterns
class SkNavbarDropdownUtils {
  static List<SkNavbarDropdownItem> createUserMenu({
    required String userName,
    required String userEmail,
    required VoidCallback onProfile,
    required VoidCallback onSettings,
    required VoidCallback onLogout,
  }) {
    return [
      SkNavbarDropdownItem.header(label: 'Account'),
      SkNavbarDropdownItem(
        label: userName,
        onTap: onProfile,
        icon: Icons.person,
      ),
      SkNavbarDropdownItem(
        label: userEmail,
        onTap: () {},
        icon: Icons.email,
        textColor: Colors.grey.shade600,
      ),
      SkNavbarDropdownItem.divider(),
      SkNavbarDropdownItem(
        label: 'Profile Settings',
        onTap: onSettings,
        icon: Icons.settings,
      ),
      SkNavbarDropdownItem.divider(),
      SkNavbarDropdownItem(
        label: 'Logout',
        onTap: onLogout,
        icon: Icons.logout,
        textColor: Colors.red.shade600,
        iconColor: Colors.red.shade600,
      ),
    ];
  }

  static List<SkNavbarDropdownItem> createNotificationMenu({
    required int notificationCount,
    required VoidCallback onViewAll,
    required List<String> recentNotifications,
  }) {
    final items = <SkNavbarDropdownItem>[
      SkNavbarDropdownItem.header(label: 'Notifications ($notificationCount)'),
    ];

    // Add recent notifications
    for (final notification in recentNotifications.take(3)) {
      items.add(
        SkNavbarDropdownItem(
          label: notification,
          onTap: () {},
          icon: Icons.notifications_none,
        ),
      );
    }

    items.addAll([
      SkNavbarDropdownItem.divider(),
      SkNavbarDropdownItem(
        label: 'View All Notifications',
        onTap: onViewAll,
        icon: Icons.list_alt,
      ),
    ]);

    return items;
  }

  static List<SkNavbarDropdownItem> createThemeMenu({
    required VoidCallback onLightTheme,
    required VoidCallback onDarkTheme,
    required VoidCallback onSystemTheme,
    String currentTheme = 'Light',
  }) {
    return [
      SkNavbarDropdownItem.header(label: 'Theme'),
      SkNavbarDropdownItem(
        label: 'Light Theme',
        onTap: onLightTheme,
        icon: Icons.light_mode,
        trailing: currentTheme == 'Light'
            ? const Icon(Icons.check, size: 16)
            : null,
      ),
      SkNavbarDropdownItem(
        label: 'Dark Theme',
        onTap: onDarkTheme,
        icon: Icons.dark_mode,
        trailing: currentTheme == 'Dark'
            ? const Icon(Icons.check, size: 16)
            : null,
      ),
      SkNavbarDropdownItem(
        label: 'System Default',
        onTap: onSystemTheme,
        icon: Icons.settings_suggest,
        trailing: currentTheme == 'System'
            ? const Icon(Icons.check, size: 16)
            : null,
      ),
    ];
  }
}

// Usage Examples:
/*
// 1. Basic Dropdown
SkNavbarDropdown(
  title: 'Products',
  items: [
    SkNavbarDropdownItem(label: 'Web App', onTap: () {}),
    SkNavbarDropdownItem(label: 'Mobile App', onTap: () {}),
    SkNavbarDropdownItem(label: 'Desktop App', onTap: () {}),
  ],
)

// 2. Dropdown with Icons and Dividers
SkNavbarDropdown(
  title: 'Account',
  items: SkNavbarDropdownUtils.createUserMenu(
    userName: 'John Doe',
    userEmail: 'john@example.com',
    onProfile: () {},
    onSettings: () {},
    onLogout: () {},
  ),
)

// 3. Rounded Style
SkNavbarDropdownVariations.rounded(
  title: 'Settings',
  items: [...],
  context: context,
)

// 4. Notification Dropdown
SkNavbarDropdown(
  title: 'Notifications',
  items: SkNavbarDropdownUtils.createNotificationMenu(
    notificationCount: 5,
    onViewAll: () {},
    recentNotifications: [
      'New message from Sarah',
      'Your order has shipped',
      'Meeting reminder at 2 PM',
    ],
  ),
)

// 5. Custom Styled Dropdown
SkNavbarDropdown(
  title: 'Themes',
  items: SkNavbarDropdownUtils.createThemeMenu(
    onLightTheme: () {},
    onDarkTheme: () {},
    onSystemTheme: () {},
    currentTheme: 'Light',
  ),
  style: SkNavbarDropdownStyle.pill,
  showCaret: false,
  customTitle: Row(
    children: [
      Icon(Icons.palette, size: 18),
      SizedBox(width: 8),
      Text('Themes'),
    ],
  ),
)
*/
