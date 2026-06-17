import 'package:flutter/material.dart';
import 'package:novaflix/models/movie.dart';
import 'package:novaflix/main.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int _currentIndex = 0;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Category> _categories = [
    Category(
      name: 'Trending Now',
      movies: [
        Movie(
          title: 'The Great Adventure',
          genre: 'Action',
          year: 2023,
          maturity: '13+',
          duration: '2h 15m',
          matchPercent: 98,
          description:
              'A thrilling journey across uncharted lands in search of ancient treasures and lost civilizations.',
          color: Colors.blue,
        ),
        Movie(
          title: 'Silent Echoes',
          genre: 'Thriller',
          year: 2022,
          maturity: '16+',
          duration: '1h 45m',
          matchPercent: 94,
          description:
              'In a town where everyone knows each other, a mysterious disappearance reveals dark secrets.',
          color: Colors.purple,
        ),
        Movie(
          title: 'Neon Nights',
          genre: 'Sci-Fi',
          year: 2024,
          maturity: '18+',
          duration: '2h 30m',
          matchPercent: 96,
          description:
              'In a futuristic metropolis, a renegade hacker discovers a conspiracy that could change humanity.',
          color: Colors.cyan,
        ),
      ],
    ),
    Category(
      name: 'Popular on StreamFlix',
      movies: [
        Movie(
          title: 'Love in Paris',
          genre: 'Romance',
          year: 2023,
          maturity: 'All',
          duration: '1h 50m',
          matchPercent: 92,
          description:
              'Two strangers find unexpected love during a rainy weekend in the city of lights.',
          color: Colors.pink,
        ),
        Movie(
          title: 'The Last Stand',
          genre: 'War',
          year: 2021,
          maturity: '16+',
          duration: '2h 40m',
          matchPercent: 89,
          description:
              'A small group of soldiers must defend a vital outpost against overwhelming odds.',
          color: Colors.orange,
        ),
        Movie(
          title: 'Space Explorers',
          genre: 'Documentary',
          year: 2024,
          maturity: 'All',
          duration: '1h 20m',
          matchPercent: 99,
          description:
              'A breathtaking look at the latest missions to explore our solar system and beyond.',
          color: Colors.indigo,
        ),
      ],
    ),
    Category(
      name: 'Ghanaian Cinema',
      movies: [
        Movie(
          title: 'The Burial of Kojo',
          genre: 'Drama',
          year: 2018,
          maturity: '13+',
          duration: '1h 20m',
          matchPercent: 95,
          description:
              'A man is left to die in an abandoned mine shaft as his young daughter travels through a spirit world to save him.',
          color: Colors.brown,
        ),
        Movie(
          title: 'Keteke',
          genre: 'Comedy',
          year: 2017,
          maturity: '13+',
          duration: '1h 38m',
          matchPercent: 91,
          description:
              'A couple is determined to give birth in their village, but they miss their train and get stranded in the middle of nowhere.',
          color: Colors.teal,
        ),
        Movie(
          title: 'Azali',
          genre: 'Drama',
          year: 2018,
          maturity: '16+',
          duration: '1h 32m',
          matchPercent: 88,
          description:
              'A 14-year-old girl is sent to the city to escape an arranged marriage, but she finds herself in the slums of Accra.',
          color: Colors.blueGrey,
        ),
      ],
    ),
  ];

  List<Movie> get _allMovies =>
      _categories.expand((category) => category.movies).toList();

  List<Movie> get _filteredMovies => _allMovies
      .where((movie) =>
          movie.title.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 1 // Search tab
          ? AppBar(
              backgroundColor: StreamFlix.novaBlack,
              title: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search for a movie, genre...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              actions: [
                if (_searchQuery.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  ),
              ],
            )
          : AppBar(
              title: const Text(
                'STREAMFLIX',
                style: TextStyle(
                  color: StreamFlix.novaRed,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              backgroundColor: StreamFlix.novaBlack,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => setState(() => _currentIndex = 1),
                ),
                IconButton(icon: const Icon(Icons.person), onPressed: () {}),
              ],
            ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Home Tab
          _buildHomeTab(),
          // Search Tab
          _buildSearchTab(),
          // Coming Soon Tab
          const Center(child: Text('Coming Soon')),
          // Profile Tab
          const Center(child: Text('Profile')),
          // New & Hot Tab
          const Center(child: Text('New & Hot')),
          // Downloads Tab
          const Center(child: Text('Downloads')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: StreamFlix.novaBlack,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.upcoming),
            label: 'Coming Soon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'New & Hot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Downloads',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return ListView.builder(
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                category.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.movies.length,
                itemBuilder: (context, movieIndex) {
                  final movie = category.movies[movieIndex];
                  return _buildMovieCard(movie);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchTab() {
    if (_searchQuery.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 100, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Find your next favorite movie',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ],
        ),
      );
    }

    if (_filteredMovies.isEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _filteredMovies.length,
      itemBuilder: (context, index) {
        final movie = _filteredMovies[index];
        return _buildMovieCard(movie);
      },
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detail',
          arguments: movie,
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: movie.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            movie.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(blurRadius: 10, color: Colors.black),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
