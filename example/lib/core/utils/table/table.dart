import 'package:flutter/material.dart';

class SkSimpleGlobalTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final double? columnSpacing;
  final double horizontalMargin;
  final Color? headerBackgroundColor;
  final Color? rowBackgroundColor;
  final bool showBorder;
  final double borderRadius;

  const SkSimpleGlobalTable({
    Key? key,
    required this.data,
    this.columnSpacing = 24,
    this.horizontalMargin = 16,
    this.headerBackgroundColor,
    this.rowBackgroundColor,
    this.showBorder = true,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return _buildEmptyState();
    }

    final columns = data.first.keys.toList();
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: showBorder
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: Colors.grey.shade300),
            )
          : null,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(
            headerBackgroundColor ?? colorScheme.primary,
          ),
          dataRowColor: _getRowColor(colorScheme),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          columnSpacing: columnSpacing,
          horizontalMargin: horizontalMargin,
          headingTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
            fontSize: 14,
          ),
          dataTextStyle: const TextStyle(fontSize: 13, color: Colors.black87),
          columns: _buildColumns(columns),
          rows: _buildRows(columns),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'No data available',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  MaterialStateProperty<Color?> _getRowColor(ColorScheme colorScheme) {
    return MaterialStateProperty.resolveWith((states) {
      if (rowBackgroundColor != null) return rowBackgroundColor;
      return states.contains(MaterialState.selected)
          ? colorScheme.primary
          : null;
    });
  }

  List<DataColumn> _buildColumns(List<String> columns) {
    return columns
        .map(
          (key) => DataColumn(
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                _formatHeader(key),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        )
        .toList();
  }

  List<DataRow> _buildRows(List<String> columns) {
    return data
        .map(
          (row) => DataRow(
            cells: columns
                .map(
                  (col) => DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        row[col]?.toString() ?? '-',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  String _formatHeader(String header) {
    final formatted = header.replaceAllMapped(
      RegExp(r'(_|(?<=[a-z])[A-Z])'),
      (match) => ' ',
    );
    return formatted
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? ''
              : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}
