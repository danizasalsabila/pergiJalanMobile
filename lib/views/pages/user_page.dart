import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/destinasi_controller.dart';
import 'package:pergijalan_mobile/views/pages/about_pergijalan.dart';
import 'package:pergijalan_mobile/views/pages/login_user.dart';
import 'package:pergijalan_mobile/views/pages/splash_screen_page.dart';
import 'package:pergijalan_mobile/views/pages/tipsandtrick.dart';
import 'package:provider/provider.dart';

import '../../controllers/user_controller.dart';
import '../widgets/bar_mainnavigation.dart';
import 'business_owner/login_owner.dart';
import 'edit_profile_page.dart';

class UserPage extends StatefulWidget {
  
   UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _colors = [
    Color.fromARGB(255, 143, 200, 208),
    Color.fromARGB(255, 174, 204, 188)
  ];

  bool isLoading = false;
  bool isUserLogin = false;
  int _index = 0;

  int? _selectedListUser;
  bool isSelected = false;
  onSelectedListUser(int i) {
    setState(() {
      _selectedListUser = i;
      isSelected = true;
    });
  }

  @override
  void mainl() {
    final myList = [1, 2];

    for (var i = 0; i < 5; i++) {
      print(myList[i % myList.length]);
    }
  }

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO PROFILE-----------");
    final profileCon = Provider.of<UserController>(context, listen: false);
    final homeCon = Provider.of<DestinasiController>(context, listen: false);

    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        await homeCon.allDestinasi();

