import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

void main() {
  final basket = BasketRepository.instance;

  const movie = Movie(
    id: 'emma-2020',
    title: 'Emma (2020)',
    description:
        "Emma. (2020) is a visually vibrant, witty period romantic comedy directed by Autumn de Wilde and based on Jane Austen's 1815 novel.",
    ageRating: 'U',
    showtime: 'Friday 2nd October,18:00 - ends at 19:24.',
    ticketPrice: 8.50,
    posterPath: 'assets/images/emma.jpg',
  );

  setUp(() {
    basket.clear();
  });

  test('Adding the same movie combines ticket quantites', () {
    basket.addTickets(movie, 2);
    basket.addTickets(movie, 1);

    expect(basket.items.length, 1);
    expect(basket.items.first.quantity, 3);
    expect(basket.items.first.lineTotal, 25.50);
  });

  test('Removing a movie keeps other basket items', () {
    const badapples = Movie(
      id: 'badapples-2026',
      title: 'Bad Apples (2026)',
      description:
          "A struggling primary school teacher begins to make some questionable decisions after one of her students is injured.",
      showtime: 'Friday 16th October, 18:00 - ends at 19:40 ',
      ageRating: '15',
      ticketPrice: 8.50,
      posterPath: 'assets/images/badapples.jpg',
    );

    basket.addTickets(movie, 2);
    basket.addTickets(badapples, 1);
    expect(basket.total, 25.50);

    basket.removeMovie('emma-2020');

    expect(basket.items.length, 1);
    expect(basket.items.first.movie.id, 'badapples-2026');
    expect(basket.total, 8.50);
  });

  test('Clearing the basket removes everything', () {
    basket.addTickets(movie, 3);

    basket.clear();

    expect(basket.items, isEmpty);
    expect(basket.total, 0.0);
  });

  test('Cannot add zero or negative tickets', () {
    expect(
      () => basket.addTickets(movie, 0),
      throwsArgumentError,
    );

    expect(
      () => basket.addTickets(movie, -2),
      throwsArgumentError,
    );

    expect(basket.items, isEmpty);
  });

  test('Basket items cannot be modified directly', (){
    basket.addTickets(movie, 2);

    expect(
      () => basket.items.clear(),
      throwsUnsupportedError,
    );

    expect(basket.items.length,1);
    expect(basket.items.first.quantity,2);
    expect(basket.total,17.00);
  });
}
