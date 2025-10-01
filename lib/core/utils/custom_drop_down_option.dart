import 'package:flutter/material.dart';

class SkDropDownMenu extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final double? w;
  final double? h;
  final List<String> menus;

  final Widget? child;
  final String? hintText;

  const SkDropDownMenu({
    super.key,
    required this.onChanged,
    this.h,
    this.w,
    required this.menus,

    this.child,
    this.hintText,
  });

  @override
  State<SkDropDownMenu> createState() => _SkDropDownMenuState();
}

class _SkDropDownMenuState extends State<SkDropDownMenu> {
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