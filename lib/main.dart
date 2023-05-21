import 'package:flutter/material.dart';
import 'package:pergijalan_mobile/controllers/destinasi_controller.dart';
import 'package:pergijalan_mobile/controllers/owner_business.dart';
import 'package:pergijalan_mobile/controllers/review_controller.dart';
import 'package:pergijalan_mobile/controllers/user_controller.dart';
import 'package:pergijalan_mobile/views/pages/home.dart';
import 'package:pergijalan_mobile/views/pages/login_user.dart';
import 'package:pergijalan_mobile/views/widgets/bar_mainnavigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DestinasiController>(create: (_)=>DestinasiController()),
        ChangeNotifierProvider<ReviewController>(create: (_)=>ReviewController()),
        ChangeNotifierProvider<UserController>(create: (_)=>UserController()),
        ChangeNotifierProvider<OwnerBusinessController>(create: (_)=>OwnerBusinessController()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PergiJalan',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: const MainNavigation(),
          home: const LoginUser(),
        ),
    );
  }
}
