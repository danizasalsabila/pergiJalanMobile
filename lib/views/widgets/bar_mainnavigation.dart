import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/views/pages/home.dart';
import 'package:pergijalan_mobile/views/pages/search2.dart';
import 'package:pergijalan_mobile/views/pages/search_page.dart';
import 'package:pergijalan_mobile/views/pages/user_page.dart';

class MainNavigation extends StatefulWidget {
  int indexNav;
  MainNavigation({
    Key? key,
    this.indexNav = 0,
  }) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _indexBNav = 0;
  final List<Widget> _widgetOptions = [
    HomePage(),
    SearchPage(),
    UserPage(),
  ];

  @override
  void initState() {
    super.initState();
    _indexBNav = widget.indexNav;
  }

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
              color: const Color.fromARGB(255, 190, 190, 190).withOpacity(0.7),
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
              title: const Text("Beranda"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text("Pencarian"),
            ),
            SalomonBottomBarItem(
              icon: const FaIcon(
                FontAwesomeIcons.solidUser,
                size: 17,
              ),
              title: const Text("Saya"),
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
