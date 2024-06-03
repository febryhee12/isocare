class NewsCategoryModel {
  late int id;
  late String coverImage;
  late String name;
  late String coverImageLink;

  NewsCategoryModel(
      {required this.id,
      required this.coverImage,
      required this.name,
      required this.coverImageLink});

  NewsCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coverImage = json['cover_image'];
    name = json['name'];
    coverImageLink = json['cover_image_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cover_image'] = coverImage;
    data['name'] = name;
    data['cover_image_link'] = coverImageLink;
    return data;
  }
}
