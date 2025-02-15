class Motel {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final double distance;
  final double rating;
  final int reviewCount;
  final int availableSuites;
  final List<Suite> suites;

  Motel({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.availableSuites,
    required this.suites,
  });

  factory Motel.fromJson(Map<String, dynamic> json) {
    final rawDistance = json['distancia'];
    final parsedDistance = _parseDouble(rawDistance);
    return Motel(
      id: json['id']?.toString() ?? '0',
      name: json['fantasia']?.toString() ?? 'Motel sem nome',
      address: json['bairro']?.toString() ?? 'Endereço não informado',
      imageUrl: json['logo']?.toString() ?? 'https://via.placeholder.com/100',
      distance: parsedDistance!,
      rating: _parseDouble(json['media']) ?? 0.0,
      reviewCount: _parseInt(json['qtdAvaliacoes']) ?? 0,
      availableSuites: _parseInt(json['suites']?.length) ?? 0,
      suites: (json['suites'] as List<dynamic>?)
              ?.map((e) => Suite.fromJson(e))
              .toList() ??
          [],
    );
  }
  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class Suite {
  final String name;
  final List<String> photos;
  final List<Period> periods;

  Suite({
    required this.name,
    required this.photos,
    required this.periods,
  });

  factory Suite.fromJson(Map<String, dynamic> json) {
    return Suite(
      name: json['nome'] ?? 'Suite sem nome',
      photos: (json['fotos'] as List<dynamic>?)?.cast<String>() ?? [],
      periods: (json['periodos'] as List<dynamic>?)
              ?.map((periodoJson) => Period.fromJson(periodoJson))
              .toList() ??
          [],
    );
  }
}

class Period {
  final String formattedTime;
  final double valueTotal;

  Period({
    required this.formattedTime,
    required this.valueTotal,
  });

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      formattedTime: json['tempoFormatado'] ?? '0h',
      valueTotal: (json['valorTotal'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
