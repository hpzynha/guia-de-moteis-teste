import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guia_de_moteis_teste/providers/motel_provider.dart';
import 'package:guia_de_moteis_teste/widgets/availability_alert.dart';
import 'package:guia_de_moteis_teste/widgets/filter_chips.dart';
import 'package:guia_de_moteis_teste/widgets/location_header.dart';
import 'package:guia_de_moteis_teste/widgets/motel_card.dart';
import 'package:guia_de_moteis_teste/widgets/rating_stars.dart';

import '../models/motel.dart';

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
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => _buildErrorWidget(context, ref, error),
        data: (motels) => _buildMainContent(context, motels),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, List<Motel> motels) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const LocationHeader(),
          const SizedBox(
            height: 16,
          ),
          const FilterChips(),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: motels.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemBuilder: (context, index) {
                final motel = motels[index];
                return MotelCard(
                  name: motel.name,
                  distance: '${motel.distance.toStringAsFixed(1)} km',
                  location: motel.address,
                  rating: motel.rating,
                  reviews: motel.reviewCount,
                  remaningSuites: motel.availableSuites,
                  prices: _parsePrices(motel),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Map<String, double> _parsePrices(Motel motel) {
    final prices = <String, double>{};
    for (final suite in motel.suites) {
      for (final period in suite.periods) {
        prices[period.formattedTime] = period.valueTotal;
      }
    }
    return prices;
  }

  Widget _buildErrorWidget(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 50,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
