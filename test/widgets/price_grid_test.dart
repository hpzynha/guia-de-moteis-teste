import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_moteis_teste/widgets/price_grid.dart';

void main() {
  testWidgets('PriceGrid exibe os preços corretamente',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PriceGrid(prices: {'2 horas': 89.0, '3 horas': 109.0}),
        ),
      ),
    );

    // Aguarda a renderização do widget
    await tester.pump();

    // Verifica se os preços estão sendo exibidos
    expect(find.text('2 horas: R\$ 89.00'), findsOneWidget);
    expect(find.text('3 horas: R\$ 109.00'), findsOneWidget);
  });
}
