import 'package:flutter/material.dart';
import 'package:guia_de_moteis_teste/widgets/toggle_buttom.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  final ValueChanged<bool> onToggleChanged;

  const CustomAppBar({
    super.key,
    required this.onMenuPressed,
    required this.onToggleChanged,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String _selectedValue = 'ir agora';
  void _onSelectionChanged(Set<String> newSelection) {
    setState(() {
      _selectedValue = newSelection.first;
    });
    widget.onToggleChanged(_selectedValue == 'ir agora');
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.menu,
            size: 30,
            color: Colors.white,
          ),
          onPressed: widget.onMenuPressed,
        ),
      ),
      title: SegmentedButton<String>(
        segments: const <ButtonSegment<String>>[
          ButtonSegment(
            value: 'ir agora',
            label: Text('Ir Agora'),
          ),
          ButtonSegment(
            value: 'ir outro dia',
            label: Text('Outro Dia'),
          ),
        ],
        selected: {_selectedValue},
        showSelectedIcon: false,
        onSelectionChanged: _onSelectionChanged,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return Colors.red[800]!;
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.black;
              }
              return Colors.black;
            },
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide.none,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            // Implementar busca
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.filter_list,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            // Implementar filtros
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: const Text('Com desconto'),
                  onSelected: (selected) {},
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text('Disponíveis'),
                  onSelected: (selected) {},
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text('Hidro'),
                  onSelected: (selected) {},
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text('Piscina'),
                  onSelected: (selected) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
