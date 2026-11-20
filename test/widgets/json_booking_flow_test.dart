import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

void main() {
  final basket = BasketRepository.instance;

  setUp(() {
    rootBundle.clear();
    basket.clear();
  });
  tearDown(basket.clear);

  testWidgets('A movie loaded from JSON can be booked and removed', (tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();
    expect(find.text('Emma (2020)'), findsOneWidget);

    await tester.tap(find.text('Book Now').first);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Add to Order'));
    await tester.tap(find.text('Add to Order'));
    await tester.pump();
    expect(basket.items.single.movie.id, 'emma-2020');

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('My Basket'));
    await tester.pumpAndSettle();

    expect(find.text('Emma (2020)'), findsOneWidget);
    await tester.tap(find.byTooltip('Remove Emma (2020)'));
    await tester.pump();
    expect(basket.items, isEmpty);
    expect(find.text('Your basket is empty'), findsOneWidget);
  });

  testWidgets('A JSON movie can be checked out without saving history', (tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Book Now').first);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Add to Order'));
    await tester.tap(find.text('Add to Order'));
    await tester.pump();

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('My Basket'));
    await tester.pumpAndSettle();
    expect(basket.total, 8.50);

    await tester.tap(find.text('Checkout (Demo)'));
    await tester.pump();
    expect(basket.items, isEmpty);
    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(find.text('Demo checkout complete: £8.50'), findsOneWidget);
  });
}
