import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/views/pages/login_user.dart';

import 'create_destinationtour.dart';

class HomePageOwner extends StatefulWidget {
  const HomePageOwner({super.key});

  @override
  State<HomePageOwner> createState() => _HomePageOwnerState();
}

class _HomePageOwnerState extends State<HomePageOwner> {
  var now = new DateTime.now();

  bool isLoading = false;

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO HOME PAGE ADMIN-----------");
    isLoading = true;

    Future.delayed(Duration(seconds: 2)).then((value) async {
      try {} catch (e) {
        e;
      }
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEEE, d MMM yyyy').format(now);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginUser()));
            },
            child: Icon(
              Icons.settings,
              color: Colors.grey.shade400,
            )),
        title: Text(
          'Dashboard',
          style: GoogleFonts.kanit(
              fontSize: 18,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w400),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          elevation: 5,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateDestinationTourist(),
              ),
            );
          },
          backgroundColor: primaryColor,
          child: const
          FaIcon(FontAwesomeIcons.plus)
          //  Icon(
          //   Icons.add,
          //   size: 36,
          //   color: Colors.white,
          // ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Laporan Peningkatan",
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 1, bottom: 7),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Usaha Nama Pemilik",
                      style: GoogleFonts.openSans(
                          fontSize: 12,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 100,
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.people,
                                size: 90,
                                color: Colors.grey.shade100,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Total Rating",
                                    style: GoogleFonts.openSans(
                                        fontSize: 10,
                                        color: descColor,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 29,
                                      color: Colors.amber,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "4.5",
                                        style: GoogleFonts.kanit(
                                            fontSize: 44,
                                            color: thirdColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 100,
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.stacked_line_chart_rounded,
                                size: 90,
                                color: Colors.grey.shade100,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Tiket Terjual",
                                    style: GoogleFonts.openSans(
                                        fontSize: 10,
                                        color: descColor,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "120",
                                        style: GoogleFonts.kanit(
                                            fontSize: 44,
                                            color: labelColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ),
                      ]),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        // color: primaFryColor,
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            // Color.fromARGB(255, 0, 119, 134),
                            Color.fromARGB(255, 17, 93, 139),
                            Color.fromARGB(255, 13, 183, 206),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 15.0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.37,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(71, 255, 255, 255)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text(
                                    "Penjualan Tiket Terbanyak",
                                    style: GoogleFonts.openSans(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "1",
                              style: GoogleFonts.kanit(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Text(
                        "Hari Ini",
                        style: GoogleFonts.openSans(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        formattedDate,
                        style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Container(
                          height: 73,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(1)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Center(
                                        child: Text(
                                          "Terjual",
                                          style: GoogleFonts.openSans(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  166, 36, 78, 79),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Center(
                                        child: Text(
                                          "90",
                                          style: GoogleFonts.kanit(
                                              fontSize: 26,
                                              color: thirdColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 52,
                                  width: 1,
                                  color: Color.fromARGB(92, 36, 78, 79),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "Tempat Wisata",
                                          style: GoogleFonts.openSans(
                                              fontSize: 10,
                                              color: Color.fromARGB(
                                                  166, 36, 78, 79),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 39,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Center(
                                        child: Text(
                                          "Nama Wisata",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.kanit(
                                              fontSize: 13,
                                              color: thirdColor,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.fade,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 52,
                                  width: 1,
                                  color: Color.fromARGB(92, 36, 78, 79),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Center(
                                        child: Text(
                                          "Sisa Tiket",
                                          style: GoogleFonts.openSans(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  166, 36, 78, 79),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: Center(
                                        child: Text(
                                          "20",
                                          style: GoogleFonts.kanit(
                                              fontSize: 26,
                                              color: thirdColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 8),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Kelola Wisatamu",
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: descColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 70,
                                  width:
                                      MediaQuery.of(context).size.width * 0.23,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        "assets/images/slicing.jpg",
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Container(
                                  height: 70,
                                  width:
                                      MediaQuery.of(context).size.width * 0.23,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color.fromARGB(106, 75, 150, 111)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 70,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nama Wisata",
                                        style: GoogleFonts.notoSansDisplay(
                                            fontSize: 17,
                                            color: thirdColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 14,
                                          ),
                                          Text(
                                            "Kota Wisata",
                                            style: GoogleFonts.notoSans(
                                                fontSize: 10,
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2.0, top: 4),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: labelColorBack,
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          height: 19,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.21,
                                          child: Center(
                                              child: Text(
                                            "Ubah",
                                            style: GoogleFonts.openSans(
                                                fontSize: 9,
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                            Container(
                              height: 24,
                              width: MediaQuery.of(context).size.width * 0.067,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 177, 12, 0),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 211, 211, 211)
                                        .withOpacity(0.7),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(
                                        2, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.restore_from_trash,
                                color: Colors.white,
                                size: 16,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey.shade200,
                          ),
                        )
                      ],
                    )),
                  ),
                ),
              ],
            ),
    );
  }
}
