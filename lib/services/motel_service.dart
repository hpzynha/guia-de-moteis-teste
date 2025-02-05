import 'dart:convert';
import 'package:guia_de_moteis_teste/models/model.dart';
import 'package:http/http.dart' as http;

class MotelService {
  final http.Client client;

  MotelService(this.client);

  Future<List<Motel>> fetchMotel() async {
    final response =
        await client.get(Uri.parse('https://jsonkeeper.com/b/1IXK'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Motel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar motéis');
    }
  }
}
