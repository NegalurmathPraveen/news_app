// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDataModel _$NewsDataModelFromJson(Map<String, dynamic> json) =>
    NewsDataModel(
      uuid: json['uuid'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      keywords: json['keywords'] as String,
      snippet: json['snippet'] as String,
      url: json['url'] as String,
      imageUrl: json['image_url'] as String?,
      language: json['language'] as String,
      publishedAt: DateTime.parse(json['published_at'] as String),
      source: json['source'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      relevanceScore: json['relevance_score'],
    );

Map<String, dynamic> _$NewsDataModelToJson(NewsDataModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'description': instance.description,
      'keywords': instance.keywords,
      'snippet': instance.snippet,
      'url': instance.url,
      'image_url': instance.imageUrl,
      'language': instance.language,
      'published_at': instance.publishedAt.toIso8601String(),
      'source': instance.source,
      'categories': instance.categories,
      'relevance_score': instance.relevanceScore,
    };
