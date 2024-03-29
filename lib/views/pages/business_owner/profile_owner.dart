import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/eticket_controller.dart';
import 'package:pergijalan_mobile/controllers/owner_business_controller.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/edit_profile_owner.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/home.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/rating_all.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/ticketsales_history.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/ticketsales_history_month.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/ticketsales_history_week.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/ticketsales_history_year.dart';
import 'package:provider/provider.dart';

import '../../../controllers/ticket_controller.dart';
import '../splash_screen_page.dart';

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
    final eticketCon = Provider.of<ETicketController>(context, listen: false);
    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        await profileCon.ownerDetail();
        await eticketCon.allEticketByOwner(profileCon.idOBLogin);
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
    final eticketCon = Provider.of<ETicketController>(context, listen: false);
    final ticketData = Provider.of<TicketController>(context, listen: false);

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
                                    onTap: () => Navigator.of(context)
                                        .pushAndRemoveUntil(
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
                                      child: const CircleAvatar(
                                        radius: 22,
                                        backgroundColor: thirdColor,
                                        child: CircleAvatar(
                                            radius: 19,
                                            backgroundImage: AssetImage(
                                              "assets/logo/owner.png",
                                            )),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          profileCon.ownerBusinessUserDetail!
                                              .namaOwner
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
                                              fontSize: 12,
                                              color: Colors.grey.shade300,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      final profileCon =
                                          Provider.of<OwnerBusinessController>(
                                              context,
                                              listen: false);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfileOwnerPage(
                                                    id: profileCon
                                                        .ownerBusinessUserDetail!,
                                                  )));
                                    },
                                    child: Container(
                                      // height: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0,
                                            right: 12.0,
                                            top: 5,
                                            bottom: 5),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Ubah Profil",
                                              style: GoogleFonts.openSans(
                                                  fontSize: 11,
                                                  color: thirdColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.0),
                                              child: FaIcon(
                                                FontAwesomeIcons.pencil,
                                                size: 13,
                                              ),
                                            )
                                          ],
                                        ),
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
                              // height: 175,
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
                                              fontSize: 14,
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
                                            fontSize: 12,
                                            color: Colors.grey.shade400,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            eticketCon.totalIncomeTicket != 0
                                                ? eticketCon.totalIncomeTicket
                                                    .toString()
                                                : "-",
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
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      decoration: BoxDecoration(
                                          color: labelColorBack,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
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
                                                  fontSize: 11,
                                                  color: Colors.grey.shade400,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              ticketData.ticketSoldOwner == 0 || ticketData.ticketSoldOwner == null
                                                  ? "0": ticketData.ticketSoldOwner
                                                      .toString(),
                                              style: GoogleFonts.openSans(
                                                  fontSize: 12,
                                                  color: thirdColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (eticketCon.eticketData != null) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TicketSalesHistory()));
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Belum terdapat penjualan tiket",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  primaryColor.withOpacity(0.6),
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height: 32,
                                        decoration: BoxDecoration(
                                            color: thirdColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                            child: Text(
                                          "Riwayat Penjualan",
                                          style: GoogleFonts.openSans(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),
                                    ),
                                    SizedBox(height: 10,)
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
                                  "Menu Laporan Penjualan Tiket",
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
                                InkWell(
                                  onTap: () {
                                    if (eticketCon.eticketData != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryTicketByYear()
                                              // BarChartSample1()
                                              ));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Belum terdapat penjualan tiket",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              primaryColor.withOpacity(0.6),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width *
                                        0.26,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(255, 194, 194, 194)
                                                  .withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 42,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Color.fromARGB(
                                                      85, 36, 78, 79)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Image.asset(
                                                  "assets/servicebar/year.png",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0),
                                              child: Text(
                                                "Tahunan",
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: thirdColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (eticketCon.eticketData != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryTicketByMonths()
                                              // BarChartSample1()
                                              ));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Belum terdapat penjualan tiket",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              primaryColor.withOpacity(0.6),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width *
                                        0.26,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(255, 194, 194, 194)
                                                  .withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 42,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Image.asset(
                                                  "assets/servicebar/month.png",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Color.fromARGB(
                                                      85, 75, 150, 111)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0),
                                              child: Text(
                                                "Bulanan",
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: thirdColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (eticketCon.eticketData != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryTicketByWeek()
                                              // BarChartSample1()
                                              ));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Belum terdapat penjualan tiket",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              primaryColor.withOpacity(0.6),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width *
                                        0.26,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(255, 194, 194, 194)
                                                  .withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 42,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Color.fromARGB(
                                                      84, 4, 75, 41)),
                                              child: Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Image.asset(
                                                  "assets/servicebar/date.png",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0),
                                              child: Text(
                                                "Mingguan",
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: thirdColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 20),
                          //   child: Row(
                          //     children: [
                          //       Container(
                          //         height: 7,
                          //         width: 7,
                          //         decoration: const BoxDecoration(
                          //           shape: BoxShape.circle,
                          //           color: thirdColor,
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.only(left: 8.0),
                          //         child: Text(
                          //           "Ulasan dan Rating",
                          //           style: GoogleFonts.inter(
                          //               fontSize: 15,
                          //               color: thirdColor,
                          //               fontWeight: FontWeight.w600),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 10.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Container(
                          //         height: 100,
                          //         width:
                          //             MediaQuery.of(context).size.width * 0.4,
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(10),
                          //           boxShadow: [
                          //             BoxShadow(
                          //               color:
                          //                   Color.fromARGB(255, 194, 194, 194)
                          //                       .withOpacity(0.5),
                          //               spreadRadius: 2,
                          //               blurRadius: 3,
                          //               offset: const Offset(
                          //                   0, 5), // changes position of shadow
                          //             ),
                          //           ],
                          //         ),
                          //         child: Center(
                          //           child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               children: [
                          //                 Container(
                          //                   height: 42,
                          //                   width: MediaQuery.of(context)
                          //                           .size
                          //                           .width *
                          //                       0.12,
                          //                   child: Padding(
                          //                     padding:
                          //                         const EdgeInsets.all(7.0),
                          //                     child: Image.asset(
                          //                       "assets/servicebar/rating.png",
                          //                       fit: BoxFit.fill,
                          //                     ),
                          //                   ),
                          //                   decoration: BoxDecoration(
                          //                       borderRadius:
                          //                           BorderRadius.circular(15),
                          //                       color: Color.fromARGB(
                          //                           85, 1, 141, 159)),
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       const EdgeInsets.only(top: 6.0),
                          //                   child: Text(
                          //                     "Rating",
                          //                     style: GoogleFonts.inter(
                          //                         fontSize: 13,
                          //                         color: thirdColor,
                          //                         fontWeight: FontWeight.w600),
                          //                   ),
                          //                 )
                          //               ]),
                          //         ),
                          //       ),
                          //       Container(
                          //         height: 100,
                          //         width:
                          //             MediaQuery.of(context).size.width * 0.4,
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(10),
                          //           boxShadow: [
                          //             BoxShadow(
                          //               color:
                          //                   Color.fromARGB(255, 194, 194, 194)
                          //                       .withOpacity(0.5),
                          //               spreadRadius: 2,
                          //               blurRadius: 3,
                          //               offset: const Offset(
                          //                   0, 5), // changes position of shadow
                          //             ),
                          //           ],
                          //         ),
                          //         child: Center(
                          //           child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               children: [
                          //                 Container(
                          //                   child: Padding(
                          //                     padding:
                          //                         const EdgeInsets.all(7.0),
                          //                     child: Image.asset(
                          //                       "assets/servicebar/ulasan.png",
                          //                       fit: BoxFit.fill,
                          //                     ),
                          //                   ),
                          //                   height: 42,
                          //                   width: MediaQuery.of(context)
                          //                           .size
                          //                           .width *
                          //                       0.12,
                          //                   decoration: BoxDecoration(
                          //                       borderRadius:
                          //                           BorderRadius.circular(15),
                          //                       color: Color.fromARGB(
                          //                           85, 12, 69, 104)),
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       const EdgeInsets.only(top: 6.0),
                          //                   child: Text(
                          //                     "Ulasan",
                          //                     style: GoogleFonts.inter(
                          //                         fontSize: 13,
                          //                         color: thirdColor,
                          //                         fontWeight: FontWeight.w600),
                          //                   ),
                          //                 )
                          //               ]),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 20.0, 25, 8),
                    child: Container(
                      height: 165,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 16, 22, 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    child: Divider(
                                  thickness: 1,
                                  color: Colors.grey.shade200,
                                )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "INFORMASI",
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        color: descColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                 AllRatingReviewPage() ));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 8.0, 5, 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star_border,
                                      size: 20,
                                      color: Colors.amber,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.59,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Penilaian Akun",
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
                                        fontSize: 13,
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
                                        final ownerCon = Provider.of<
                                                OwnerBusinessController>(
                                            context,
                                            listen: false);

                                        try {
                                          await ownerCon.logoutOwnerBusiness();
                                        } catch (e) {
                                          print(e);
                                        }
                                         Fluttertoast.showToast(
                                              msg:
                                                  "Anda berhasil keluar dari akun anda",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Color.fromARGB(255, 54, 158, 244).withOpacity(0.6),
                                              textColor: Colors.white,
                                              fontSize: 16.0);

                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Splashscreen()),
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
                  ),
                  const SizedBox(
                    height: 28,
                  )
                ]);
              }),
            ),
    );
  }
}
