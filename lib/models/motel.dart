class Motel {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final double lowestPrice;
  final List<Suite> suites;

  Motel({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.lowestPrice,
    required this.suites,
  });

  factory Motel.fromJson(Map<String, dynamic> json) {
    final suites = (json['suites'] as List<dynamic>?)
            ?.map((suiteJson) => Suite.fromJson(suiteJson))
            .toList() ??
        [];

    double lowest = double.infinity;
    for (final suite in suites) {
      for (final periodo in suite.periods) {
        if (periodo.valueTotal < lowest) {
          lowest = periodo.valueTotal;
        }
      }
    }

    return Motel(
      id: json['fantasia'] ?? 'sem-id',
      name: json['fantasia'] ?? 'Nome não informado',
      address: json['bairro'] ?? 'Endereço não informado',
      imageUrl: json['logo'] ?? 'https://via.placeholder.com/100',
      lowestPrice: lowest != double.infinity ? lowest : 0.0,
      suites: suites,
    );
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
