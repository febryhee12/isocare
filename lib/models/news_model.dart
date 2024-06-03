class NewsModel {
  late int id;
  late int newsCategoryId;
  late String title;
  late String coverImage;
  late String content;
  late String source;
  late String createdAt;
  late String coverImageLink;
  late String newsCategoryName;

  NewsModel(
      {required this.id,
      required this.newsCategoryId,
      required this.title,
      required this.coverImage,
      required this.content,
      required this.source,
      required this.createdAt,
      required this.coverImageLink,
      required this.newsCategoryName});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    newsCategoryId = json['news_category_id'] ?? 0;
    title = json['title'] ?? "";
    coverImage = json['cover_image'] ?? "";
    content = json['content'] ?? "";
    source = json['source'] ?? "";
    createdAt = json['created_at'] ?? "";
    coverImageLink = json['cover_image_link'] ?? "";
    newsCategoryName = json['news_category_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['news_category_id'] = newsCategoryId;
    data['title'] = title;
    data['cover_image'] = coverImage;
    data['content'] = content;
    data['source'] = source;
    data['created_at'] = createdAt;
    data['cover_image_link'] = coverImageLink;
    data['news_category_name'] = newsCategoryName;
    return data;
  }
}
