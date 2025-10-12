import 'package:flutter/material.dart';
import 'package:sketchura_ui/constants/color_const.dart';

class SkSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final Icon? icon;
  final TextStyle? hintTextstyle;
  final double? w;
  final Color? backgroundColor;
  final double? h;
  final double? radious;

  const SkSearchBar({
    Key? key,
    required this.onChanged,
    this.hintText = 'Search',
    this.icon,
    this.hintTextstyle,
    this.w,
    this.backgroundColor,
    this.h,
    this.radious,
  }) : super(key: key);

  @override
  _SkSearchBarState createState() => _SkSearchBarState();
}

class _SkSearchBarState extends State<SkSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: widget.h ?? 50,
      width: widget.w ?? double.maxFinite,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? SkColors.lightMedium,
        borderRadius: BorderRadius.circular(widget.radious ?? 24),

        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          widget.icon ?? const Icon(Icons.search, color: SkColors.darkDark),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,

              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                hintStyle:
                    widget.hintTextstyle ?? TextTheme.of(context).bodySmall,
              ),
              style: TextTheme.of(context).bodySmall,
            ),
          ),
          if (_controller.text.isNotEmpty)
            GestureDetector(
              onTap: _clearSearch,
              child: const Icon(Icons.clear, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}

///=========================================================================================================================
///========================================================================================================================
///======================================================================================================================
class SkSearchWithFilteredList<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemText;
  final ValueChanged<List<T>>? onFilteredItems;
  final ValueChanged<T>? onItemSelected;
  final Widget Function(T)? itemBuilder;
  final String hintText;
  final Icon? icon;
  final TextStyle? hintTextStyle;
  final double? width;
  final Color? backgroundColor;
  final double? height;
  final double? radius;

  const SkSearchWithFilteredList({
    Key? key,
    required this.items,
    required this.itemText,
    this.onFilteredItems,
    this.onItemSelected,
    this.itemBuilder,
    this.hintText = 'Search',
    this.icon,
    this.hintTextStyle,
    this.width,
    this.backgroundColor,
    this.height,
    this.radius,
  }) : super(key: key);

  @override
  State<SkSearchWithFilteredList<T>> createState() =>
      _SkSearchWithFilteredListState<T>();
}

class _SkSearchWithFilteredListState<T>
    extends State<SkSearchWithFilteredList<T>> {
  late TextEditingController _controller;
  late List<T> _filteredItems;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _filteredItems = List.from(widget.items);
    _notifyParent();
  }

  void _notifyParent() {
    if (widget.onFilteredItems != null) {
      widget.onFilteredItems!(_filteredItems);
    }
  }

  void _filterItems() {
    final query = _controller.text.toLowerCase().trim();

    setState(() {
      if (query.isEmpty) {
        _filteredItems = List.from(widget.items);
      } else {
        _filteredItems = widget.items.where((item) {
          return widget.itemText(item).toLowerCase().contains(query);
        }).toList();
      }
      _notifyParent();
    });
  }

  void _clearSearch() {
    _controller.clear();
    _filterItems();
  }

  void _onItemSelected(T item) {
    // Set the selected item's text in the search bar
    _controller.text = widget.itemText(item);

    // Notify parent about selection
    if (widget.onItemSelected != null) {
      widget.onItemSelected!(item);
    }

    // Clear the filtered list to show all items or keep the selection visible
    setState(() {
      _filteredItems = [
        item,
      ]; // Show only selected item, or use below line to show all
      // _filteredItems = List.from(widget.items); // Show all items after selection
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        _buildSearchBar(),
        const SizedBox(height: 8),

        // Results Count
        _buildResultsCount(),

        // Results List
        _buildResultsList(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: widget.height ?? 50,
      width: widget.width ?? double.infinity,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? _getDefaultBackgroundColor(),
        borderRadius: BorderRadius.circular(widget.radius ?? 24),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          widget.icon ?? const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (value) => _filterItems(),
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                hintStyle:
                    widget.hintTextStyle ?? _getDefaultTextStyle(context),
              ),
              style: _getDefaultTextStyle(context),
            ),
          ),
          if (_controller.text.isNotEmpty)
            IconButton(
              onPressed: _clearSearch,
              icon: const Icon(Icons.clear, color: Colors.grey, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }

  Widget _buildResultsCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            'Found ${_filteredItems.length} items',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    return Expanded(
      child: _filteredItems.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return widget.itemBuilder != null
                    ? GestureDetector(
                        onTap: () => _onItemSelected(item),
                        child: widget.itemBuilder!(item),
                      )
                    : _buildDefaultItem(item);
              },
            ),
    );
  }

  Widget _buildDefaultItem(T item) {
    return GestureDetector(
      onTap: () => _onItemSelected(item),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          title: Text(widget.itemText(item)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No items found',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your search',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Color _getDefaultBackgroundColor() {
    return Colors.grey[100] ?? const Color(0xFFF5F5F5);
  }

  TextStyle _getDefaultTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
  }
}


//Usage example
//  SizedBox(
//               height: 500,
//               width: 400,
//               child: SkSearchWithFilteredList<Product>(
//                 items: _products,
//                 itemText: (product) => product.name,
//                 itemBuilder: (product) => Card(
//                   margin: const EdgeInsets.all(8),
//                   child: ListTile(
//                     title: Text(product.name),
//                     subtitle: Text('${product.category} - \$${product.price}'),
//                     leading: CircleAvatar(child: Text(product.name[0])),
//                   ),
//                 ),
//                 icon: Icon(Icons.settings),
//                 hintText: 'Search products...',
//               ),
//             ),
       



