import 'package:flutter/material.dart';

class SkTabs extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> tabViews;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final bool isScrollable;
  final double? height;
  final double indicatorWeight;
  final TabAlignment alignment;
  final SkTabStyle style;
  final Color? backgroundColor;
  final double elevation;
  final EdgeInsetsGeometry tabPadding;
  final TextStyle? labelTextStyle;
  final TextStyle? unselectedLabelTextStyle;
  final Decoration? indicatorDecoration;
  final bool showBorder;
  final Color? borderColor;
  final double borderRadius;
  final Gradient? indicatorGradient;
  final Widget? leading;
  final Widget? trailing;
  final bool centerTabs;
  final double tabSpacing;
  final Color? splashColor;
  final Color? highlightColor;
  final MaterialStateProperty<Color?>? overlayColor;

  const SkTabs({
    Key? key,
    required this.tabs,
    required this.tabViews,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.isScrollable = false,
    this.height,
    this.indicatorWeight = 3,
    this.alignment = TabAlignment.start,
    this.style = SkTabStyle.standard,
    this.backgroundColor,
    this.elevation = 2,
    this.tabPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.labelTextStyle,
    this.unselectedLabelTextStyle,
    this.indicatorDecoration,
    this.showBorder = false,
    this.borderColor,
    this.borderRadius = 0,
    this.indicatorGradient,
    this.leading,
    this.trailing,
    this.centerTabs = false,
    this.tabSpacing = 8,
    this.splashColor,
    this.highlightColor,
    this.overlayColor,
  }) : super(key: key);

  @override
  State<SkTabs> createState() => _SkTabsState();
}

