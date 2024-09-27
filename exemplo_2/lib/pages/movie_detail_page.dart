import 'package:exemplo_2/main.dart';
import 'package:flutter/material.dart';
import 'package:exemplo_2/models/movie.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final Function(Movie) onFavoriteToggle;

  const MovieDetailPage({
    Key? key,
    required this.movie,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  void _toggleFavorite() {
    setState(() {
      favoritesDatabase.updateFavoriteFor(id: widget.movie.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 234, 245),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Text(
            'Detalhes do Filme',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 178, 122, 192),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                favoritesDatabase.isFavoriteFor(id: widget.movie.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: favoritesDatabase.isFavoriteFor(id: widget.movie.id)
                    ? Colors.red
                    : Colors.white,
              ),
              onPressed: _toggleFavorite,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.network(
              widget.movie.thumbnailUrl,
              fit: BoxFit.contain,
              width: 250,
              height: 280,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      widget.movie.title,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 30),
                      SizedBox(width: 10),
                      Text("Avaliação: 8.5", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Informações:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Ano: 2024"),
                  Text("Gênero: Ação, Aventura"),
                  Text("Duração: 120 min"),
                  SizedBox(height: 20),
                  Text("Sinopse:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(widget.movie.overview, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
