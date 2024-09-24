import 'dart:convert';

import 'package:exemplo_2/models/movie_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final class MovieServices {
  final String baseUrl = 'https://api.themoviedb.org/3';

  Map<String, String> _defaultHeaders() {
    return {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YzRlZGFiN2YxZDJjYzAxY2I4MjA2M2ZkMjlhMTNkMyIsIm5iZiI6MTcyNzEzNjYzNC43MDU0MTUsInN1YiI6IjY2ZWYwYTNmYzIzNzI1OGU0YzI1Zjg2NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QJOA4dHE8b1dmJg7o2ERhDap3uJ6Qoy_xjZnUh4i1iQ',
      'accept': 'application/json',
    };
  }

  Future<MovieResponse> fetchMovies({page = int}) async {
    final uri = Uri.parse('$baseUrl/movie/popular?page=$page');
    final response = await http.get(uri, headers: _defaultHeaders());

    if (response.statusCode == 200) {
      final movieResponse = MovieResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
      return movieResponse;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
