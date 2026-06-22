import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/main.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());

    expect(find.text('정성윤'), findsOneWidget);
    expect(find.text('Crafting digital experiences.'), findsOneWidget);
  });
}
