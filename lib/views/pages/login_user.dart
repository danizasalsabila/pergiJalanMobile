import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/views/pages/register_user.dart';

import '../../config/theme_color.dart';
import '../widgets/bar_mainnavigation.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEmailValid = false;
  bool isPasswordValid = false;
  String emailTemporary = '';
  bool isObscureText = true;
  bool isLoading = false;

  @override
  void toggleShow() {
    isObscureText = !isObscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.3,
                color: descColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                left: 17.0,
                right: 17.0,
              ),
              child: Text(
                "Temukan kemudahan akses untuk menemukan tempat wisata kesukaanmu",
                style: GoogleFonts.openSans(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 17.0, right: 17.0),
                child: Text(
                  "Yuk, Masuk ke Akunmu Sekarang",
                  style: GoogleFonts.openSans(
                      fontSize: 20,
                      color: secondaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300),
                child: TextField(
                  style: GoogleFonts.openSans(
                      fontSize: 13,
                      color: descColor,
                      fontWeight: FontWeight.w600),
                  onChanged: (text) {
                    setState(() {
                      isEmailValid = EmailValidator.validate(text);
                      emailTemporary = text;
                      print(emailController);
                    });
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  style: GoogleFonts.openSans(
                      fontSize: 13,
                      color: descColor,
                      fontWeight: FontWeight.w600),
                  onChanged: (text) {
                    setState(() {
                      isPasswordValid = text.length >= 6;
                      print("password $text");
                    });
                  },
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: InkWell(
                onTap: () {
                  print("email: $emailTemporary");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainNavigation()));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 211, 211, 211)
                            .withOpacity(0.7),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(3, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text(
                    "Masuk",
                    style: GoogleFonts.openSans(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )),
                  
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 8.0, 17, 0),
              child: SizedBox(width: MediaQuery.of(context).size.width,
              child: Row(children: [
                Text("Belum memiliki akun? ",style: GoogleFonts.openSans(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500),),
                InkWell(
                    onTap: (){
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterUser()));
                  },
                  child: Text("Daftar disini",
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: secondaryColor,
                      fontWeight: FontWeight.w600),),
                )
              ],)
              // Text.rich(
              //   TextSpan(text: "", children: [
              //     TextSpan(text: "Belum memiliki akun? "),
              //     TextSpan(text: "Daftar disini"),
              //   ]),
              //   ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
