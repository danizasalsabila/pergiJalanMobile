
import 'package:flutter/material.dart';
import 'package:pergijalan_mobile/views/pages/login_user.dart';
import 'package:pergijalan_mobile/views/widgets/bar_mainnavigation.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);
  static const routeName = '/splashscreen_page';

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      backgroundColor: Color.fromARGB(255, 0, 162, 184),
      imageSrc: 'assets/logo/logo_splashscreen.png',
      imageSize: 170,
      navigateRoute:  MainNavigation(),
      // navigateRoute: const LoginUser(),
      duration: 500,
    );
  }
}
