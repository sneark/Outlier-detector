import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart'; 
import 'package:decoder/features/outlier_detection/presentation/pages/main_page.dart';
import 'package:decoder/features/outlier_detection/presentation/pages/result_page.dart';
import 'package:decoder/features/outlier_detection/presentation/viewmodels/main_view_model.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Outlier Detection', () {
    testWidgets('enter numbers and find outlier', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MainViewModel()),
          ],
          child: const MaterialApp(
            home: MainPage(), 
          ),
        ),
      );
      
      await tester.pumpAndSettle();

      final inputField = find.byKey(const Key('inputField'));
      final searchButton = find.byKey(const Key('searchButton'));

      expect(inputField, findsOneWidget);
      expect(searchButton, findsOneWidget);

      await tester.enterText(inputField, "2, 4, 0, 100, 4, 11, 2602, 36");
      await tester.pumpAndSettle(); 

      await tester.tap(searchButton);
      
      await tester.waitFor(find.byType(ResultPage)); 
      
      expect(find.byType(ResultPage), findsOneWidget);
      expect(find.text('11'), findsOneWidget);
    });

     testWidgets('enter insufficient data shows error', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MainViewModel()),
          ],
          child: const MaterialApp(
            home: MainPage(),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      
      final inputField = find.byKey(const Key('inputField'));
      await tester.enterText(inputField, "1, 2");
      await tester.pumpAndSettle();

      final searchButton = find.byKey(const Key('searchButton'));
      await tester.tap(searchButton);
      
      await tester.waitFor(find.text('Wprowadź co najmniej 3 liczby, aby znaleźć wynik.'));

      expect(find.text('Wprowadź co najmniej 3 liczby, aby znaleźć wynik.'), findsOneWidget);
    });
  });
}

extension WidgetTesterExt on WidgetTester {
  Future<void> waitFor(Finder finder, {Duration timeout = const Duration(seconds: 5)}) async {
    final end = DateTime.now().add(timeout);

    do {
      if (DateTime.now().isAfter(end)) {
        throw Exception('Timed out waiting for $finder');
      }
      await pump(const Duration(milliseconds: 100));
    } while (any(finder) == false);
  }
}