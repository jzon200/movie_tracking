class Cast {
  final String id;
  final String name;
  final String? imageUrl;

  const Cast({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        id: json['id'],
        name: json['name'],
        imageUrl: json['image'] == null ? null : json['image']['url'],
      );

  Map<String, dynamic> toJson(Cast? instance) => {
        'id': instance?.id,
        'name': instance?.name,
        'image': instance?.imageUrl,
      };
  @override
  String toString() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    }.toString();
  }
}
