import 'package:flutter/material.dart';

class SkSimpleAnimatedSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;
  final String hintText;

  const SkSimpleAnimatedSearchBar({
    Key? key,
    required this.onSearchChanged,
    this.hintText = 'Search...',
  }) : super(key: key);

  @override
  _SkSimpleAnimatedSearchBarState createState() =>
      _SkSimpleAnimatedSearchBarState();
}

class _SkSimpleAnimatedSearchBarState extends State<SkSimpleAnimatedSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isExpanded = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _isExpanded ? MediaQuery.of(context).size.width - 32 : 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(_isExpanded ? Icons.arrow_back : Icons.search),
            onPressed: () {
              if (_isExpanded) {
                _focusNode.unfocus();
                _controller.clear();
                widget.onSearchChanged('');
              } else {
                _focusNode.requestFocus();
              }
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: widget.onSearchChanged,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          _controller.clear();
                          widget.onSearchChanged('');
                        },
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//====================================================================================================
//===============================================================================================
//slide search bar

class SkSlideInSearchBar extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClosed;

  const SkSlideInSearchBar({
    super.key,
    this.hintText = "Search...",
    this.onChanged,
    this.onClosed,
  });

  @override
  State<SkSlideInSearchBar> createState() => _SkSlideInSearchBarState();
}

class _SkSlideInSearchBarState extends State<SkSlideInSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  final TextEditingController _searchController = TextEditingController();
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _toggleSearch() {
    setState(() {
      _isVisible = !_isVisible;
      if (_isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
        _searchController.clear();
        if (widget.onClosed != null) widget.onClosed!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              if (_isVisible)
                SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: widget.onChanged,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: _toggleSearch,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        IconButton(icon: const Icon(Icons.search), onPressed: _toggleSearch),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }
}

///==================================================================================================
///==================================================================
///========================================================================================
///
///SkBouncingsearchbar

class SkBouncingSearchBar extends StatefulWidget {
  @override
  _SkBouncingSearchBarState createState() => _SkBouncingSearchBarState();
}

class _SkBouncingSearchBarState extends State<SkBouncingSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final TextEditingController _searchController = TextEditingController();
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  void _activateSearch() {
    setState(() {
      _isActive = true;
      _controller.forward();
    });
  }

  void _deactivateSearch() {
    setState(() {
      _isActive = false;
      _controller.reverse();
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: _isActive ? MediaQuery.of(context).size.width * 0.9 : 200,
      child: Stack(
        children: [
          if (_isActive)
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Search...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: _deactivateSearch,
                    ),
                  ],
                ),
              ),
            ),
          if (!_isActive)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                leading: Icon(Icons.search, color: Colors.grey),
                title: Text("Search", style: TextStyle(color: Colors.grey)),
                onTap: _activateSearch,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

////=================================================================================================================
///=====================================================================================================================
///========================================================================================================================
///Floating Seach bar

class SkFloatingFilterSearchBar extends StatefulWidget {
  @override
  _SkFloatingFilterSearchBarState createState() =>
      _SkFloatingFilterSearchBarState();
}

class _SkFloatingFilterSearchBarState extends State<SkFloatingFilterSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  List<String> _suggestions = [
    "Flutter Tutorial",
    "Dart Programming",
    "UI Design",
    "Animation Examples",
    "Mobile Development",
  ];
  List<String> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
    _focusNode.addListener(_onFocusChanged);
    _filteredSuggestions = _suggestions;
  }

  void _onFocusChanged() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  void _onSearchChanged() {
    final query = _controller.text.toLowerCase();
    setState(() {
      _filteredSuggestions = _suggestions
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: _hasFocus
                ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: "Search with suggestions...",
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        _controller.clear();
                        _filteredSuggestions = _suggestions;
                      },
                    )
                  : null,
            ),
          ),
        ),
        if (_hasFocus && _filteredSuggestions.isNotEmpty)
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: _filteredSuggestions
                  .map(
                    (suggestion) => ListTile(
                      leading: Icon(Icons.search, color: Colors.grey),
                      title: Text(suggestion),
                      onTap: () {
                        _controller.text = suggestion;
                        _focusNode.unfocus();
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
