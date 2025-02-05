import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guia_de_moteis_teste/providers/motel_provider.dart';
import 'package:guia_de_moteis_teste/widgets/availability_alert.dart';
import 'package:guia_de_moteis_teste/widgets/location_header.dart';
import 'package:guia_de_moteis_teste/widgets/motel_card.dart';
import 'package:guia_de_moteis_teste/widgets/price_button.dart';
import 'package:guia_de_moteis_teste/widgets/price_grid.dart';
import 'package:guia_de_moteis_teste/widgets/rating_stars.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 50, color: Colors.red),
                const SizedBox(height: 20),
                Text(
                  'Erro de conexão',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Tentar novamente'),
                  onPressed: () => ref.invalidate(motelListProvider),
                ),
              ],
            ),
          ),
        ),
        data: (motels) => motels.isEmpty
            ? Center(child: Text('Nenhum motel encontrado'))
            : ListView.builder(
                itemCount: motels.length,
                itemBuilder: (context, index) {
                  final motel = motels[index];
                  return Column(
                    children: [
                      Card(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(motel.name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 4),
                                        Text(motel.address,
                                            style: TextStyle(
                                                color: Colors.grey[600])),
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
                      ),
                      LocationHeader(),
                      AvailabilityAlert(remaining: 2),
                      RatingStars(rating: 2),
                      FilledButton(onPressed: () {}, child: Text('sd')),
                      MotelCard(),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
