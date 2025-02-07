import 'package:flutter/material.dart';

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
          GestureDetector(
            onTap: _toggle,
            child: Container(
              width: 120,
              height: 36,
              decoration: BoxDecoration(
                color: _isNow ? Colors.red[800] : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(microseconds: 200),
                    curve: Curves.easeInOut,
                    left: _isNow ? 4 : 60,
                    child: Container(
                      width: 56,
                      height: 28,
                      decoration: BoxDecoration(
                        color: _isNow ? Colors.white : Colors.red[800],
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Icon(
                          _isNow ? Icons.flash_on : Icons.calendar_today,
                          size: 16,
                          color: _isNow ? Colors.red[800] : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    child: Text(
                      'Ir Agora',
                      style: TextStyle(
                        color: _isNow ? Colors.white : Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
}