class _SkTabsState extends State<SkTabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final validAlignment = widget.isScrollable
        ? widget.alignment
        : (widget.centerTabs ? TabAlignment.center : TabAlignment.fill);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Custom Tab Bar with leading and trailing
        _buildTabBar(theme, colorScheme, validAlignment),

        // Tab Content
        _buildTabContent(),
      ],
    );
  }

  Widget _buildTabBar(
    ThemeData theme,
    ColorScheme colorScheme,
    TabAlignment alignment,
  ) {
    return Material(
      color: _getBackgroundColor(theme, colorScheme),
      elevation: _getElevation(),
      shape: _getShape(),
      child: Container(
        decoration: _getContainerDecoration(theme, colorScheme),
        padding: _getTabBarPadding(),
        child: Row(
          children: [
            if (widget.leading != null) ...[
              widget.leading!,
              SizedBox(width: widget.tabSpacing),
            ],

            Expanded(
              child: TabBar(
                controller: _tabController,
                isScrollable: widget.isScrollable,
                labelColor: _getLabelColor(theme, colorScheme),
                unselectedLabelColor: _getUnselectedLabelColor(
                  theme,
                  colorScheme,
                ),
                indicatorColor: _getIndicatorColor(theme, colorScheme),
                indicatorWeight: _getIndicatorWeight(),
                indicator: _getIndicator(theme, colorScheme),
                indicatorPadding: _getIndicatorPadding(),
                labelPadding: _getLabelPadding(),
                tabAlignment: alignment,
                splashFactory: _getSplashFactory(),
                overlayColor: widget.overlayColor,
                dividerColor: Colors.transparent,
                tabs: _buildTabs(theme, colorScheme),
              ),
            ),

            if (widget.trailing != null) ...[
              SizedBox(width: widget.tabSpacing),
              widget.trailing!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return SizedBox(
      height: widget.height ?? 400,
      child: TabBarView(controller: _tabController, children: widget.tabViews),
    );
  }

  List<Widget> _buildTabs(ThemeData theme, ColorScheme colorScheme) {
    return widget.tabs
        .map(
          (tab) => Tab(
            child: Container(
              padding: widget.tabPadding,
              child: Text(
                tab,
                style: _getLabelTextStyle(theme, colorScheme),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
        .toList();
  }

  // Style-specific getters
  Color _getBackgroundColor(ThemeData theme, ColorScheme colorScheme) {
    if (widget.backgroundColor != null) return widget.backgroundColor!;

    switch (widget.style) {
      case SkTabStyle.standard:
        return colorScheme.surface;
      case SkTabStyle.light:
        return Colors.transparent;
      case SkTabStyle.dark:
        return colorScheme.surface;
      case SkTabStyle.pill:
        return Colors.grey.shade100;
      case SkTabStyle.outlined:
        return Colors.transparent;
      case SkTabStyle.floating:
        return theme.cardColor;
    }
  }

  Color _getLabelColor(ThemeData theme, ColorScheme colorScheme) {
    if (widget.labelColor != null) return widget.labelColor!;

    switch (widget.style) {
      case SkTabStyle.standard:
        return colorScheme.primary;
      case SkTabStyle.light:
        return colorScheme.onSurface;
      case SkTabStyle.dark:
        return Colors.white;
      case SkTabStyle.pill:
        return colorScheme.primary;
      case SkTabStyle.outlined:
        return colorScheme.primary;
      case SkTabStyle.floating:
        return colorScheme.primary;
    }
  }

  Color _getUnselectedLabelColor(ThemeData theme, ColorScheme colorScheme) {
    if (widget.unselectedLabelColor != null)
      return widget.unselectedLabelColor!;

    switch (widget.style) {
      case SkTabStyle.standard:
        return colorScheme.onSurface.withOpacity(0.6);
      case SkTabStyle.light:
        return colorScheme.onSurface.withOpacity(0.5);
      case SkTabStyle.dark:
        return Colors.white70;
      case SkTabStyle.pill:
        return colorScheme.onSurface.withOpacity(0.6);
      case SkTabStyle.outlined:
        return colorScheme.onSurface.withOpacity(0.6);
      case SkTabStyle.floating:
        return colorScheme.onSurface.withOpacity(0.6);
    }
  }

  Color? _getIndicatorColor(ThemeData theme, ColorScheme colorScheme) {
    if (widget.indicatorColor != null) return widget.indicatorColor;

    switch (widget.style) {
      case SkTabStyle.standard:
        return colorScheme.primary;
      case SkTabStyle.light:
        return colorScheme.primary;
      case SkTabStyle.dark:
        return Colors.white;
      case SkTabStyle.pill:
        return Colors.transparent;
      case SkTabStyle.outlined:
        return colorScheme.primary;
      case SkTabStyle.floating:
        return colorScheme.primary;
    }
  }

  double _getIndicatorWeight() {
    switch (widget.style) {
      case SkTabStyle.pill:
        return 0;
      default:
        return widget.indicatorWeight;
    }
  }

  Decoration? _getIndicator(ThemeData theme, ColorScheme colorScheme) {
    if (widget.indicatorDecoration != null) return widget.indicatorDecoration;

    switch (widget.style) {
      case SkTabStyle.pill:
        return ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: colorScheme.primary.withOpacity(0.1),
        );
      case SkTabStyle.outlined:
        return UnderlineTabIndicator(
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: widget.indicatorWeight,
          ),
          insets: const EdgeInsets.symmetric(horizontal: 16),
        );
      default:
        return null;
    }
  }

  EdgeInsetsGeometry _getIndicatorPadding() {
    switch (widget.style) {
      case SkTabStyle.pill:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      default:
        return EdgeInsets.zero;
    }
  }

  EdgeInsetsGeometry? _getLabelPadding() {
    switch (widget.style) {
      case SkTabStyle.pill:
        return const EdgeInsets.symmetric(horizontal: 8);
      default:
        return null;
    }
  }

  double _getElevation() {
    switch (widget.style) {
      case SkTabStyle.floating:
        return 4;
      case SkTabStyle.light:
      case SkTabStyle.outlined:
        return 0;
      default:
        return widget.elevation;
    }
  }

  ShapeBorder? _getShape() {
    switch (widget.style) {
      case SkTabStyle.floating:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
      default:
        return null;
    }
  }

  Decoration? _getContainerDecoration(
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    if (widget.showBorder) {
      return BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: widget.borderColor ?? colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
      );
    }

    switch (widget.style) {
      case SkTabStyle.outlined:
        return BoxDecoration(
          border: Border.all(
            color: widget.borderColor ?? colorScheme.outline.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        );
      default:
        return null;
    }
  }

  EdgeInsetsGeometry _getTabBarPadding() {
    switch (widget.style) {
      case SkTabStyle.floating:
        return const EdgeInsets.all(8);
      case SkTabStyle.pill:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      default:
        return EdgeInsets.zero;
    }
  }

  TextStyle _getLabelTextStyle(ThemeData theme, ColorScheme colorScheme) {
    final baseStyle = widget.labelTextStyle ?? theme.textTheme.labelLarge;

    switch (widget.style) {
      case SkTabStyle.pill:
        return baseStyle?.copyWith(fontWeight: FontWeight.w600, fontSize: 14) ??
            const TextStyle(fontWeight: FontWeight.w600);
      default:
        return baseStyle?.copyWith(fontWeight: FontWeight.w600) ??
            const TextStyle(fontWeight: FontWeight.w600);
    }
  }

  InteractiveInkFeatureFactory? _getSplashFactory() {
    switch (widget.style) {
      case SkTabStyle.pill:
        return NoSplash.splashFactory;
      default:
        return null;
    }
  }
}

enum SkTabStyle { standard, light, dark, pill, outlined, floating }

// Pre-styled tab variations for quick use
class SkTabVariations {
  static Widget pill({
    required List<String> tabs,
    required List<Widget> tabViews,
    Color? activeColor,
    required BuildContext context,
    double? height,
  }) => SkTabs(
    tabs: tabs,
    tabViews: tabViews,
    style: SkTabStyle.pill,
    height: height,
    labelColor: activeColor ?? Theme.of(context).colorScheme.primary,
    backgroundColor: Colors.transparent,
  );

  static Widget floating({
    required List<String> tabs,
    required List<Widget> tabViews,
    required BuildContext context,
    double? height,
  }) => SkTabs(
    tabs: tabs,
    tabViews: tabViews,
    style: SkTabStyle.floating,
    height: height,
    backgroundColor: Theme.of(context).cardColor,
  );

  static Widget outlined({
    required List<String> tabs,
    required List<Widget> tabViews,
    required BuildContext context,
    double? height,
  }) => SkTabs(
    tabs: tabs,
    tabViews: tabViews,
    style: SkTabStyle.outlined,
    height: height,
    borderRadius: 8,
    borderColor: Theme.of(context).colorScheme.outline,
  );

  static Widget light({
    required List<String> tabs,
    required List<Widget> tabViews,
    double? height,
  }) => SkTabs(
    tabs: tabs,
    tabViews: tabViews,
    style: SkTabStyle.light,
    height: height,
    elevation: 0,
    indicatorWeight: 2,
  );
}

// Usage Examples:
/*
// 1. Standard Tabs
SkTabs(
  tabs: ['Tab 1', 'Tab 2', 'Tab 3'],
  tabViews: [Widget1(), Widget2(), Widget3()],
  style: SkTabStyle.standard,
)

// 2. Pill Tabs
SkTabs(
  tabs: ['Profile', 'Settings', 'Billing'],
  tabViews: [ProfileView(), SettingsView(), BillingView()],
  style: SkTabStyle.pill,
)

// 3. Floating Tabs
SkTabs(
  tabs: ['Messages', 'Notifications'],
  tabViews: [MessagesView(), NotificationsView()],
  style: SkTabStyle.floating,
)

// 4. Outlined Tabs
SkTabs(
  tabs: ['Active', 'Completed', 'Archived'],
  tabViews: [ActiveView(), CompletedView(), ArchivedView()],
  style: SkTabStyle.outlined,
)

// 5. Quick variations
SkTabVariations.pill(
  tabs: ['Tab 1', 'Tab 2'],
  tabViews: [View1(), View2()],
  context: context,
)

SkTabVariations.floating(
  tabs: ['Tab 1', 'Tab 2'],
  tabViews: [View1(), View2()],
  context: context,
)
*/
