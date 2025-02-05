import 'package:flutter/material.dart';

class FilterChips extends StatefulWidget {
  const FilterChips({super.key});

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  final List<String> filters = [
    'Com desconto',
    'Disponíveis',
    'Hidro',
    'Piscina',
  ];

  Set<String> selectedFilters = {};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: filters.map((filter) {
        return FilterChip(
          label: Text(filter),
          selected: selectedFilters.contains(filter),
          onSelected: (selected) {
            setState(() {
              selectedFilters.contains(filter)
                  ? selectedFilters.remove(filter)
                  : selectedFilters.add(filter);
            });
          },
        );
      }).toList(),
    );
  }
}
