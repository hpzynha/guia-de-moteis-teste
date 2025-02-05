import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guia_de_moteis_teste/providers/motel_provider.dart';

class MotelListScreen extends ConsumerWidget {
  const MotelListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final motelListAsync = ref.watch(motelListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Motéis Disponíveis'),
      ),
      body: motelListAsync.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Erro ao carregar motéis'),
        ),
        data: (motels) => ListView.builder(
          itemCount: motels.length,
          itemBuilder: (context, index) {
            final motel = motels[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Image.network(
                      motel.imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          motel.name,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'R\$ ${motel.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
