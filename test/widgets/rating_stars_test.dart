import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_moteis_teste/widgets/rating_stars.dart';

void main() {
  testWidgets('RatingStars exibe a avaliação corretamente',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RatingStars(rating: 4.5),
        ),
      ),
    );

    // Verifica se a avaliação está sendo exibida
    expect(find.text('4.5'), findsOneWidget);
  });
}