        await profileCon.userDetail();
      } catch (e) {
        print(e);
      }

      if (profileCon.isLogin == false) {
        isUserLogin = false;
      } else {
        isUserLogin = true;
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
            : isUserLogin == true
                ? Consumer<UserController>(
                    builder: (context, profileCon, child) {
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
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 32,
                                            backgroundColor: Color.fromARGB(
                                                255, 230, 230, 230),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Selamat Datang",
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 10,
                                                      color:
                                                          Colors.grey.shade400,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  profileCon
                                                      .userDataDetail!.name
                                                      .toString(),
                                                  style: GoogleFonts.kanit(
                                                      fontSize: 22,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  profileCon.userDataDetail!
                                                      .phoneNumber
                                                      .toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 13,
                                                      color:
                                                          Colors.grey.shade200,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          final userCon =
                                              Provider.of<UserController>(
                                                  context,
                                                  listen: false);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfilePage(
                                                        id: userCon.userDataDetail!,
                                                      )));
                                        },
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            // height: 20,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                  right: 5.0,
                                                  top: 2,
                                                  bottom: 2),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Ubah Profil",
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 9,
                                                        color: thirdColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.pencil,
                                                      size: 11,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 20.0, 25, 8),
                                child: Container(
                                  height: 90,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: descColor, width: 2)),
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
                                              profileCon
                                                  .userDataDetail!.idCardNumber
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

                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      //   child: Container(
                      //     height: 170,
                      //     width: MediaQuery.of(context).size.width,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         color: Colors.white,
                      //         border: Border.all(color: descColor, width: 2)),
                      //     child: Padding(
                      //         padding: const EdgeInsets.all(16),
                      //         child: Column(
                      //           children: [
                      //             Align(
                      //               alignment: Alignment.topRight,
                      //               child: Text(
                      //                 "Saldo Anda",
                      //                 style: GoogleFonts.openSans(
                      //                     fontSize: 12,
                      //                     color: Colors.grey.shade400,
                      //                     fontWeight: FontWeight.w500),
                      //               ),
                      //             ),
                      //             Align(
                      //               alignment: Alignment.topRight,
                      //               child: Row(
                      //                 mainAxisAlignment: MainAxisAlignment.end,
                      //                 children: [
                      //                   Text(
                      //                     "Rp   ",
                      //                     style: GoogleFonts.openSans(
                      //                         fontSize: 14,
                      //                         color: Colors.grey.shade400,
                      //                         fontWeight: FontWeight.w400),
                      //                   ),
                      //                   Text(
                      //                     "2.000.000",
                      //                     style: GoogleFonts.openSans(
                      //                         fontSize: 26,
                      //                         color: primaryColor,
                      //                         fontWeight: FontWeight.w800),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 40,
                      //             ),
                      //             Container(
                      //               height: 1,
                      //               width: MediaQuery.of(context).size.width,
                      //               color: Colors.grey.shade200,
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 5.0),
                      //               child: Align(
                      //                 alignment: Alignment.topLeft,
                      //                 child: Text(
                      //                   "createdAt",
                      //                   style: GoogleFonts.openSans(
                      //                       fontSize: 10,
                      //                       color: Colors.grey.shade400,
                      //                       fontWeight: FontWeight.w400),
                      //                 ),
                      //               ),
                      //             ),
                      //             Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text(
                      //                   "2022-02-02",
                      //                   style: GoogleFonts.openSans(
                      //                       fontSize: 14,
                      //                       color: primaryColor,
                      //                       fontWeight: FontWeight.w600),
                      //                 ),
                      //                 Row(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.end,
                      //                   children: [
                      //                     const Icon(
                      //                       Icons.wallet,
                      //                       color: secondaryColor,
                      //                       size: 18,
                      //                     ),
                      //                     Padding(
                      //                       padding: const EdgeInsets.only(
                      //                           left: 4.0),
                      //                       child: Text(
                      //                         "MidTrans",
                      //                         style: GoogleFonts.openSans(
                      //                             fontSize: 12,
                      //                             color: secondaryColor,
                      //                             fontWeight: FontWeight.w400),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 )
                      //               ],
                      //             )
                      //           ],
                      //         )),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(left: 25, right: 25, top: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 25,
                                  height: 23,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color.fromARGB(255, 36, 78, 79)
                                            .withOpacity(0.65)),
                                    child: const Center(
                                        child: FaIcon(
                                      FontAwesomeIcons.clockRotateLeft,
                                      color: Colors.white,
                                      size: 13,
                                    )),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Riwayat Pemesanan Tiket",
                                        style: GoogleFonts.inter(
                                            fontSize: 15,
                                            color: thirdColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                                child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Lihat Semua",
                                style: GoogleFonts.inter(
                                    fontSize: 9,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w500),
                              ),
                            ))
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0, top: 10),
                          child: Consumer<DestinasiController>(
                              builder: (context, ticketCon, child) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: ticketCon.destinasiData?.length,
                              controller: PageController(viewportFraction: 0.3),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Card(
                                    color: _colors[index % _colors.length],
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: SizedBox(
                                      height: 135,
                                      width: 95,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 7.0, bottom: 8.0, right: 7),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Nama Wisata",
                                                style:
                                                    GoogleFonts.notoSansDisplay(
                                                        fontSize: 13,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                "02/02/2020",
                                                style:
                                                    GoogleFonts.notoSansDisplay(
                                                        fontSize: 11,
                                                        color: thirdColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 25.0, 25, 8),
                        child: Container(
                          height: 210,
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
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "INFORMASI",
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
                                    padding: const EdgeInsets.fromLTRB(
                                        5, 8.0, 5, 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.people_alt,
                                          size: 20,
                                          color: labelColor,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TipsAndTrick()));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.59,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Tips dan Trik",
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 15,
                                                        color: titleColor,
                                                        fontWeight:
                                                            FontWeight.w600),
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
                                ),
                                Expanded(
                                        child: Divider(
                                      thickness: 1,
                                      color: Colors.grey.shade200,
                                    )),
                                InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        5, 8.0, 5, 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.people_alt,
                                          size: 20,
                                          color: labelColor,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AboutPergiJalan()));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.59,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Tentang PergiJalan",
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 15,
                                                        color: titleColor,
                                                        fontWeight:
                                                            FontWeight.w600),
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
                                ),
                                 Row(
                                  children: [
                                    Expanded(
                                        child: Divider(
                                      thickness: 1,
                                      color: Colors.grey.shade200,
                                    )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 8.0, 5, 10),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.logout_rounded,
                                        size: 20,
                                        color: labelColorBack,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: InkWell(
                                          onTap: () async {
                                            final userCon =
                                                Provider.of<UserController>(
                                                    context,
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
                                                            Splashscreen()),
                                                    (route) => false);
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.59,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Keluar",
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15,
                                                      color: titleColor,
                                                      fontWeight:
                                                          FontWeight.w600),
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
                  })
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: SizedBox(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              Center(
                                child: Text(
                                  "Masuk Sekarang!",
                                  style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Center(
                                  child: Text(
                                    "Untuk mengakses fitur layanan yang tersedia dan menjalajahi PergiJalan dengan lengkap, mohon lakukan login terlebih dahulu",
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        color:
                                            Color.fromARGB(255, 167, 167, 167),
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  onSelectedListUser(0);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width *
                                        0.52,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1.3,
                                            color: _selectedListUser == 0
                                                ? secondaryColor
                                                : Colors.grey.shade200),
                                        color: _selectedListUser == 0
                                            ? const Color.fromARGB(
                                                255, 207, 233, 237)
                                            : Colors.grey.shade200),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0),
                                            child: Text(
                                              "Wisatawan",
                                              style:
                                                  GoogleFonts.notoSansDisplay(
                                                      fontSize: 15,
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                          SizedBox(
                                              height: 120,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: Image.asset(
                                                "assets/servicebar/usertourist.png",
                                                // fit: BoxFit.fitWidth,
                                              ))
                                        ]),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  onSelectedListUser(1);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width *
                                        0.52,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1.3,
                                            color: _selectedListUser == 1
                                                ? secondaryColor
                                                : Colors.grey.shade200),
                                        color: _selectedListUser == 1
                                            ? const Color.fromARGB(
                                                255, 207, 233, 237)
                                            : Colors.grey.shade200),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 20.0),
                                            child: Text(
                                              "Penyedia\nWisata",
                                              textAlign: TextAlign.center,
                                              style:
                                                  GoogleFonts.notoSansDisplay(
                                                      fontSize: 15,
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                          SizedBox(
                                              height: 120,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: Image.asset(
                                                "assets/servicebar/userbusiness.png",
                                                fit: BoxFit.fill,
                                                // fit: BoxFit.fitWidth,
                                              ))
                                        ]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0, left: 13, right: 13),
                                child: isSelected == true
                                    ? InkWell(
                                        onTap: () {
                                          if (_selectedListUser == 0) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginUser()));
                                          } else if (_selectedListUser == 1) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginOwner()));
                                          }
                                          // print(
                                          //     "pilihan tipe user : $_selectedListUser");
                                        },
                                        child: Container(
                                          height: 40,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Center(
                                              child: Text("Mulai",
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600))),
                                          decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Anda belum memilih peran akun",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Colors.red.withOpacity(0.6),
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        },
                                        child: Container(
                                          height: 40,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Center(
                                              child: Text("Mulai",
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600))),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                              )
                            ]),
                      ),
                    ),
                  ));
  }
}
