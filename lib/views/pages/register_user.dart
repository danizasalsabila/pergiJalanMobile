import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/user_controller.dart';
import 'package:pergijalan_mobile/views/pages/login_user.dart';
import 'package:provider/provider.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController idCardNumberController = TextEditingController();
  bool isPasswordAndConfirmValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  String emailTemporary = '';
  bool isObscureText = true;
  bool isLoading = false;

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO REGISTER PAGE-----------");
  }

  @override
  void toggleShow() {
    isObscureText = !isObscureText;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    idCardNumberController.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: backgroundColor,
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
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 18.0,
                    left: 17.0,
                  ),
                  child: Text(
                    "Daftarkan Akun Anda Sekarang",
                    style: GoogleFonts.openSans(
                        fontSize: 20,
                        color: secondaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 17.0,
                  top: 2.0,
                  left: 17.0,
                ),
                child: Text(
                  "Dan temukan kemudahan dan kenyamanan dalam berwisata",
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 7,
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
                        // emailTemporary = text;
                        // print(emailController);
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
                        print("password $text");
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
                        isPasswordAndConfirmValid = passwordController.text ==
                            confirmPasswordController.text;
                        print(
                            "is password & confirm password match? $isPasswordAndConfirmValid");
                      });
                    },
                    obscureText: isObscureText,
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'Konfirmasi Password',
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
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1.8,
                        color: Colors.grey.shade300,
                      )),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    style: GoogleFonts.openSans(
                        fontSize: 13,
                        color: titleColor,
                        fontWeight: FontWeight.w600),
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration:  InputDecoration(
                      hintText: 'Nama Lengkap',
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1.8,
                        color: Colors.grey.shade300,
                      )),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    style: GoogleFonts.openSans(
                        fontSize: 13,
                        color: titleColor,
                        fontWeight: FontWeight.w600),
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration:  InputDecoration(
                      hintText: 'Nomor Handphone',
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1.8,
                        color: Colors.grey.shade300,
                      )),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    style: GoogleFonts.openSans(
                        fontSize: 13,
                        color: titleColor,
                        fontWeight: FontWeight.w600),
                    controller: idCardNumberController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration:  InputDecoration(
                      hintText: 'Nomor Identitas',
                      hintStyle: TextStyle(color: Colors.grey.shade500),

                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: InkWell(
                  onTap: () async {
                    final userCon =
                        Provider.of<UserController>(context, listen: false);

                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        phoneNumberController.text.isEmpty ||
                        idCardNumberController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Data tidak boleh kosong",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red[300],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
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
                    // if(isPasswordValid == false){
                    //   Fluttertoast.showToast(
                    //       msg: "Mohon masukkan password yang valid",
                    //       toastLength: Toast.LENGTH_SHORT,
                    //       gravity: ToastGravity.BOTTOM,
                    //       timeInSecForIosWeb: 1,
                    //       backgroundColor: Colors.red[300],
                    //       textColor: Colors.white,
                    //       fontSize: 16.0);
                    //   return;

                    // } if(isPasswordAndConfirmValid == false){
                    //   Fluttertoast.showToast(
                    //       msg: "Password dan Konfirmasi Password tidak cocok",
                    //       toastLength: Toast.LENGTH_SHORT,
                    //       gravity: ToastGravity.BOTTOM,
                    //       timeInSecForIosWeb: 1,
                    //       backgroundColor: Colors.red[300],
                    //       textColor: Colors.white,
                    //       fontSize: 16.0);
                    //   return;
                    // }
                    setState(() {
                      isLoading = true;
                    });

                    try {
                      await userCon.registerUser(nameController.text, emailController.text, passwordController.text, confirmPasswordController.text, phoneNumberController.text, idCardNumberController.text);

                      if(userCon.statusCodeRegister == 200){
                        print("Regist Success");
                        setState(() {
                        isLoading = false;
                        });
                       Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginUser()),
                                      (route) => false);
                      } else if (userCon.statusCodeRegister == 409){
                        print("Regist Failed");
                        setState(() {
                        isLoading = false;
                        });
                        Fluttertoast.showToast(
                          msg: userCon.messageRegister.toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red[300],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                        
                      }else if (userCon.statusCodeRegister == 422){
                        print("Regist Failed");
                        setState(() {
                        isLoading = false;
                        });
                        Fluttertoast.showToast(
                          msg: userCon.messageRegister.toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red[300],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                        
                      } else if (userCon.statusCodeRegister == 400){
                        print("Regist Failed");
                        setState(() {
                        isLoading = false;
                        });
                        Fluttertoast.showToast(
                          msg: userCon.messageRegister.toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red[300],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                        
                      }  else {
                        print("Regist Failed");
                        setState(() {
                        isLoading = false;
                        });
                        Fluttertoast.showToast(
                          msg: 'Terjadi error: ${userCon.statusCodeRegister}\n Mohon coba lagi nanti',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red[300],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                        
                      }
                    } catch (e){
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
                      "Daftar",
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
                          "Sudah memiliki akun? ",
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
                                    builder: (context) => LoginUser()));
                          },
                          child: Text(
                            "Masuk disini",
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: secondaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    )),
              )
            ]),
          ),
      ),
    );
  }
}
