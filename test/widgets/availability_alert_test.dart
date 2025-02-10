import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_moteis_teste/widgets/availability_alert.dart';

void main() {
  testWidgets('AvailabilityAlert exibe a mensagem correta',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AvailabilityAlert(remaining: 2),
        ),
      ),
    );

    // Verifica se a mensagem está sendo exibida
    expect(find.text('Só mais 2 pelo app'), findsOneWidget);
  });
}
