import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_moteis_teste/providers/motel_provider.dart';
import 'package:guia_de_moteis_teste/views/motel_list_screen.dart';
import 'package:mockito/mockito.dart';
import '../mocks/motel_service_mock.mocks.dart';

void main() {
  testWidgets('MotelListScreen exibe loading inicial',
      (WidgetTester tester) async {
    // Cria uma instância do mock
    final mockMotelService = MockMotelService();

    // Configura o mock para retornar uma lista vazia
    when(mockMotelService.fetchMotels()).thenAnswer((_) async => []);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          motelServiceProvider.overrideWithValue(mockMotelService),
        ],
        child: MaterialApp(
          home: MotelListScreen(),
        ),
      ),
    );

    // Verifica se o loading está sendo exibido
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('MotelListScreen exibe erro ao falhar o carregamento',
      (WidgetTester tester) async {
    // Cria uma instância do mock
    final mockMotelService = MockMotelService();

    // Configura o mock para lançar uma exceção
    when(mockMotelService.fetchMotels())
        .thenThrow(Exception('Erro ao carregar dados'));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          motelServiceProvider.overrideWithValue(mockMotelService),
        ],
        child: MaterialApp(
          home: MotelListScreen(),
        ),
      ),
    );

    await tester.pump();

    // Verifica se a mensagem de erro está sendo exibida
    expect(find.text('Erro ao carregar dados:'), findsOneWidget);
  });
}
