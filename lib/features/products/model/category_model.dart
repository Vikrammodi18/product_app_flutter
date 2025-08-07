// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
      json.decode(str).map((x) => CategoryModel.fromJson(x)),
    );

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  final String slug;
  final String name;
  final String url;

  CategoryModel({required this.slug, required this.name, required this.url});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(slug: json["slug"], name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"slug": slug, "name": name, "url": url};
}
