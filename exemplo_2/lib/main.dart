import 'package:exemplo_2/models/movie_favorites_db.dart';
import 'package:exemplo_2/pages/splash_screen.dart'; // Importando a SplashScreen
import 'package:flutter/material.dart';

final MoviesFavoriteDB favoritesDatabase = MoviesFavoriteDB();

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: SplashScreen(), // Alterado para SplashScreen
    );
  }
}
