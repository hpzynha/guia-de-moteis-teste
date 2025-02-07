import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  final ValueChanged<bool> onToggleChanged;
  final VoidCallback onLocationPressed;

  const CustomAppBar({
    super.key,
    required this.onMenuPressed,
    required this.onLocationPressed,
    required this.onToggleChanged,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isNow = true;
  void _toggle() {
    setState(() {
      _isNow = !_isNow;
    });
    widget.onToggleChanged(_isNow);
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
      title: Row(
        children: [
          IconButton(
              onPressed: _toggle,
              icon: Icon(_isNow ? Icons.flash_on : Icons.calendar_today))
        ],
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);
}
