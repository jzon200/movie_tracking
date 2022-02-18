import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/cloud_firestore/firestore_movie.dart';
import 'user_ratings.dart';

class Movie {
  final String? titleId;
  final String? title;
  final String? overview;
  final String? imageUrl;
  final int? duration;
  final double? rating;
  final int? year;
  final List<String>? genres;
  String? documentId;
  String? director;
  List<String?>? actorsProfile;
  // bool isWatchlist;

  Movie({
    this.documentId,
    this.titleId,
    this.title,
    this.imageUrl,
    this.overview,
    this.director,
    this.duration,
    this.rating,
    this.year,
    this.genres,
    this.actorsProfile,
    // this.isWatchlist = false,
  });

  @override
  String toString() {
    return {
      'id': titleId,
      'title': title,
      'overview': overview,
      'imageUrl': imageUrl,
      'director': director,
      'duration': duration,
      'rating': rating,
      'year': year,
      'genres': genres,
    }.toString();
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      titleId: json['id'],
      title: json['title']['title'],
      overview: json['plotOutline']['text'],
      imageUrl: json['title']['image']['url'],
      duration: json['title']['runningTimeInMinutes'],
      rating: json['ratings']['rating'],
      year: json['title']['year'],
      genres: json['genres'].cast<String>(),
    );
  }

  FirestoreMovie toFirestore() {
    return FirestoreMovie(
      titleId: titleId,
      title: title,
      overview: overview,
      imageUrl: imageUrl,
      duration: duration,
      rating: rating,
      year: year,
      genres: genres,
      director: director,
      // isWatchlist: isWatchlist,
      actorsProfile: actorsProfile,
    );
  }

  String getRating(double? rating) {
    if (rating == null) {
      return 'No ratings yet';
    }
    return rating.toString();
  }

  String getDirector(String? director) {
    if (director == null) {
      return 'N/A';
    }
    return director;
  }

  static List<Movie> movieInfo = [
    Movie(
      titleId: 'm1',
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
      titleId: 'm2',
      title: 'Avengers: Endgame',
      imageUrl: 'assets/avengers_endgame.png',
      director: 'Joe Russo',
      // duration: '3h 2 Min',
      rating: 4.7,
      // year: DateTime(2019),
      genres: ['Action', 'Superhero', 'Sci-fi'],
    ),
    Movie(
      titleId: 'm3',
      title: 'Spider-Man Far From Home',
      imageUrl: 'assets/spider_man_far_from_home.png',
      director: 'Jon Watts',
      // duration: '2h 10 Min',
      rating: 4.4,
      // year: DateTime(2019),
      genres: ['Action', 'Superhero', 'Adventure'],
    ),
    Movie(
      titleId: 'm4',
      title: 'Star Wars: The Rise of Skywalker',
      imageUrl: 'assets/star_wars_rise_of_skywalker.png',
      director: 'J.J. Abrams',
      // duration: '2h 22 Min',
      rating: 3.4,
      // year: DateTime(2019),
      genres: ['Action', 'Sci-fi', 'Fantasy'],
    ),
    Movie(
      titleId: 'm5',
      title: 'Star Wars: The Last Jedi ',
      imageUrl: 'assets/star_wars_the_last_jedi.png',
      director: 'Rian Johnson',
      // duration: '2h 32 Min',
      rating: 2.3,
      // year: DateTime(2017),
      genres: ['Action', 'Sci-fi', 'Fantasy'],
    ),
    Movie(
      titleId: 'm6',
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
