import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final String title;
  final String overview;
  final int id;

  @JsonKey(name: 'poster_path')
  final String thumbnail;
  String get thumbnailUrl => 'https://image.tmdb.org/t/p/w500$thumbnail';

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.thumbnail,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
