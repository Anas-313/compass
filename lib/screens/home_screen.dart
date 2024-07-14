import 'package:flutter/material.dart';
import 'package:qibla/screens/qibla_compass.dart';
import 'package:qibla/screens/quran_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Qibla"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite_border),
            title: const Text("Quran"),
            selectedColor: Colors.pink,
          ),
        ],
      ),
      body: <Widget>[
        const QiblaCompass(),
        const QuranScreen(),
      ][_currentIndex],
    );
  }
}
