import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/owner_business_controller.dart';
import 'package:pergijalan_mobile/models/ownerbusiness.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/home.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/login_owner.dart';
import 'package:pergijalan_mobile/views/pages/login_user.dart';
import 'package:provider/provider.dart';

class OwnerProfilePage extends StatefulWidget {
  const OwnerProfilePage({super.key});

  @override
  State<OwnerProfilePage> createState() => _OwnerProfilePageState();
}

class _OwnerProfilePageState extends State<OwnerProfilePage> {
  bool isLoading = false;
  var now = new DateTime.now();

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO PROFILE OWNER-----------");
    final profileCon =
        Provider.of<OwnerBusinessController>(context, listen: false);
    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        await profileCon.ownerDetail();
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
    String formattedDate = DateFormat('d/MM/yyyy').format(now);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Consumer<OwnerBusinessController>(
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
                                begin: Alignment.bottomLeft,
                                end: Alignment.center,
                                colors: [
                                  // Color.fromARGB(255, 38, 107, 71),
                                  Color.fromARGB(255, 37, 138, 151),
                                  // secondaryColor,
                                  // Color.fromARGB(255, 28, 114, 125),
                                  thirdColor,
                                  // Color.fromARGB(255, 20, 46, 47)
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
                            height: 55,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: InkWell(
                                    onTap: () =>Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePageOwner()),
                                            (route) => false),
                                    child: Icon(Icons.chevron_left_rounded,
                                        size: 40, color: Colors.grey.shade400)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 18),
                                child: InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: CircleAvatar(
                                    radius: 23,
                                    backgroundColor: Colors.grey.shade300,
                                    child: CircleAvatar(
                                        radius: 22,
                                        backgroundColor: thirdColor,
                                        child: CircleAvatar(
                                          radius: 19,
                                          backgroundImage:  AssetImage("assets/logo/owner.png",)
                                         ),
                                        )),
                                  ),
                                ),
                              
                            ],
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            height: 70,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          profileCon
                                              .ownerBusinessUserDetail!.email
                                              .toString(),
                                          style: GoogleFonts.notoSansDisplay(
                                              fontSize: 13,
                                              color: Colors.grey.shade400,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          profileCon
                                              .ownerBusinessUserDetail!.namaOwner
                                              .toString(),
                                          style: GoogleFonts.openSans(
                                              fontSize: 19,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          profileCon.ownerBusinessUserDetail!
                                              .contactNumber
                                              .toString(),
                                          style: GoogleFonts.notoSansDisplay(
                                              fontSize: 10,
                                              color: Colors.grey.shade300,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5.0,
                                          top: 2,
                                          bottom: 2),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Ubah Profile",
                                            style: GoogleFonts.openSans(
                                                fontSize: 9,
                                                color: thirdColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 4.0),
                                            child: FaIcon(
                                              FontAwesomeIcons.pencil,
                                              size: 13,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10.0, 30, 8),
                            child: Container(
                              height: 165,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Total Pemasukan",
                                          style: GoogleFonts.inter(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Penghasilan anda sejak ${formattedDate}",
                                        style: GoogleFonts.openSans(
                                            fontSize: 10,
                                            color: Colors.grey.shade400,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Rp",
                                          style: GoogleFonts.kanit(
                                              fontSize: 30,
                                              color: thirdColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 5),
                                          child: Text(
                                            "1.000.000",
                                            style: GoogleFonts.kanit(
                                                fontSize: 24,
                                                color: thirdColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 4,
                                      width:
                                          MediaQuery.of(context).size.width * 0.6,
                                      decoration: BoxDecoration(
                                          color: labelColorBack,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.6,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Pengunjung",
                                              style: GoogleFonts.openSans(
                                                  fontSize: 8,
                                                  color: Colors.grey.shade400,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "120",
                                              style: GoogleFonts.openSans(
                                                  fontSize: 11,
                                                  color: thirdColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.6,
                                      height: 27,
                                      decoration: BoxDecoration(
                                          color: thirdColor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                          child: Text(
                                        "Riwayat Penjualan",
                                        style: GoogleFonts.openSans(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )),
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
                      padding: const EdgeInsets.fromLTRB(30, 18, 30, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 7,
                                width: 7,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: thirdColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Menu Laporan",
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      color: thirdColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 194, 194, 194)
                                            .withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                      Container(
                                        height: 42,
                                        width: MediaQuery.of(context).size.width *
                                            0.12,
                                        decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                            color:
                                                Color.fromARGB(85, 36, 78, 79)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6.0),
                                        child: Text("Rating",  style: GoogleFonts.inter(
                                                fontSize: 13,
                                                color: thirdColor,
                                                fontWeight: FontWeight.w600),),
                                      )
                                    ]),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 194, 194, 194)
                                            .withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                      Container(
                                        height: 42,
                                        width: MediaQuery.of(context).size.width *
                                            0.12,
                                        decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                            color:
                                                Color.fromARGB(85, 75, 150, 111)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6.0),
                                        child: Text("Ulasan",  style: GoogleFonts.inter(
                                                fontSize: 13,
                                                color: thirdColor,
                                                fontWeight: FontWeight.w600),),
                                      )
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 194, 194, 194)
                                            .withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                      Container(
                                        height: 42,
                                        width: MediaQuery.of(context).size.width *
                                            0.12,
                                        decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                            color:
                                                Color.fromARGB(85, 1, 141, 159)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6.0),
                                        child: Text("Tiket",  style: GoogleFonts.inter(
                                                fontSize: 13,
                                                color: thirdColor,
                                                fontWeight: FontWeight.w600),),
                                      )
                                    ]),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 194, 194, 194)
                                            .withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                      Container(
                                        height: 42,
                                        width: MediaQuery.of(context).size.width *
                                            0.12,
                                        decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                            color:
                                                Color.fromARGB(85, 12, 69, 104)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6.0),
                                        child: Text("Keuangan",  style: GoogleFonts.inter(
                                                fontSize: 13,
                                                color: thirdColor,
                                                fontWeight: FontWeight.w600),),
                                      )
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 20.0, 25, 8),
                    child: Container(
                      height: 163,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300, width: 2)),
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
                                    "PENGATURAN",
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
                                              "Tentang PergiJalan",
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
                           Expanded(
                                    child: Divider(
                                  thickness: 1,
                                  color: Colors.grey.shade200,
                                )),
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
                                        final ownerCon =
                                            Provider.of<OwnerBusinessController>(
                                                context,
                                                listen: false);

                                        try {
                                          await ownerCon.logoutOwnerBusiness();
                                        } catch (e) {
                                          print(e);
                                        }

                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginOwner()),
                                            (route) => false);
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width *
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
                  ),
                  const SizedBox(height: 28,)
                ]);
              }),
          ),
    );
  }
}
