import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:pergijalan_mobile/config/theme_color.dart';

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
    print(formattedDate);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: GoogleFonts.kanit(
              fontSize: 19, color: primaryColor, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
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
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 19.0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Penjualan Tiket Terbanyak",
                              style: GoogleFonts.openSans(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "1",
                              style: GoogleFonts.openSans(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
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
                              child: Row(children: [
                                Container()
                              ]),
                        ),
                      )
                    ]),
                  ),
                )
              ],
            ),
    );
  }
}
