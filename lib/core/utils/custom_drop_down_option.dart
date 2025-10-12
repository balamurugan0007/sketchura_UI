import 'package:flutter/material.dart';

class SkDropDownListMenu extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final double? w;
  final double? h;
  final List<String> menus;

  final Widget? child;
  final String? hintText;

  const SkDropDownListMenu({
    super.key,
    required this.onChanged,
    this.h,
    this.w,
    required this.menus,

    this.child,
    this.hintText,
  });

  @override
  State<SkDropDownListMenu> createState() => _SkDropDownListMenuState();
}

class _SkDropDownListMenuState extends State<SkDropDownListMenu> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.w ?? 150,
      height: widget.h ?? 45,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (widget.child != null) widget.child! else const SizedBox(width: 4),
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: TextSelectionTheme(
                data: const TextSelectionThemeData(
                  selectionColor:
                      Colors.transparent, // removes background highlight
                  selectionHandleColor:
                      Colors.transparent, // hides drag handles
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text(
                      widget.hintText ?? 'Select',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                    ),
                    value: selectedValue,
                    items: widget.menus.map((menu) {
                      bool isSelected = menu == selectedValue;
                      return DropdownMenuItem(
                        value: menu,
                        child: Text(
                          menu,
                          style: TextStyle(
                            color: isSelected ? Colors.blue : Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                      if (value != null) widget.onChanged(value);
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: selectedValue == null ? Colors.black : Colors.blue,
                    ),
                    isExpanded: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//dropdown with customChild get widget next

class SkDropDownList extends StatefulWidget {
  final String label;
  final IconData? icon;
  final List<String> items;
  final ValueChanged<String> onSelected;
  final bool initiallyExpanded;

  const SkDropDownList({
    Key? key,
    required this.label,
    this.icon,
    required this.items,
    required this.onSelected,
    this.initiallyExpanded = false,
  }) : super(key: key);

  @override
  State<SkDropDownList> createState() => _SkDropDownListState();
}

class _SkDropDownListState extends State<SkDropDownList>
    with SingleTickerProviderStateMixin {
  late bool _expanded;
  late final AnimationController _controller;
  late final Animation<double> _rotateAnim;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _rotateAnim = Tween<double>(begin: 0.0, end: 0.5).animate(_controller);
    if (_expanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget _buildItem(String label) {
    return InkWell(
      onTap: () {
        widget.onSelected(label);
        // close after selection
        setState(() {
          _expanded = false;
          _controller.reverse();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(label, style: Theme.of(context).textTheme.bodySmall),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: _toggle,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              children: [
                if (widget.icon != null)
                  Icon(widget.icon, size: 20, color: cs.onSurface),
                if (widget.icon != null) const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.label,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                RotationTransition(
                  turns: _rotateAnim,
                  child: Icon(Icons.expand_more, size: 20, color: cs.onSurface),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Column(children: widget.items.map(_buildItem).toList()),
          crossFadeState: _expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 160),
        ),
      ],
    );
  }
}
