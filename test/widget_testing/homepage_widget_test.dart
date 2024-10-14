import 'package:final_mobile_project/main.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyHomePage', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Please login'), findsOneWidget);
    expect(find.text('Movie'), findsOneWidget);
    expect(find.text('Favorite'), findsOneWidget);
  });
}
