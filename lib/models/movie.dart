import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String? id;
  final String? title;
  final String? overview;
  final String? imageUrl;
  final String? director;
  final int? duration;
  final double? rating;
  final int? year;
  final List? genres;
  bool isWatchlist;

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.overview = '',
    this.director = 'Edzon Bausa',
    this.duration = 0,
    required this.rating,
    this.year = 2019,
    required this.genres,
    this.isWatchlist = false,
  });

  @override
  List<Object?> get props => [
        title,
        imageUrl,
        overview,
        director,
        duration,
        rating,
        year,
        genres,
        isWatchlist
      ];

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as String,
      title: json['title']['title'] as String,
      overview: json['plotOutline']['text'] as String,
      imageUrl: json['title']['image']['url'] as String,
      duration: json['title']['runningTimeInMinutes'] as int,
      rating: json['ratings']['rating'] ?? 0.0,
      year: json['title']['year'] as int,
      genres: json['genres'] as List,
    );
  }

  static List<Movie> movieInfo = [
    Movie(
      id: 'm1',
      title: 'Birds Of Prey',
      imageUrl: 'assets/birds_of_prey.png',
      director: 'Cathy Yan',
      // duration: '1h 49 Min',
      rating: 3.6,
      // year: DateTime(2020),
      genres: ['Action', 'Superhero', 'Crime'],
      overview:
          '''Birds of Prey (and the Fantabulous Emancipation of One Harley Quinn)[a] is a 2020 American superhero film based on the DC Comics team Birds of Prey. Distributed by Warner Bros. Pictures, it is the eighth installment in the DC Extended Universe and a follow-up to Suicide Squad (2016). It was directed by Cathy Yan and written by Christina Hodson, and it stars Margot Robbie, Mary Elizabeth Winstead, Jurnee Smollett-Bell, Rosie Perez, Chris Messina, Ella Jay Basco, Ali Wong, and Ewan McGregor. The film follows Harley Quinn as she joins forces with Helena Bertinelli, Dinah Lance, and Renee Montoya to save Cassandra Cain from Gotham City crime lord Black Mask.

Robbie, who also served as producer, pitched the idea for Birds of Prey to Warner Bros. in 2015. The film was announced in May 2016, with Hodson being hired to write the script that November, followed by Yan signing on to direct in April 2018. The majority of the cast and crew were confirmed by December 2018. Principal photography lasted from January to April 2019 in Downtown Los Angeles, parts of the Arts District, Los Angeles, and soundstages at Warner Bros. Studios in Burbank, California. Additional filming took place in September 2019.

Birds of Prey is the first DCEU film and the second DC Films production to be rated R by the Motion Picture Association of America. The film had its world premiere in Mexico City on January 25, 2020, and was theatrically released in the United States in IMAX, Dolby Cinema, and 4DX on February 7, 2020.
''',
    ),
    Movie(
      id: 'm2',
      title: 'Avengers: Endgame',
      imageUrl: 'assets/avengers_endgame.png',
      director: 'Joe Russo',
      // duration: '3h 2 Min',
      rating: 4.7,
      // year: DateTime(2019),
      genres: ['Action', 'Superhero', 'Sci-fi'],
    ),
    Movie(
      id: 'm3',
      title: 'Spider-Man Far From Home',
      imageUrl: 'assets/spider_man_far_from_home.png',
      director: 'Jon Watts',
      // duration: '2h 10 Min',
      rating: 4.4,
      // year: DateTime(2019),
      genres: ['Action', 'Superhero', 'Adventure'],
    ),
    Movie(
      id: 'm4',
      title: 'Star Wars: The Rise of Skywalker',
      imageUrl: 'assets/star_wars_rise_of_skywalker.png',
      director: 'J.J. Abrams',
      // duration: '2h 22 Min',
      rating: 3.4,
      // year: DateTime(2019),
      genres: ['Action', 'Sci-fi', 'Fantasy'],
    ),
    Movie(
      id: 'm5',
      title: 'Star Wars: The Last Jedi ',
      imageUrl: 'assets/star_wars_the_last_jedi.png',
      director: 'Rian Johnson',
      // duration: '2h 32 Min',
      rating: 2.3,
      // year: DateTime(2017),
      genres: ['Action', 'Sci-fi', 'Fantasy'],
    ),
    Movie(
      id: 'm6',
      title: 'Frozen 2',
      imageUrl: 'assets/frozen_2.png',
      director: 'Jennifer Lee',
      // duration: '1h 43 Min',
      rating: 4.3,
      // year: DateTime(2019),
      genres: ['Fantasy', 'Musical', 'Adventure'],
    ),
  ];
}
