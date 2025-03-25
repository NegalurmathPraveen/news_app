import 'package:json_annotation/json_annotation.dart';

part 'news_data_model.g.dart';

@JsonSerializable()
class NewsDataModel {
  final String uuid;
  final String title;
  final String description;
  final String keywords;
  final String snippet;
  final String url;
  @JsonKey(name: "image_url")
  final String? imageUrl;
  final String language;
  @JsonKey(name: "published_at")
  final DateTime publishedAt;
  final String source;
  final List<String> categories;
  @JsonKey(name: "relevance_score")
  final dynamic relevanceScore;

  NewsDataModel({
    required this.uuid,
    required this.title,
    required this.description,
    required this.keywords,
    required this.snippet,
    required this.url,
    this.imageUrl,
    required this.language,
    required this.publishedAt,
    required this.source,
    required this.categories,
    required this.relevanceScore
  });

  factory NewsDataModel.fromJson(Map<String, dynamic> json) => _$NewsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsDataModelToJson(this);
}