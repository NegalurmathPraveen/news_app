import 'package:json_annotation/json_annotation.dart';

part 'meta_data_model.g.dart';

@JsonSerializable()
class MetaDataModel {
  final int found;
  final int returned;
  final int limit;
  final int page;
  bool hasMaxReached;

  MetaDataModel({
    required this.found,
    required this.returned,
    required this.limit,
    required this.page,
    this.hasMaxReached = true
  });

  factory MetaDataModel.fromJson(Map<String, dynamic> json) => _$MetaDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataModelToJson(this);
}