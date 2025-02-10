import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_moteis_teste/widgets/motel_card.dart';

void main() {
  // Cria o widget MotelCard
  testWidgets('MotelCard exibe nome, distância e localização corretamente',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MotelCard(
              name: 'Motel Exemplo',
              distance: '1.5 km',
              location: 'São Paulo',
              rating: 4.5,
              reviews: 100,
              remainingSuites: 2,
              prices: {'2 horas': 8, '3 horas': 109.0},
              imageUrl: 'https://example.com/logo.png'),
        ),
      ),
    );

    //O nome do motel está sendo exibido
    expect(find.text('Motel Exemplo'), findsOneWidget);

    //A distância e loc estão sendo exibidas
    expect(find.text('1.5 km - São Paulo'), findsOneWidget);

    //A avaliação está sendo exibida e o numero de avaliações
    expect(find.text('4.5'), findsOneWidget);
    expect(find.text('100 avaliações'), findsOneWidget);

    //Os preços estão sendo exibidos
    expect(find.text('2 horas: R\$ 89.00'), findsOneWidget);
    expect(find.text('3 horas: R\$ 109.00'), findsOneWidget);
  });
  testWidgets('MotelCard exibe AvailabilityAlert quando há suites disponíveis',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MotelCard(
            name: 'Motel Exemplo',
            distance: '1.5 km',
            location: 'São Paulo',
            rating: 4.5,
            reviews: 100,
            remainingSuites: 2,
            prices: {'2 horas': 89.0, '3 horas': 109.0},
            imageUrl: 'https://example.com/logo.png',
          ),
        ),
      ),
    );
    //Se o AvailabilityAlert via ser exibido
    expect(find.text('Só mais 2 pelo app'), findsOneWidget);
  });
  testWidgets(
      'MotelCard não exibe AvailabilityAlert quando não há suites disponíveis',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MotelCard(
            name: 'Motel Exemplo',
            distance: '1.5 km',
            location: 'São Paulo',
            rating: 4.5,
            reviews: 100,
            remainingSuites: 0,
            prices: {'2 horas': 89.0, '3 horas': 109.0},
            imageUrl: 'https://example.com/logo.png',
          ),
        ),
      ),
    );
// Verifica se o AvailabilityAlert não está sendo exibido
    expect(find.text('Só mais 2 pelo app'), findsNothing);
  });
}
