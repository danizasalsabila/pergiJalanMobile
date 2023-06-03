import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/controllers/user_controller.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/login_owner.dart';
import 'package:pergijalan_mobile/views/pages/register_user.dart';
import 'package:provider/provider.dart';

import '../../config/theme_color.dart';
import '../widgets/bar_mainnavigation.dart';
import 'business_owner/home.dart';

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
  void initState() {
    print(" ");
    print("-------------DIRECT TO LOGIN PAGE-----------");
  }

  @override
  void toggleShow() {
    isObscureText = !isObscureText;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // appBar: AppBar(backgroundColor: backgroundColor, elevation: 0, actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 20.0, top: 20),
      //     child: Align(
      //         alignment: Alignment.topRight,
      //         child: InkWell(
      //           onTap: (){
      //              Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => const LoginOwner()));
      //           },
      //           child: Container(
      //             decoration: BoxDecoration(
      //                 color: thirdColor, borderRadius: BorderRadius.circular(10)),
      //             height: 22,
      //             width: 60,
      //             child: Center(
      //               child: Text(
      //                 "Bisnis",
      //                 style:
      //                     GoogleFonts.openSans(color: Colors.white, fontSize: 12),
      //               ),
      //             ),
      //           ),
      //         )),
      //   ),
      // ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 480,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Image.asset(
                    'assets/background/login_user_bg.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 17.0, right: 17.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginOwner()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 92, 92, 92)
                                        .withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        2, 0), // changes position of shadow
                                  ),
                                ],
                                color: thirdColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 4, 8, 4),
                              child: Text(
                                "Promosi Tempat Wisata",
                                textAlign: TextAlign.end,
                                style: GoogleFonts.openSans(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 17.0,
                        right: 17.0,
                      ),
                      child: Text(
                        "Temukan kemudahan akses untuk menemukan tempat wisata kesukaanmu",
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 17.0, right: 17.0),
                        child: Text(
                          "Yuk, Masuk ke Akunmu Sekarang",
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: primaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 16.0),
                    //   child: Align(
                    //     alignment: Alignment.topLeft,
                    //     child: Text(
                    //       "Email",
                    //       style: GoogleFonts.openSans(
                    //           fontSize: 14,
                    //           color: Colors.grey.shade500,
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300),
                        child: TextField(
                          style: GoogleFonts.openSans(
                              fontSize: 13,
                              color: titleColor,
                              fontWeight: FontWeight.w600),
                          onChanged: (text) {
                            setState(() {
                              isEmailValid = EmailValidator.validate(text);
                            });
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 16),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 16.0, top: 16),
                    //   child: Align(
                    //     alignment: Alignment.topLeft,
                    //     child: Text(
                    //       "Password",
                    //       style: GoogleFonts.openSans(
                    //           fontSize: 14,
                    //           color: Colors.grey.shade500,
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: GoogleFonts.openSans(
                              fontSize: 13,
                              color: titleColor,
                              fontWeight: FontWeight.w600),
                          onChanged: (text) {
                            setState(() {
                              isPasswordValid = text.length >= 6;
                            });
                          },
                          obscureText: isObscureText,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  toggleShow();
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: isObscureText
                                    ? const Icon(Icons.remove_red_eye,
                                        size: 21, color: descColor)
                                    : const Icon(Icons.close,
                                        size: 21, color: descColor),
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: InkWell(
                        onTap: () async {
                          final userCon = Provider.of<UserController>(context,
                              listen: false);

                          //check if theres email or password not being filled
                          if (emailController.text.isEmpty &&
                              passwordController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Masukkan email dan password anda",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red[300],
                                textColor: Colors.white,
                                fontSize: 16.0);
                            return;
                          } else if (emailController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Masukkan email anda",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red[300],
                                textColor: Colors.white,
                                fontSize: 16.0);
                            return;
                          } else if (passwordController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Masukkan password anda",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red[300],
                                textColor: Colors.white,
                                fontSize: 16.0);
                            return;
                          }

                          //check if email that user input is with valid domain
                          if (isEmailValid == false) {
                            Fluttertoast.showToast(
                                msg: "Mohon masukkan email yang valid",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red[300],
                                textColor: Colors.white,
                                fontSize: 16.0);
                            return;
                          }
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            await userCon.loginUser(
                                emailController.text, passwordController.text);

                            if (userCon.statusCodeLogin == 200) {
                              print("login success");
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainNavigation()),
                                  (route) => false);
                            } else if (userCon.statusCodeLogin == 422) {
                              print("login failed");
                              setState(() {
                                isLoading = false;
                              });
                              Fluttertoast.showToast(
                                  msg: userCon.messageLogin.toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red[300],
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              return;
                            } else {
                              print("login failed");
                              setState(() {
                                isLoading = false;
                              });
                              Fluttertoast.showToast(
                                  msg:
                                      "Terjadi error : ${userCon.statusCodeLogin}\n Mohon coba lagi nanti",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red[300],
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              return;
                            }
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(
                                msg: "Terjadi error",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red[300],
                                textColor: Colors.white,
                                fontSize: 16.0);
                            return;
                          }
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
                                offset: const Offset(
                                    3, 3), // changes position of shadow
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
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Text(
                                "Belum memiliki akun? ",
                                style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w500),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Provider.of(context, listen: false);
                                  // Get.to(
                                  //   RegisterUser(),
                                  //   duration: Duration(seconds: 1),
                                  //   transition: Transition.rightToLeftWithFade
                                  // );

                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const RegisterUser(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(
                                              1.0, 0.0); // Mulai dari kanan
                                          var end = Offset.zero;
                                          var curve =
                                              Curves.ease; // Kurva animasi

                                          var tween =
                                              Tween(begin: begin, end: end);
                                          var curvedAnimation = CurvedAnimation(
                                            parent: animation,
                                            curve: curve,
                                          );

                                          return SlideTransition(
                                            position:
                                                tween.animate(curvedAnimation),
                                            child: child,
                                          );
                                        },
                                      ));
                                },
                                child: Text(
                                  "Daftar disini",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      color: thirdColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          )
                          // Text.rich(
                          //   TextSpan(text: "", children: [
                          //     TextSpan(text: "Belum memiliki akun? "),
                          //     TextSpan(text: "Daftar disini"),
                          //   ]),
                          //   ),
                          ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
