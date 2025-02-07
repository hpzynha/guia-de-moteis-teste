import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              size: 26,
            ),
            title: const Text('Início'),
            onTap: () {
              // Navegar para a tela inicial
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
              size: 26,
            ),
            title: const Text('Histórico'),
            onTap: () {
              // Navegar para o histórico
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 26,
            ),
            title: const Text('Configurações'),
            onTap: () {
              // Navegar para configurações
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              size: 26,
            ),
            title: const Text(
              'Sair',
            ),
            onTap: () {
              // Implementar logout
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
