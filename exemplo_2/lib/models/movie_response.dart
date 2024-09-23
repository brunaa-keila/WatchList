import 'package:exemplo_2/models/movie.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {
  final List<Movie> results;

  const MovieResponse({required this.results});
  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
}
