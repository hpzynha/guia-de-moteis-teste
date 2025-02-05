import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/motel.dart';

class MotelService {
  final http.Client client;

  MotelService(this.client);

  Future<List<Motel>> fetchMotels() async {
    try {
      final response = await client.get(
        Uri.parse('https://jsonkeeper.com/b/1IXK'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(utf8.decode(response.bodyBytes));
        final List<dynamic> motelsData = data['data']['moteis'];
        return motelsData.map((json) => Motel.fromJson(json)).toList();
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } on HandshakeException catch (e) {
      throw Exception('Erro de certificado SSL: $e');
    } catch (e) {
      throw Exception('Falha na requisição: $e');
    }
  }
}
