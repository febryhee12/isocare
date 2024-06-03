class BannerModel {
  late int id;
  late String coverImage;
  late String title;
  late String content;
  late String createdAt;
  late String coverImageLink;

  BannerModel(
      {required this.id,
      required this.coverImage,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.coverImageLink});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    coverImage = json['cover_image'] ?? "";
    title = json['title'] ?? "";
    content = json['content'] ?? "";
    createdAt = json['created_at'] ?? "";
    coverImageLink = json['cover_image_link'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['cover_image'] = coverImage;
    data['title'] = title;
    data['content'] = content;
    data['created_at'] = createdAt;
    data['cover_image_link'] = coverImageLink;
    return data;
  }
}
