import 'package:exemplo_2/models/movie_favorites_db.dart';
import 'package:flutter/material.dart';
import 'package:exemplo_2/widgets/splash_screen.dart';

final MoviesFavoriteDB favoritesDatabase = MoviesFavoriteDB();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 236, 17, 236),
      ),
      home: SplashScreen(),
    );
  }
}
