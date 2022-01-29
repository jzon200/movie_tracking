class Images {
  final String imageUrl;
  final String caption;
  Images({required this.imageUrl, required this.caption});

  factory Images.fromJson(dynamic json) {
    return Images(
      imageUrl: json['url'] as String,
      caption: json['caption'] as String,
    );
  }

  static List<Images> imagesFromSnapshot(List snapshot) {
    return snapshot.map((e) => Images.fromJson(e)).toList();
  }

  @override
  String toString() {
    return 'Recipe {url: $imageUrl, caption: $caption}';
  }
}
