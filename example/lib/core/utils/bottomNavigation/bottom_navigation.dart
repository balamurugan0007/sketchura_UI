import 'package:flutter/material.dart';

/// A single navigation item used by [SkBottomNavigationBar].
class SkBottomNavItem {
  final Widget icon;
  final Widget? activeIcon;
  final String label;
  final int? badge; // null => no badge, 0 => show dot
  final Color? backgroundColor;

  const SkBottomNavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.badge,
    this.backgroundColor,
  });
}

/// A customizable, reusable bottom navigation bar.
/// - Supports badges (int? badge)
/// - Supports custom active icon
/// - Can be controlled (pass currentIndex + onTap) or uncontrolled (internal state)
class SkBottomNavigationBar extends StatefulWidget {
  final List<SkBottomNavItem> items;
  final int? currentIndex;
  final ValueChanged<int>? onTap;
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double elevation;
  final bool showLabels;
  final double height;
  final Duration animationDuration;

  const SkBottomNavigationBar({
    Key? key,
    required this.items,
    this.currentIndex,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.selectedItemColor = Colors.blue,
    this.unselectedItemColor = Colors.black54,
    this.elevation = 8.0,
    this.showLabels = true,
    this.height = 64.0,
    this.animationDuration = const Duration(milliseconds: 250),
  }) : assert(items.length >= 2),
       super(key: key);

  @override
  State<SkBottomNavigationBar> createState() => _SkBottomNavigationBarState();
}

class _SkBottomNavigationBarState extends State<SkBottomNavigationBar> {
  late int _currentIndex;

  bool get _isControlled => widget.currentIndex != null && widget.onTap != null;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex ?? 0;
  }

  @override
  void didUpdateWidget(covariant SkBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isControlled) {
      // keep local in sync when controlled externally
      _currentIndex = widget.currentIndex!;
    } else if (widget.currentIndex != null && widget.onTap != null) {
      // switched to controlled mode
      _currentIndex = widget.currentIndex!;
    }
  }

  void _handleTap(int index) {
    if (_isControlled) {
      widget.onTap?.call(index);
    } else {
      setState(() => _currentIndex = index);
      widget.onTap?.call(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation,
      color: widget.backgroundColor,
      child: SizedBox(
        height: widget.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.items.length, (i) {
            final item = widget.items[i];
            final selected = i == _currentIndex;
            final icon = selected ? (item.activeIcon ?? item.icon) : item.icon;

            return Expanded(
              child: InkWell(
                onTap: () => _handleTap(i),
                child: AnimatedContainer(
                  duration: widget.animationDuration,
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ),
                  color: item.backgroundColor?.withOpacity(
                    selected ? 0.08 : 0.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconTheme(
                            data: IconThemeData(
                              color: selected
                                  ? widget.selectedItemColor
                                  : widget.unselectedItemColor,
                              size: 24,
                            ),
                            child: icon,
                          ),
                          if (item.badge != null)
                            Positioned(
                              right: -6,
                              top: -6,
                              child: _Badge(value: item.badge),
                            ),
                        ],
                      ),
                      if (widget.showLabels) const SizedBox(height: 6),
                      if (widget.showLabels)
                        AnimatedDefaultTextStyle(
                          duration: widget.animationDuration,
                          style: TextStyle(
                            color: selected
                                ? widget.selectedItemColor
                                : widget.unselectedItemColor,
                            fontSize: 12,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                          child: Text(
                            item.label,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final int? value;
  const _Badge({this.value});

  @override
  Widget build(BuildContext context) {
    // value == 0 -> small dot
    if (value == 0) {
      return Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
        ),
      );
    }

    // show number (cap at 99+)
    final display = (value != null && value! > 99)
        ? '99+'
        : (value?.toString() ?? '');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Center(
        child: Text(
          display,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
