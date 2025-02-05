import 'package:freezed_annotation/freezed_annotation.dart';
part 'videoModel.freezed.dart';

part 'videoModel.g.dart';

@freezed
class VideoModel with _$VideoModel {
  const factory VideoModel({
    required String id,
    required String url,
  }) = _VideoModel;

  factory VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);
}
