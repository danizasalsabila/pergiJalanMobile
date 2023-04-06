import 'package:flutter/material.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/views/pages/home.dart';
import 'package:pergijalan_mobile/views/pages/search2.dart';
import 'package:pergijalan_mobile/views/pages/search_page.dart';
import 'package:pergijalan_mobile/views/pages/user_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _indexBNav = 0;
  final List<Widget> _widgetOptions = [
    HomePage(),
    SearchPageT(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_indexBNav),
      backgroundColor: Colors.white,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: SalomonBottomBar(
          onTap: (index) {
            setState(() {
              _indexBNav = index;
            });
          },
          currentIndex: _indexBNav,
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text("Search"),
            ),SalomonBottomBarItem(
              icon: const Icon(Icons.people),
              title: const Text("User"),
            ),
            
          ],
          unselectedItemColor: Colors.grey.shade300,
          selectedItemColor: primaryColor,
          margin:const EdgeInsets.fromLTRB(36, 10, 36, 10) ,
        ),
      ),
    );
  }
}
