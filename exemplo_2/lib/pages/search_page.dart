import 'dart:async';
import 'package:exemplo_2/models/movie.dart';
import 'package:exemplo_2/services/movie_services.dart';
import 'package:flutter/material.dart';
import 'movie_detail_page.dart';

class SearchPage extends StatefulWidget {
  final String searchMovies;

  const SearchPage({
    Key? key,
    required this.searchMovies,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  List<Movie> _movies = [];
  bool _isLoading = false;
  bool _isSearching = false;

  final SearchServices service = SearchServices();

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
      final response =
          await service.fetchMovies(searchQuery: widget.searchMovies);
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
      });
      _fetchMovies().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
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
            'Filmes pesquisados',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 178, 122, 192),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          if (_isSearching)
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                                          onFavoriteToggle: (isFavorite) {},
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
    );
  }
}
