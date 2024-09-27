import 'dart:async';
import 'package:exemplo_2/main.dart';
import 'package:exemplo_2/models/movie.dart';
import 'package:exemplo_2/pages/movie_detail_page.dart';
import 'package:exemplo_2/pages/favorites_page.dart';
import 'package:exemplo_2/pages/search_page.dart';
import 'package:exemplo_2/services/movie_services.dart';
import 'package:flutter/material.dart';
import 'package:exemplo_2/widgets/BottomNavigationBar.dart';

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

  final MovieServices service = MovieServices();

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await service.fetchMovies(page: _page);
      setState(() {
        _movies.addAll(response.results);
        _isLoading = false;
      });
      print('Filmes carregados: ${_movies.length}');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Erro ao carregar filmes: $e');
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

  void _searchMovies(final String searchMovies) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(
          searchMovies: searchMovies,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        _navigateToFavorites();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 234, 245),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Text(
            'Lista de Filmes',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 178, 122, 192),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
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
                onSubmitted: (query) => _searchMovies(query),
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
                              ? CircularProgressIndicator()
                              : Text('Nenhum filme encontrado'),
                    ),
                    if (_isLoading) CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
