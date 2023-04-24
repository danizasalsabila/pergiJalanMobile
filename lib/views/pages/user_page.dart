import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/views/pages/login_user.dart';
import 'package:provider/provider.dart';

import '../../controllers/user_controller.dart';
import 'business_owner/home.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isLoading = false;

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO PROFILE-----------");
    final profileCon = Provider.of<UserController>(context, listen: false);
    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        await profileCon.userDetail();
      } catch (e) {
        print(e);
      }

      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<UserController>(builder: (context, profileCon, child) {
              return Column(children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            // color: primaFryColor,
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topRight,
                              colors: [
                                secondaryColor,
                                // Color.fromARGB(255, 28, 114, 125),
                                Color.fromARGB(255, 12, 69, 104),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 120,
                        ),
                        SizedBox(
                          height: 70,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  backgroundColor:
                                      Color.fromARGB(255, 230, 230, 230),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Selamat Datang",
                                        style: GoogleFonts.openSans(
                                            fontSize: 10,
                                            color: Colors.grey.shade400,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        profileCon.userDataDetail!.name
                                            .toString(),
                                        style: GoogleFonts.kanit(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        profileCon.userDataDetail!.phoneNumber
                                            .toString(),
                                        style: GoogleFonts.openSans(
                                            fontSize: 13,
                                            color: Colors.grey.shade200,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 20.0, 25, 8),
                          child: Container(
                            height: 90,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(color: descColor, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Email",
                                        style: GoogleFonts.kanit(
                                            fontSize: 16,
                                            color: secondaryColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        profileCon.userDataDetail!.email
                                            .toString(),
                                        style: GoogleFonts.openSans(
                                            fontSize: 11,
                                            color: Colors.grey.shade400,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Nomor Identitas",
                                        style: GoogleFonts.kanit(
                                            fontSize: 16,
                                            color: secondaryColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        profileCon.userDataDetail!.idCardNumber
                                            .toString(),
                                        style: GoogleFonts.openSans(
                                            fontSize: 11,
                                            color: Colors.grey.shade400,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: descColor, width: 2)),
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Saldo Anda",
                                style: GoogleFonts.openSans(
                                    fontSize: 12,
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Rp   ",
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "2.000.000",
                                    style: GoogleFonts.openSans(
                                        fontSize: 26,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade200,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "createdAt",
                                  style: GoogleFonts.openSans(
                                      fontSize: 10,
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "2022-02-02",
                                  style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.wallet,
                                      color: secondaryColor,
                                      size: 18,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        "MidTrans",
                                        style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            color: secondaryColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 11.0, 25, 8),
                  child: Container(
                    height: 163,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: descColor, width: 1.5)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 16, 22, 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 1,
                                color: Colors.grey.shade200,
                              )),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "PESANAN",
                                  style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color: descColor,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 8.0, 5, 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.people_alt,
                                    size: 20,
                                    color: labelColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.59,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Riwayat Tiket",
                                            style: GoogleFonts.openSans(
                                                fontSize: 15,
                                                color: titleColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 15,
                                            color: Colors.grey.shade300,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 1,
                                color: Colors.grey.shade200,
                              )),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "PENGATURAN",
                                  style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color: descColor,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 8.0, 5, 10),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.logout_rounded,
                                  size: 20,
                                  color: labelColorBack,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: InkWell(
                                    onTap: () async {
                                      final userCon =
                                          Provider.of<UserController>(context,
                                              listen: false);

                                      try {
                                        await userCon.logoutUser();
                                      } catch (e) {
                                        print(e);
                                      }

                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginUser()),
                                              (route) => false);
                                    },
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width *
                                              0.59,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Keluar",
                                            style: GoogleFonts.openSans(
                                                fontSize: 15,
                                                color: titleColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 15,
                                            color: Colors.grey.shade300,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            color: Colors.grey.shade200,
                          )),
                        ],
                      ),
                    ),
                  ),
                )
              ]);
            }),
    );
  }
}
