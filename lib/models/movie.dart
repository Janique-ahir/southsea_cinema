class Movie {
  final String id; 
  final String title; 
  final String description;
  final String ageRating;
  final String showtime;
  final String posterPath;
  final double ticketPrice;
  

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.ageRating,
    required this.showtime,
    required this.posterPath,
    required this.ticketPrice,
  });
}