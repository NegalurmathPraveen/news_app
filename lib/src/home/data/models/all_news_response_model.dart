import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/src/home/data/models/meta_data_model.dart';

import 'news_data_model.dart';

part 'all_news_response_model.g.dart';

@JsonSerializable()
class AllNewsResponseModel {
  final MetaDataModel meta;
  final List<NewsDataModel> data;

  AllNewsResponseModel({
    required this.meta,
    required this.data,
  });

  factory AllNewsResponseModel.fromJson(Map<String, dynamic> json) => _$AllNewsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllNewsResponseModelToJson(this);
}
