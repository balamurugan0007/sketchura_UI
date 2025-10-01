import 'package:flutter/material.dart';

class SkAccordion extends StatefulWidget {
  final String title;
  final Widget content;
  final bool initiallyExpanded;
  final TextStyle? titleStyle;
  final Color? headerColor;
  final Color? borderColor;
  final Color? iconColor;
  final double borderRadius;
  final double? w;

  const SkAccordion({
    Key? key,
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
    this.titleStyle,
    this.headerColor,
    this.borderColor,
    this.iconColor,
    this.borderRadius = 12,
    this.w,
  }) : super(key: key);

  @override
  State<SkAccordion> createState() => _SkAccordionState();
}

class _SkAccordionState extends State<SkAccordion>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _controller;
  late Animation<double> _arrowAnimation;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _arrowAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    if (_isExpanded) {
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final borderClr = widget.borderColor ?? Colors.grey.shade300;
    final headerClr = widget.headerColor ?? Colors.white;
    final iconClr = widget.iconColor ?? Theme.of(context).primaryColor;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: widget.w ?? 200,
      decoration: BoxDecoration(
        border: Border.all(color: borderClr, width: 1),
        borderRadius: BorderRadius.circular(widget.borderRadius),

        boxShadow: [
          if (_isExpanded)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _toggleExpanded,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
              decoration: BoxDecoration(
                color: headerClr,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style:
                          widget.titleStyle ??
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                    ),
                  ),
                  RotationTransition(
                    turns: _arrowAnimation,
                    child: Icon(Icons.expand_more, color: iconClr, size: 26),
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: _expandAnimation,
            axisAlignment: 1.0,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(widget.borderRadius),
                  bottomRight: Radius.circular(widget.borderRadius),
                ),
              ),
              child: widget.content,
            ),
          ),
        ],
      ),
    );
  }
}
