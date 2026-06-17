import 'package:flutter/material.dart';
import 'package:novaflix/screens/browse_screen.dart';
import 'package:novaflix/screens/detail_screen.dart';
import 'package:novaflix/screens/login_screen.dart';
import 'package:novaflix/screens/register_screen.dart';
import 'package:novaflix/screens/splash_screen.dart';
import 'package:novaflix/screens/player_screen.dart';
import 'models/movie.dart';

void main() {
  runApp(const StreamFlix());
}

class StreamFlix extends StatelessWidget {
  const StreamFlix({super.key});

  static const Color novaRed = Colors.amber;
  static const Color novaBlack = Color(0xFF121212);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamFlix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: novaBlack,
        primaryColor: novaRed,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/browse': (context) => const BrowseScreen(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final movie = settings.arguments as Movie;
          return MaterialPageRoute(
            builder: (context) => DetailScreen(movie: movie),
            settings: settings,
          );
        }
        if (settings.name == '/player') {
          final movie = settings.arguments as Movie;
          return MaterialPageRoute(
            builder: (context) => PlayerScreen(movie: movie),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
