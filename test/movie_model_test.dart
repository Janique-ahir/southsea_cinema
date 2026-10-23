import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('Movie stores the correct properties', () {
      const movie = Movie(
          id: 'emma-2020',
          title: 'Emma (2020)',
          description: 'A historical romance film',
          ageRating: 'U',
          showtime: '18:00',
          ticketPrice: 8.50,
          posterPath: 'assets/images/emma.jpg');

      expect(movie.id, 'emma-2020');
      expect(movie.title, 'Emma (2020)');
      expect(movie.description, 'A historical romance film');
      expect(movie.ageRating, 'U');
      expect(movie.showtime, '18:00');
      expect(movie.ticketPrice, 8.50);
      expect(movie.posterPath, 'assets/images/emma.jpg');
    });

    test('formattedPrice displays two decimal places', () {
      const movieWithPence = Movie(
          id: 'test-1',
          title: 'Emma (2020)',
          description: 'A historical romance film',
          ageRating: 'U',
          showtime: '18:00',
          ticketPrice: 8.50,
          posterPath: 'assets/images/emma.jpg');

      const movieWithWholePounds = Movie(
          id: 'test-2',
          title: 'Emma (2020)',
          description: 'A historical romance film',
          ageRating: 'U',
          showtime: '18:00',
          ticketPrice: 10.00,
          posterPath: 'assets/images/emma.jpg',);

      expect(movieWithPence.formattedPrice, '£8.50');
      expect(movieWithWholePounds.formattedPrice, '£10.00');

    });
  });
}
