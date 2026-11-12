import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';

void main() {
  testWidgets('Drawer navigates between cinema pages', (tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('My Basket'));
    await tester.pumpAndSettle();

    expect(find.text('Your basket is empty'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('My Settings'));
    await tester.pumpAndSettle();

    expect(
      find.text('Customer settings will appear here.'),
      findsOneWidget,
    );

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Emma (2020)'), findsOneWidget);

    //expect(find.text('Emma(2020)'),findsOneWidget);
  });
}
