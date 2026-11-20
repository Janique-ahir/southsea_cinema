import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie>? _cachedMovies;

  List<Movie> getMovies() {
    final List<Movie>? cachedMovies = _cachedMovies;
    if (cachedMovies != null) {
      return cachedMovies;
    }
    return const [
      Movie(
        id: 'emma-2020',
        title: 'Emma (2020)',
        description:
            "Emma. (2020) is a visually vibrant, witty period romantic comedy directed by Autumn de Wilde and based on Jane Austen's 1815 novel.",
        ageRating: 'U',
        showtime: 'Friday 2nd October,18:00 - ends at 19:24.',
        ticketPrice: 8.50,
        posterPath: 'assets/images/emma.jpg',
      ),
      Movie(
        id: 'badapples-2026',
        title: 'Bad Apples (2026)',
        description:
            "A struggling primary school teacher begins to make some questionable decisions after one of her students is injured.",
        showtime: 'Friday 16th October, 18:00 - ends at 19:40 ',
        ageRating: '15',
        ticketPrice: 8.50,
        posterPath: 'assets/images/badapples.jpg',
      )
    ];
  }

  Movie? getMovieById(String id) {
    for (final movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }
    return null;
  }

  Future<List<Movie>> loadMoviesFromAsset({
    String assetPath = 'assets/data/movies.json',
  }) async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
    final List<Movie> loadedMovies = [];

    for (final dynamic item in jsonList) {
      final Map<String, dynamic> movieMap = item as Map<String, dynamic>;
      loadedMovies.add(Movie.fromJson(movieMap));
    }

    _cachedMovies = loadedMovies;
    return loadedMovies;
  }

}
