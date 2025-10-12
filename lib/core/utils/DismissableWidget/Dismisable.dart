import 'package:flutter/material.dart';
import 'package:sketchura_ui/constants/color_const.dart';

class SkDismissibleList<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final void Function(T item)? onDismissed;
  final Color backgroundColor;
  final IconData deleteIcon;
  final Color deleteIconColor;

  const SkDismissibleList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.onDismissed,
    this.backgroundColor = SkColors.error,
    this.deleteIcon = Icons.delete,
    this.deleteIconColor = Colors.white,
  });

  @override
  State<SkDismissibleList<T>> createState() => _SkDismissibleListState<T>();
}

class _SkDismissibleListState<T> extends State<SkDismissibleList<T>> {
  late List<T> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      return const Center(
        child: Text(
          "No items left!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      );
    }
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return Dismissible(
          key: ValueKey(item),
          background: Container(
            alignment: Alignment.centerLeft,
            color: widget.backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(widget.deleteIcon, color: widget.deleteIconColor),
          ),
          secondaryBackground: Container(
            alignment: Alignment.centerRight,
            color: widget.backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(widget.deleteIcon, color: widget.deleteIconColor),
          ),
          onDismissed: (direction) {
            setState(() {
              _items.removeAt(index);
            });
            widget.onDismissed?.call(item);
          },
          child: widget.itemBuilder(context, item),
        );
      },
    );
  }
}
