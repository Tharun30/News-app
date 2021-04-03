class Bookmark {
  final int id;
  final String image;
  final String date;

  Bookmark({required this.id, required this.image, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'date': date,
    };
  }
}
