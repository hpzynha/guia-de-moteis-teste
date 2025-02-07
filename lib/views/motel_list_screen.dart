import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/motel.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_app_bar.dart';
import '../providers/motel_provider.dart';
import '../widgets/motel_card.dart';

class MotelListScreen extends ConsumerStatefulWidget {
  const MotelListScreen({super.key});

  @override
  ConsumerState<MotelListScreen> createState() => _MotelListScreenState();
}

class _MotelListScreenState extends ConsumerState<MotelListScreen> {
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  bool _isNow = true;

  void _openDrawer() {
    _scafoldKey.currentState?.openDrawer();
  }

  void _handleToggleChanged(bool isNow) {
    setState(() {
      _isNow = isNow;

      if (_isNow) {
      } else {}
    });
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alterar localização'),
        content: const Text('Escolha uma nova localização'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Implementar mudança de localização
              Navigator.pop(context);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final motelListAsync = ref.watch(motelListProvider);

    return Scaffold(
      key: _scafoldKey, // A chave do Scafold
      appBar: CustomAppBar(
        onMenuPressed: _openDrawer,
        onLocationPressed: _showLocationDialog,
        onToggleChanged: _handleToggleChanged,
      ),
      drawer: const AppDrawer(),
      body: motelListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorWidget(context, ref, error),
        data: (motels) => _buildMainContent(context, motels),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, List<Motel> motels) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: motels.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final motel = motels[index];
        return MotelCard(
          name: motel.name,
          distance: '${motel.distance.toStringAsFixed(1)} km',
          location: motel.address,
          rating: motel.rating,
          reviews: motel.reviewCount,
          remainingSuites: motel.availableSuites,
          prices: _parsePrices(motel),
        );
      },
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 50, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              'Erro ao carregar dados:',
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
    );
  }
}
