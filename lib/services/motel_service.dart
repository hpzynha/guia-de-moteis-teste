import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/motel.dart';

class MotelService {
  final http.Client client;

  MotelService(this.client);

  Future<List<Motel>> fetchMotels() async {
    try {
      final response =
          await client.get(Uri.parse('https://jsonkeeper.com/b/1IXK'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> motelsData = data['data']['moteis'];

        return motelsData.map((json) => Motel.fromJson(json)).toList();
      } else {
        throw Exception('Erro HTTP: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha ao carregar: $e');
    }
  }
}
