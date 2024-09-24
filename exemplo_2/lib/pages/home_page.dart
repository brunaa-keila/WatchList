import 'dart:async';
import 'package:exemplo_2/main.dart';
import 'package:exemplo_2/models/movie.dart';
import 'package:exemplo_2/models/movie_response.dart';
import 'package:exemplo_2/pages/movie_detail_page.dart';
import 'package:exemplo_2/pages/favorites_page.dart';
import 'package:exemplo_2/services/movie_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Movie> _movies = [];
  List<Movie> _favoriteMovies = [];
  int _page = 1;
  bool _isLoading = false;
  bool _isSearching = false;
  String _searchQuery = '';

  final String _apiKey = '8c4edab7f1d2cc01cb82063fd29a13d3';
  final MovieServices service = MovieServices();

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    try {
      setState(() {
        _isLoading = true; // Inicie o carregamento
      });
      final response = await service.fetchMovies(page: _page);
      setState(() {
        _movies.addAll(response.results); // Adicione os resultados
        _isLoading = false; // Pare o carregamento
      });
      print(
          'Filmes carregados: ${_movies.length}'); // Verifique a quantidade de filmes
    } catch (e) {
      setState(() {
        _isLoading = false; // Pare o carregamento em caso de erro
      });
      print('Erro ao carregar filmes: $e'); // Log do erro
    }
  }

  void _loadMoreMovies(ScrollNotification scrollInfo) {
    if (!_isLoading &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      setState(() {
        _isLoading = true;
        _page++;
      });
      _fetchMovies().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void _toggleFavorite(Movie movie) {
    setState(() {
      if (favoritesDatabase.isFavoriteFor(id: movie.id)) {
        _favoriteMovies.remove(movie);
      } else {
        _favoriteMovies.add(movie);
      }
      favoritesDatabase.updateFavoriteFor(id: movie.id);
    });
  }

  void _navigateToFavorites() {
    final favoriteIds = favoritesDatabase.getAllFavoriteIds();
    final favoriteMovies =
        _movies.where((movie) => favoriteIds.contains(movie.id)).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesPage(
          favoriteMovies: favoriteMovies,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Text(
            'Watch List',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 178, 122, 192),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching; // Alterna a pesquisa
                  if (!_isSearching) {
                    _searchQuery =
                        ''; // Limpa a consulta quando a pesquisa é fechada
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (_isSearching)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Pesquisar...',
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                _loadMoreMovies(scrollInfo);
                return false;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _movies.isNotEmpty
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _movies.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 28.0,
                                childAspectRatio: 0.5,
                              ),
                              itemBuilder: (context, index) {
                                final movie = _movies[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetailPage(
                                          movie: movie,
                                          onFavoriteToggle: _toggleFavorite,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color:
                                          const Color.fromARGB(31, 238, 3, 247),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Image.network(
                                              movie.thumbnailUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            movie.title,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : _isLoading
                              ? CircularProgressIndicator() // Exibe um indicador de carregamento
                              : Text(
                                  'Nenhum filme encontrado'), // Mensagem caso não haja filmes
                    ),
                    if (_isLoading) CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (index == 1) {
              _navigateToFavorites(); // Navegar para a página de favoritos
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Favoritos',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 76, 4, 88),
        unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Color.fromARGB(255, 178, 122, 192),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
