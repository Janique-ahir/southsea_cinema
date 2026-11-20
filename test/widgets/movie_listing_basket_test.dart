import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

void main() {
  final basket = BasketRepository.instance;

  const movie = Movie(
    id: 'emma-2020',
    title: 'Emma (2020)',
    description: "Emma. (2020) is a visually vibrant, witty period romantic comedy directed by Autumn de Wilde and based on Jane Austen's 1815 novel.",
    ageRating: 'U',
    showtime: 'Friday 2nd October,18:00 - ends at 19:24.',
    ticketPrice: 8.50,
    posterPath: 'assets/images/emma.jpg',
  );

  setUp((){
    basket.clear();
  });

  tearDown((){
    basket.clear();
  });

  testWidgets('Add to order stores a cinema ticket', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MovieListing(movie: movie),
      ),
    );

    expect(basket.items, isEmpty);

    await tester.ensureVisible(find.text('Add to Order'));
    await tester.tap(find.text('Add to Order'));
    await tester.pump();

    expect(basket.items.length, 1);
    expect(basket.items.first.movie.id, 'emma-2020');
    expect(basket.items.first.quantity, 1);
    expect(basket.total, 8.50);

    expect(find.text('1 ticket(s) added to order'), findsOneWidget);
  });

    testWidgets('Selecting two tickets stores the correct quantity',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MovieListing(movie: movie),
        ),
      );

      await tester.tap(find.byType(DropdownMenu<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Two tickets').last);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Add to Order'));
      await tester.tap(find.text('Add to Order'));
      await tester.pump();

      expect(basket.items.length,1);
      expect(basket.items.single.quantity, 2);
      expect(basket.total, 17.00);

      expect(find.text('2 ticket(s) added to order'), findsOneWidget);
     
      
  });

}