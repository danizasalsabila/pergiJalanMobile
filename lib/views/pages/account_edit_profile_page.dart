import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/owner_business_controller.dart';
import 'package:pergijalan_mobile/controllers/user_controller.dart';
import 'package:pergijalan_mobile/views/pages/account_user_page.dart';
import 'package:pergijalan_mobile/views/widgets/bar_mainnavigation.dart';
import 'package:provider/provider.dart';

import '../../controllers/destinasi_controller.dart';
import '../../models/user.dart';

class EditProfilePage extends StatefulWidget {
  final User id;
  const EditProfilePage({super.key, required this.id});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController? nameController;
  TextEditingController? phoneNumberController;
  TextEditingController? idCardController;
  String? email;
  bool isLoading = false;
  bool isEdited = false;
  bool isUpdating = false;

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO EDIT PROFILE PAGE-----------");

    final userCon = Provider.of<UserController>(context, listen: false);

    isLoading = true;
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      try {} catch (e) {
        e;
      }
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
    nameController = TextEditingController(text: widget.id.name);
    phoneNumberController = TextEditingController(text: widget.id.phoneNumber);
    idCardController = TextEditingController(text: widget.id.idCardNumber);
    email = widget.id.email;
  }

  @override
  void dispose() {
    nameController!.dispose();
    phoneNumberController!.dispose();
    idCardController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left,
            color: primaryColor,
          ),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Ubah Profil",
          style: GoogleFonts.inter(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Informasi Pribadi",
              style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Color.fromARGB(160, 12, 69, 104),
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 6),
              child: Text(
                "Nama Lengkap",
                style: GoogleFonts.inter(
                    color: descColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Colors.white
                  border: Border.all(
                    width: 2,
                    color: Colors.grey.shade300,
                  )),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: TextField(
                  controller: nameController,
                  onChanged: (text) {
                    if (widget.id.name != null) {
                      setState(() {
                        isEdited = (text != widget.id.name) ? true : false;
                      });
                    } else {
                      isEdited = (text.trim() != widget.id.name) ? true : false;
                    }
                  },
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: descColor,
                      fontWeight: FontWeight.w600),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.grey.shade100,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 6),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 6),
              child: Text(
                "Nomor Telepon",
                style: GoogleFonts.inter(
                    color: descColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Colors.white
                  border: Border.all(
                    width: 2,
                    color: Colors.grey.shade300,
                  )),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: TextField(
                  controller: phoneNumberController,
                  onChanged: (text) {
                    if (widget.id.phoneNumber != null) {
                      setState(() {
                        isEdited =
                            (text != widget.id.phoneNumber) ? true : false;
                      });
                    } else {
                      isEdited =
                          (text.trim() != widget.id.phoneNumber) ? true : false;
                    }
                  },
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: descColor,
                      fontWeight: FontWeight.w600),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.grey.shade100,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 6),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 6),
              child: Text(
                "Nomor Kartu Identitas",
                style: GoogleFonts.inter(
                    color: descColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Colors.white
                  border: Border.all(
                    width: 2,
                    color: Colors.grey.shade300,
                  )),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: TextField(
                  controller: idCardController,
                  onChanged: (text) {
                    if (widget.id.idCardNumber != null) {
                      setState(() {
                        isEdited =
                            (text != widget.id.idCardNumber) ? true : false;
                      });
                    } else {
                      isEdited = (text.trim() != widget.id.idCardNumber)
                          ? true
                          : false;
                    }
                  },
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: descColor,
                      fontWeight: FontWeight.w600),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.grey.shade100,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 6),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 20.0),
            //   child: Container(
            //     height: 100,
            //     decoration: BoxDecoration(
            //         color: Color.fromRGBO(143, 200, 208, 0.623),
            //         borderRadius: BorderRadius.circular(10)),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Center(
            //           child: Padding(
            //                 padding: const EdgeInsets.only(bottom: 10.0),
            //                 child:  Text(
            //                         email.toString(),
            //                         style: GoogleFonts.inter(
            //                             color: primaryColor,
            //                             fontSize: 12,
            //                             fontWeight: FontWeight.w500),
            //                       ),
            //               ),
            //         ),
            //         Padding(
            //                   padding: const EdgeInsets.only(left: 46.0, right: 46),
            //           child: Container(
            //             height: 40,
            //             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12),
            //             border: Border.all( width: 1, color: descColor)
            //             ),
            //             child: Center(
            //               child: Text(
            //                 "Ubah",
            //                 style: GoogleFonts.inter(
            //                     color: descColor,
            //                     fontSize: 14,
            //                     fontWeight: FontWeight.w500),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 6),
                  child: Text(
                    "Email",
                    style: GoogleFonts.inter(
                        color: descColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: "Email tidak bisa diubah",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red[300],
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 6),
                    child: Text(
                      email.toString(),
                      style: GoogleFonts.inter(
                          color: Color.fromARGB(160, 12, 69, 104),
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            isUpdating
                ? SizedBox(
                    height: 45,
                    child: Center(
                        child: const CircularProgressIndicator(
                      strokeWidth: 3,
                    )),
                  )
                : (isEdited)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              isUpdating = true;
                            });
                            final profileCon = Provider.of<UserController>(
                                context,
                                listen: false);

                            if (nameController!.text.isEmpty ||
                                phoneNumberController!.text.isEmpty ||
                                idCardController!.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Data pribadi tidak boleh kosong",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red[300],
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              setState(() {
                                isUpdating = false;
                              });
                              return;
                            }
                            try {
                              await profileCon.editUser(
                                  idUserLogin: widget.id.id,
                                  idCardNumber: idCardController?.text,
                                  name: nameController?.text,
                                  phoneNumber: phoneNumberController?.text);
                              if (profileCon.statusCodeEditProfile == 200) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => MainNavigation(
                                              indexNav: 2,
                                            )),
                                    (route) => false);
                                setState(() {
                                  isUpdating = false;
                                });
                                Fluttertoast.showToast(
                                    msg: "Profilmu berhasil diubah!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor:
                                        primaryColor.withOpacity(0.6),
                                    textColor: Colors.white,
                                    fontSize: 13);
                              } else if (profileCon.statusCodeEditProfile ==
                                  400) {
                                setState(() {
                                  isLoading = false;
                                });
                                Fluttertoast.showToast(
                                    msg: profileCon.messageEditProfile
                                        .toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red[300],
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                setState(() {
                                  isUpdating = false;
                                });
                                return;
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                Fluttertoast.showToast(
                                    msg:
                                        "Terjadi error\n Mohon coba lagi nanti",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red[300],
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                setState(() {
                                  isUpdating = false;
                                });
                                return;
                              }
                            } catch (e) {
                              e;
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(214, 12, 69, 104),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Ubah",
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: descColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Ubah",
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
