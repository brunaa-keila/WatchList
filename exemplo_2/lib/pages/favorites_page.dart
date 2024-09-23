import 'package:flutter/material.dart';
import 'package:exemplo_2/models/movie.dart';

class FavoritesPage extends StatelessWidget {
  final List<Movie> favoriteMovies;
  final Function(Movie) onFavoriteToggle;

  const FavoritesPage({
    Key? key,
    required this.favoriteMovies,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        backgroundColor: Color.fromARGB(255, 178, 122, 192),
      ),
      body: ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          final movie = favoriteMovies[index];
          return ListTile(
            title: Text(movie.title),
            trailing: IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () => onFavoriteToggle(movie),
            ),
          );
        },
      ),
    );
  }
}
