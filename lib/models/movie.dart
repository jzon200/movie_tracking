class Movie {
  final String id;
  final String title;
  final String imageUrl;
  final String director;
  final String duration;
  final double rating;
  final DateTime date;
  final List<String> genre;
  bool isWatchlist;

  static List<Movie> movieInfo = [
    Movie(
      id: 'm1',
      title: 'Birds Of Prey',
      imageUrl: 'assets/birds_of_prey.png',
      director: 'Cathy Yan',
      duration: '1h 49 Min',
      rating: 3.6,
      date: DateTime(2020),
      genre: ['Action', 'Superhero', 'Crime'],
    ),
    Movie(
      id: 'm2',
      title: 'Avengers: Endgame',
      imageUrl: 'assets/avengers_endgame.png',
      director: 'Joe Russo',
      duration: '3h 2 Min',
      rating: 4.7,
      date: DateTime(2019),
      genre: ['Action', 'Superhero', 'Sci-fi'],
    ),
    Movie(
      id: 'm3',
      title: 'Spider-Man Far From Home',
      imageUrl: 'assets/spider_man_far_from_home.png',
      director: 'Jon Watts',
      duration: '2h 10 Min',
      rating: 4.4,
      date: DateTime(2019),
      genre: ['Action', 'Superhero', 'Adventure'],
    ),
    Movie(
      id: 'm4',
      title: 'Star Wars: The Rise of Skywalker',
      imageUrl: 'assets/star_wars_rise_of_skywalker.png',
      director: 'J.J. Abrams',
      duration: '2h 22 Min',
      rating: 3.4,
      date: DateTime(2019),
      genre: ['Action', 'Sci-fi', 'Fantasy'],
    ),
    Movie(
      id: 'm5',
      title: 'Star Wars: The Last Jedi ',
      imageUrl: 'assets/star_wars_the_last_jedi.png',
      director: 'Rian Johnson',
      duration: '2h 32 Min',
      rating: 2.3,
      date: DateTime(2017),
      genre: ['Action', 'Sci-fi', 'Fantasy'],
    ),
    Movie(
      id: 'm6',
      title: 'Frozen 2',
      imageUrl: 'assets/frozen_2.png',
      director: 'Jennifer Lee',
      duration: '1h 43 Min',
      rating: 4.3,
      date: DateTime(2019),
      genre: ['Drama', 'Fantasy', 'Musical', 'Adventure'],
    ),
  ];

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.director,
    required this.duration,
    required this.rating,
    required this.date,
    required this.genre,
    this.isWatchlist = false,
  });
}
