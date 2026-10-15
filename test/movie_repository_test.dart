import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main(){
  group('MovieRepository unit tests', (){
    test('getMovies returns two movies',(){
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length,2);
    });

    test('getMovies contains the correct movie data',(){
      final repository = MovieRepository();
      final movies = repository.getMovies();

      final emma = movies[0];

      expect(emma.id,'emma-2020');
      expect(emma.title,'Emma (2020)');
      expect(emma.ticketPrice,8.50);
      expect(emma.posterPath, isNotEmpty);

      final badapples = movies[1];

      expect(badapples.id, 'badapples-2026');
      expect(badapples.title, 'Bad Apples (2026)');
      expect(badapples.ticketPrice,8.50);
      expect(badapples.posterPath, isNotEmpty);
    }
    );

    test('getMovieById returns an existing movie', (){
      final repository = MovieRepository();

      final Movie? movie = repository.getMovieById('emma-2020');

      expect(movie, isNotNull);
      expect(movie?.title, 'Emma (2020)');
      expect(movie?.ticketPrice,8.50);
    });

    test('getMovieById retruns null for a random movie',(){
      final repository = MovieRepository();
      final Movie? movie = repository.getMovieById('random movie');

      expect(movie,isNull);
    });

  });



}

