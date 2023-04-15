import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 60,
          ),
          Center(
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.3,
              color: Colors.black,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Text(
                "Temukan kemudahan akses untuk menemukan tempat wisata kesukaanmu"),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Text(
                "Yuk, Masuk ke Akunmu Sekarang"),
          ),
          TextField()
        ]),
      ),
    );
  }
}
