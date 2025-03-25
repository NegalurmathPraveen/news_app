// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_news_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllNewsResponseModel _$AllNewsResponseModelFromJson(
        Map<String, dynamic> json) =>
    AllNewsResponseModel(
      meta: MetaDataModel.fromJson(json['meta'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>)
          .map((e) => NewsDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllNewsResponseModelToJson(
        AllNewsResponseModel instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'data': instance.data,
    };
