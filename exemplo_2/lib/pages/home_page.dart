import 'dart:async';
import 'dart:convert';
import 'package:exemplo_2/models/movie.dart';
import 'package:exemplo_2/models/movie_response.dart';
import 'package:exemplo_2/pages/movie_detail_page.dart';
import 'package:exemplo_2/pages/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController(viewportFraction: 0.8);
  int _selectedIndex = 0;
  int _carouselIndex = 0;
  List<Movie> _movies = [];
  List<Movie> _favoriteMovies = [];
  Timer? _timer;
  int _page = 1;
  bool _isLoading = false;

  final String _apiKey = '8c4edab7f1d2cc01cb82063fd29a13d3';
  final String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey&page=$_page'));

    if (response.statusCode == 200) {
      final movieResponse = MovieResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
      setState(() {
        _movies.addAll(movieResponse.results);
      });
    } else {
      throw Exception('Failed to load movies');
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
      if (_favoriteMovies.contains(movie)) {
        _favoriteMovies.remove(movie);
      } else {
        _favoriteMovies.add(movie);
      }
    });
  }

  void _navigateToFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesPage(
          favoriteMovies: _favoriteMovies,
          onFavoriteToggle: _toggleFavorite, // Passando a função
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
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
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          _loadMoreMovies(scrollInfo);
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 170,
                child: _movies.isNotEmpty
                    ? PageView.builder(
                        controller: _pageController,
                        itemCount: _movies.length,
                        itemBuilder: (context, index) {
                          final movie = _movies[index];
                          return Transform(
                            transform: Matrix4.identity()..scale(1.0, 1.0, 1.0),
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(66, 78, 226, 231),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      movie.thumbnailUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.black54,
                                              Colors.transparent,
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          movie.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: IconButton(
                                        icon: Icon(
                                          _favoriteMovies.contains(movie)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                        onPressed: () => _toggleFavorite(movie),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        onPageChanged: (index) {
                          setState(() {
                            _carouselIndex = index;
                          });
                        },
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _movies.length,
                  (index) => Container(
                    margin: EdgeInsets.all(4),
                    width: 8,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _carouselIndex == index
                          ? const Color.fromARGB(255, 128, 21, 128)
                          : const Color.fromARGB(255, 185, 118, 206),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _movies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                              onFavoriteToggle:
                                  _toggleFavorite, // Passando a função de toggle
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: const Color.fromARGB(31, 238, 3, 247),
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
                ),
              ),
              if (_isLoading) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (index == 1) {
              _navigateToFavorites(); // Navega para a página de favoritos
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
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 76, 4, 88),
        unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        backgroundColor: const Color.fromARGB(255, 216, 143, 223),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
