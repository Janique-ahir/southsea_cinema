import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';

void main(){
  test('Two cinema tickets cost twice the ticket price', (){
    const movie = Movie(
      id: 'Emma-2020',
      title: 'Emma (2020)',
      description: "Emma. (2020) is a visually vibrant, witty period romantic comedy directed by Autumn de Wilde and based on Jane Austen's 1815 novel.",
      ageRating: 'U',
      showtime: 'Friday 2nd October,18:00 - ends at 19:24.',
      ticketPrice: 8.50,
      posterPath: 'assets/images/emma.jpg',
    
    );

    const item = BasketItem(movie: movie, quantity: 2);

    expect(item.quantity, 2);
    expect(item.lineTotal, 17.00);
  });
}