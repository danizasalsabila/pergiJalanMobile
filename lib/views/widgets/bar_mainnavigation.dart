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
      // backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: secondaryColor,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 190, 190, 190).withOpacity(0.7),
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(4, 1), // changes position of shadow
            ),
          ],
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
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.people),
              title: const Text("User"),
            ),
          ],
          unselectedItemColor: Colors.grey.shade300,
          selectedItemColor: Colors.white,
          margin: const EdgeInsets.fromLTRB(50, 8, 50, 8),
        ),
      ),
    );
  }
}
