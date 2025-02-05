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
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 50),
              SizedBox(height: 20),
              Text('Erro ao carregar dados:', style: TextStyle(fontSize: 18)),
              Text(error.toString(),
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => ref.invalidate(motelListProvider),
                child: Text('Tentar novamente'),
              )
            ],
          ),
        ),
        data: (motels) => motels.isEmpty
            ? Center(child: Text('Nenhum motel encontrado'))
            : ListView.builder(
                itemCount: motels.length,
                itemBuilder: (context, index) {
                  final motel = motels[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.network(
                                motel.imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(motel.name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 4),
                                    Text(motel.address,
                                        style:
                                            TextStyle(color: Colors.grey[600])),
                                    SizedBox(height: 8),
                                    Text(
                                        'A partir de R\$ ${motel.lowestPrice.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.green[700],
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (motel.suites.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                'Suítes disponíveis: ${motel.suites.length}',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
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
