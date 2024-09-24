import 'package:exemplo_2/main.dart';
import 'package:flutter/material.dart';
import 'package:exemplo_2/models/movie.dart';

class FavoritesPage extends StatefulWidget {
  final List<Movie> favoriteMovies;

  const FavoritesPage({
    Key? key,
    required this.favoriteMovies,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FavoritesPage();
  }
}

class _FavoritesPage extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        backgroundColor: Color.fromARGB(255, 178, 122, 192),
      ),
      body: ListView.builder(
        itemCount: widget.favoriteMovies.length,
        itemBuilder: (context, index) {
          final movie = widget.favoriteMovies[index];
          return ListTile(
            title: Text(movie.title),
            trailing: IconButton(
              icon: Icon(
                favoritesDatabase.isFavoriteFor(id: movie.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: favoritesDatabase.isFavoriteFor(id: movie.id)
                    ? Colors.red
                    : const Color.fromARGB(255, 187, 74, 187),
              ),
              onPressed: () {
                setState(() {
                  favoritesDatabase.updateFavoriteFor(id: movie.id);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
