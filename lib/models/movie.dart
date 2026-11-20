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

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      ageRating: json['ageRating'] as String,
      showtime: json['showtime'] as String,
      posterPath: json['posterPath'] as String,
      ticketPrice: (json['ticketPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'ageRating': ageRating,
      'showtime': showtime,
      'posterPath': posterPath,
      'ticketPrice': ticketPrice,
    };
  }

  String get formattedPrice => '£${ticketPrice.toStringAsFixed(2)}';
}
