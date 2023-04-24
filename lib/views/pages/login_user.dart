import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/controllers/user_controller.dart';
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: InkWell(
                 onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomePageOwner()));
                            },
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: descColor,
                ),
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
                padding:
                    const EdgeInsets.only(top: 2.0, left: 17.0, right: 17.0),
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
                    decoration:  InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 16),
                    ),
                  ),
              ),
            ),
           Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
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
                          padding: const EdgeInsets.symmetric(horizontal: 12),
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
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: InkWell(
                onTap: () async {
                  final userCon =
                        Provider.of<UserController>(context, listen: false);

                  //check if theres email or password not being filled
                  if(emailController.text.isEmpty && passwordController.text.isEmpty) {
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
                    } else if(passwordController.text.isEmpty) {
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
                    if(isEmailValid == false){
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

                    try{
                      await userCon.loginUser(emailController.text, passwordController.text);

                      if(userCon.statusCodeLogin == 200){
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
                      } else if(userCon.statusCodeLogin == 422){
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
                          msg: "Terjadi error : ${userCon.statusCodeLogin}\n Mohon coba lagi nanti",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red[300],
                          textColor: Colors.white,
                          fontSize: 16.0);
                        return;
                      }
                    }  catch (e){
                      setState(() {
                        isLoading=false;
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterUser()));
                        },
                        child: Text(
                          "Daftar disini",
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: secondaryColor,
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
          ]),
        ),
      ),
    );
  }
}
