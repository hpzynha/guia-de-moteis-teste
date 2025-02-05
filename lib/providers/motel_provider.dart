import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/motel.dart';
import '../services/motel_service.dart';
import 'package:http/http.dart' as http;

final motelServiceProvider = Provider<MotelService>((ref) {
  return MotelService(http.Client());
});

final motelListProvider = FutureProvider<List<Motel>>((ref) async {
  final service = ref.read(motelServiceProvider);
  return await service.fetchMotels();
});
