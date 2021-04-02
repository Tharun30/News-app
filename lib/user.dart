class User {
  late int id;
  late String date;
  late String jetpackFeaturedMediaUrl;

  User(
      {this.id = 0, required this.date, required this.jetpackFeaturedMediaUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    jetpackFeaturedMediaUrl = json['jetpack_featured_media_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['jetpack_featured_media_url'] = this.jetpackFeaturedMediaUrl;
    return data;
  }
}
