import 'dart:convert';
import 'package:exemplo_2/models/movie_response.dart';
import 'package:http/http.dart' as http;

String baseUrl = 'https://api.themoviedb.org/3';

String _apiKey = 'SUA_CHAVE_API_AQUI';

final class MovieServices {
  Future<MovieResponse> fetchMovies({page = int}) async {
    final uri = Uri.parse('$baseUrl/movie/popular?page=$page&api_key=$_apiKey');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final movieResponse = MovieResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
      return movieResponse;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}

final class SearchServices {
  Future<MovieResponse> fetchMovies({searchQuery = String}) async {
    final uri = Uri.parse(
        '$baseUrl/search/movie?query=$searchQuery&include_adult=false&language=en-US&include_image_language=en,null&page=1&api_key=$_apiKey');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final movieResponse = MovieResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
      return movieResponse;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
