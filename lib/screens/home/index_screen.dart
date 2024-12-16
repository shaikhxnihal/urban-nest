import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:urban_nest/screens/home/favorites_screen.dart';
import 'package:urban_nest/screens/home/home_screen.dart';
import 'package:urban_nest/screens/home/notifications_screen.dart';
import 'package:urban_nest/screens/home/profile_screen.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentIndex = 0;
 
  final PageController _pageController = PageController(initialPage: 0, keepPage: true,);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        pageSnapping: false,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        children: const [
          HomeScreen(),
          FavouriteScreen(),
          NotificationScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        margin: const EdgeInsets.all(14),
        onTap: (p0) {
          setState(() {
            _currentIndex = p0;
            _pageController.animateToPage(p0, duration: Duration(milliseconds: 500), curve: Curves.ease);
          });
        },
        items: [
        SalomonBottomBarItem(icon: const Icon(CupertinoIcons.globe), title: const Text('Explore')),
        SalomonBottomBarItem(icon: const Icon(CupertinoIcons.heart), title: const Text('Favourites')),
        SalomonBottomBarItem(icon: const Icon(CupertinoIcons.bell), title: const Text('Notifications')),
        SalomonBottomBarItem(icon: const Icon(CupertinoIcons.person), title: const Text('Profile')),
      ])
    );
  }
}