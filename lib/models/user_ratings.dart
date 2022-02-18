class UserRatings {
  final String name;
  final String imagePath;
  final int rating;
  final String date;

  const UserRatings({
    required this.name,
    required this.imagePath,
    required this.rating,
    this.date = '07 Feb 2022',
  });

  static const List<UserRatings> userRatings = [
    UserRatings(
      name: 'Eren Jaeger',
      imagePath: 'assets/images/eren_jaeger.jpg',
      rating: 5,
    ),
    UserRatings(
      name: 'Mikasa Ackerman',
      imagePath: 'assets/images/mikasa_ackerman.jpg',
      rating: 5,
    ),
    UserRatings(
      name: 'Armin Arlert',
      imagePath: 'assets/images/armin_arlert.jpg',
      rating: 5,
    ),
    UserRatings(
      name: 'Levi',
      imagePath: 'assets/images/levi.jpg',
      rating: 4,
    ),
  ];
}
