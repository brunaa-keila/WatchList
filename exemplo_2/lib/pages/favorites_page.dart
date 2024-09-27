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
    return _FavoritesPageState();
  }
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 234, 245),
      appBar: AppBar(
        title: const Text(
          'Favoritos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 178, 122, 192),
      ),
      body: widget.favoriteMovies.isEmpty
          ? const Center(
              child: Text(
                'Nenhum filme favoritado.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: widget.favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = widget.favoriteMovies[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: const Color.fromARGB(255, 253, 225, 244),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            movie.thumbnailUrl,
                            height: 120,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              
                              Text(
                                movie.overview,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 95, 79, 79),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        IconButton(
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
                              if (!favoritesDatabase.isFavoriteFor(
                                  id: movie.id)) {
                                widget.favoriteMovies.removeAt(index);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
