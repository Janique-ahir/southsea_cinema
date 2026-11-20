import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';

void main() {
  final basket = BasketRepository.instance;

  const emma = Movie(
    id: 'emma-2020',
    title: 'Emma (2020)',
    description: 'A historical romantic comedy.',
    ageRating: 'U',
    showtime: 'Friday 2nd October,18:00 - ends at 19:24.',
    ticketPrice: 8.50,
    posterPath: 'assets/images/emma.jpg',
  );
  const badApples = Movie(
    id: 'badapples-2026',
    title: 'Bad Apples (2026)',
    description: 'A teacher makes some questionable decisions.',
    ageRating: '15',
    showtime: 'Friday 16th October, 18:00 - ends at 19:40 ',
    ticketPrice: 8.50,
    posterPath: 'assets/images/badapples.jpg',
  );

  setUp(basket.clear);
  tearDown(basket.clear);

  testWidgets('Removing Emma keeps Bad Apples in the basket', (tester) async {
    basket.addTickets(emma, 2);
    basket.addTickets(badApples, 1);
    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    expect(find.text('Emma (2020)'), findsOneWidget);
    expect(find.text('Bad Apples (2026)'), findsOneWidget);
    expect(basket.total, 25.50);

    await tester.tap(find.byTooltip('Remove Emma (2020)'));
    await tester.pump();

    expect(find.text('Emma (2020)'), findsNothing);
    expect(find.text('Bad Apples (2026)'), findsOneWidget);
    expect(basket.items.single.movie.id, 'badapples-2026');
    expect(basket.total, 8.50);
  });

  testWidgets('Clear Basket removes all the tickets', (tester) async {
    basket.addTickets(emma, 2);
    basket.addTickets(badApples, 1);
    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    await tester.tap(find.text('Clear Basket'));
    await tester.pump();

    expect(basket.items, isEmpty);
    expect(basket.total, 0.0);
    expect(find.text('Your basket is empty'), findsOneWidget);
  });

  testWidgets('Demo checkout shows total and clears the basket', (tester) async {
    basket.addTickets(emma, 2);
    basket.addTickets(badApples, 1);
    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    await tester.tap(find.text('Checkout (Demo)'));
    await tester.pump();

    expect(basket.items, isEmpty);
    expect(basket.total, 0.0);
    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(find.text('Demo checkout complete: £25.50'), findsOneWidget);
  });
}
