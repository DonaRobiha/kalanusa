import 'package:flutter_test/flutter_test.dart';
import 'package:kalanusa/main.dart';

void main() {
  testWidgets('KalanusaApp basic smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KalanusaApp());
    expect(find.byType(KalanusaApp), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 4));
  });
}
