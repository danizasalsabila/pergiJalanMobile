import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/owner_business_controller.dart';
import 'package:pergijalan_mobile/controllers/user_controller.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/home.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/register_owner.dart';
import 'package:pergijalan_mobile/views/pages/account_register_user.dart';
import 'package:pergijalan_mobile/views/widgets/bar_mainnavigation.dart';
import 'package:provider/provider.dart';

class LoginOwner extends StatefulWidget {
  const LoginOwner({super.key});

  @override
  State<LoginOwner> createState() => _LoginOwnerState();
}

class _LoginOwnerState extends State<LoginOwner> {
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
    print("-------------DIRECT TO LOGIN OWNER PAGE-----------");
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
        child: Column(children: [
          Stack(
            children: [
              SizedBox(
                height: 480,
                width: MediaQuery.of(context).size.width * 1,
                child: Image.asset(
                  'assets/background/login_owner_bg.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                      height: 160,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 18.0,
                      left: 17.0,
                      right: 17.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Akses Mudah ke Akun Bisnis \nWisata Anda",
                        style: GoogleFonts.openSans(
                            fontSize: 20,
                            color: thirdColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 2.0, left: 17.0, right: 17.0),
                      child: Text(
                        "Masuk dan kelola bisnis anda dengan lebih efisien",
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
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
                            child: isObscureText
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: FaIcon(FontAwesomeIcons.solidEye,
                                      textDirection: TextDirection.rtl,
                                      size: 18,
                                      color: descColor),
                                )
                              : const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: FaIcon(
                                      FontAwesomeIcons.solidEyeSlash,
                                      textDirection: TextDirection.rtl,
                                      size: 18,
                                      color: descColor),
                                ),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: InkWell(
              onTap: () async {
                final ownerCon = Provider.of<OwnerBusinessController>(context,
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
                  await ownerCon.loginOwnerBusiness(
                      emailController.text, passwordController.text);

                  if (ownerCon.statusCodeLoginOB == 200) {
                    print("login success");
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePageOwner()),
                        (route) => false);
                  } else if (ownerCon.statusCodeLoginOB == 422) {
                    print("login failed");
                    setState(() {
                      isLoading = false;
                    });
                    Fluttertoast.showToast(
                        msg: ownerCon.messageLoginOB.toString(),
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
                            "Terjadi error : ${ownerCon.statusCodeLoginOB}\n Mohon coba lagi nanti",
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
                  color: labelColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 211, 211, 211)
                          .withOpacity(0.7),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(3, 3), // changes position of shadow
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
                                builder: (context) => const RegisterOwner()));
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
                )),
          )
        ]),
      ),
    );
  }
}
