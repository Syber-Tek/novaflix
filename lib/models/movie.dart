import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String genre;
  final int year;
  final String maturity;
  final String duration;
  final int matchPercent;
  final String description;
  final Color color;

  const Movie({
    required this.title,
    required this.genre,
    required this.year,
    required this.maturity,
    required this.duration,
    required this.matchPercent,
    required this.description,
    required this.color,
  });
}

class Category {
  final String name;
  final List<Movie> movies;
  const Category({required this.name, required this.movies});
}
