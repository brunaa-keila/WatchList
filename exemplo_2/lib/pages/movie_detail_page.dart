import 'package:flutter/material.dart';
import 'package:exemplo_2/models/movie.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final Function(Movie) onFavoriteToggle; // Mudou para aceitar Movie

  const MovieDetailPage({
    Key? key,
    required this.movie,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  _MovieDetailPageState createState() =>
      _MovieDetailPageState(); // Certifique-se de que isso esteja aqui
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = false; // Inicializa como não favorito
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      widget.onFavoriteToggle(widget.movie); // Passa o movie
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          title: Text(
            'Watch List',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 178, 122, 192),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.white,
              ),
              onPressed: _toggleFavorite,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.movie.thumbnailUrl,
              fit: BoxFit.cover,
              width: 200,
              height: 250,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título do Filme
                  Center(
                    child: Text(
                      widget.movie.title,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Avaliação
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 30),
                      SizedBox(width: 10),
                      Text("Avaliação: 8.5", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Informações
                  Text("Informações:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Ano: 2024"),
                  Text("Gênero: Ação, Aventura"),
                  Text("Duração: 120 min"),
                  SizedBox(height: 20),
                  // Sinopse
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
