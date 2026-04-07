import 'package:flutter_test/flutter_test.dart';

import 'package:digitalham/main.dart';

void main() {
  testWidgets('DigitalHam app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DigitalHamApp());

    expect(find.text('DigitalHam'), findsOneWidget);
    expect(find.text('Ready'), findsOneWidget);
    expect(find.text('TX'), findsOneWidget);
    expect(find.text('RX'), findsOneWidget);
  });
}
