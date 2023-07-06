import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/eticket_controller.dart';
import 'package:provider/provider.dart';

import '../../../controllers/destinasi_controller.dart';
import '../../../controllers/owner_business_controller.dart';

class TicketSalesHistory extends StatefulWidget {
  const TicketSalesHistory({super.key});

  @override
  State<TicketSalesHistory> createState() => _TicketSalesHistoryState();
}

class _TicketSalesHistoryState extends State<TicketSalesHistory> {
  bool isLoading = false;
  int _index = 0;

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO LIST DATA BY CATEGORY-----------");
    final historyList = Provider.of<ETicketController>(context, listen: false);
    final ownerCon =
        Provider.of<OwnerBusinessController>(context, listen: false);

    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        await historyList.allEticketByOwner(ownerCon.idOBLogin);
      } catch (e) {
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
    return Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  // color: primaFryColor,
                  gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.center,
                    colors: [
                      Color.fromARGB(255, 25, 63, 63),
                      Color.fromARGB(255, 62, 121, 91),
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 27,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Jelajahi keberhasilan promosi tempat wisata Anda dengan riwayat penjualan tiket ini",
                              style: GoogleFonts.openSans(
                                  fontSize: 13,
                                  color: const Color.fromARGB(255, 238, 238, 238),
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 700,
                        child: Consumer<ETicketController>(
                            builder: (context, eticketCon, child) {
                          return PageView.builder(
                            itemCount: eticketCon.eticketData!.length,
                            controller: PageController(viewportFraction: 0.86),
                            onPageChanged: (int index) => setState(() {
                              _index = index;
                            }),
                            itemBuilder: (context, index) {
                              String dateBook = eticketCon
                                  .eticketData![index].dateBook
                                  .toString();
                              DateTime dateTime = DateTime.parse(dateBook);
                              // Formatter tanggal
                              DateFormat dateFormatter =
                                  DateFormat('yyyy-MM-dd');
// Formatter waktu
                              DateFormat timeFormatter = DateFormat('HH:mm:ss');

                              // Mendapatkan tanggal yang diformat
                              String formattedDate =
                                  dateFormatter.format(dateTime);
// Mendapatkan waktu yang diformat
                              String formattedTime =
                                  timeFormatter.format(dateTime);
                              int reversedIndex =
                                  eticketCon.eticketData!.length - index;
                              return Transform.scale(
                                  scale: index == _index ? 1 : 0.91,
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(14),
                                                topRight: Radius.circular(14))),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0, right: 16),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: thirdColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        13, 2.0, 13, 2),
                                                    child: Text(
                                                      "Riwayat $reversedIndex",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 11,
                                                          color: thirdColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                height: 1,
                                              ),

                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Tempat Wisata",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 13,
                                                      color: Color.fromARGB(
                                                          255, 124, 149, 149),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   height: 1,
                                              // ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  eticketCon.eticketData![index]
                                                      .destinasi!.nameDestinasi
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.inter(
                                                      fontSize: 29,
                                                      color: thirdColor,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment
                                                //         .spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.36,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: Icon(
                                                                Icons
                                                                    .access_time_outlined,
                                                                size: 40,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        239,
                                                                        239,
                                                                        239),
                                                              ),
                                                            ),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 7.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Jam Buka",
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            124,
                                                                            149,
                                                                            149),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              Text(eticketCon
                                                                    .eticketData![
                                                                        index]
                                                                    .destinasi!
                                                                    .openHour != null?
                                                                eticketCon
                                                                    .eticketData![
                                                                        index]
                                                                    .destinasi!
                                                                    .openHour
                                                                    .toString():"-",
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        20,
                                                                    color:
                                                                        thirdColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.36,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: Icon(
                                                                Icons
                                                                    .access_time_outlined,
                                                                size: 40,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        239,
                                                                        239,
                                                                        239),
                                                              ),
                                                            ),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 7.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Jam Tutup",
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            124,
                                                                            149,
                                                                            149),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              Text(
                                                                eticketCon
                                                                    .eticketData![
                                                                        index]
                                                                    .destinasi!
                                                                    .closedHour != null ? eticketCon
                                                                    .eticketData![
                                                                        index]
                                                                    .destinasi!
                                                                    .closedHour
                                                                    .toString():"-",
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        20,
                                                                    color:
                                                                        thirdColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(14),
                                                bottomRight:
                                                    Radius.circular(14))),
                                        child: Column(children: [
                                          // Container(
                                          //   width: MediaQuery.of(context)
                                          //       .size
                                          //       .width,
                                          //   // height: 20,
                                          //   child: Stack(
                                          //     children: [
                                          //       Row(
                                          //         children: List.generate(
                                          //             150 ~/ 3,
                                          //             (index) => Expanded(
                                          //                   child: Container(
                                          //                     color: index %
                                          //                                 2 ==
                                          //                             0
                                          //                         ? Colors.grey
                                          //                             .shade400
                                          //                         : Colors
                                          //                             .transparent,
                                          //                     height: 1,
                                          //                   ),
                                          //                 )),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0, right: 20),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Nama Pengunjung",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 12,
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              124, 149, 149),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5.0),
                                                      child: Text(
                                                        eticketCon
                                                            .eticketData![index]
                                                            .nameVisitor
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 22,
                                                                color:
                                                                    thirdColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.36,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Nama Tiket",
                                                        style: GoogleFonts.inter(
                                                            fontSize: 12,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                124,
                                                                149,
                                                                149),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                          eticketCon.eticketData![index].ticket!.nameTicket == null ? "-":
                                                          eticketCon.eticketData![index].ticket!.nameTicket.toString(),
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  color:
                                                                      thirdColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.36,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Tanggal Kunjungan",
                                                        style: GoogleFonts.inter(
                                                            fontSize: 12,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                124,
                                                                149,
                                                                149),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                          "${eticketCon.eticketData![index].dateVisit.toString()}",
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  color:
                                                                      thirdColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22),
                                            child: Row(
                                              
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.36,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Metode Pembayaran",
                                                        style: GoogleFonts.inter(
                                                            fontSize: 12,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                124,
                                                                149,
                                                                149),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                          "Mandiri VA",
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  color:
                                                                      thirdColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.36,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Harga Tiket",
                                                        style: GoogleFonts.inter(
                                                            fontSize: 12,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                124,
                                                                149,
                                                                149),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                          "Rp ${eticketCon.eticketData![index].price.toString()}",
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 20,
                                                                  color:
                                                                      thirdColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22),
                                            child: Row(
                                              
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.36,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Email Pemesan",
                                                        style: GoogleFonts.inter(
                                                            fontSize: 12,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                124,
                                                                149,
                                                                149),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                          eticketCon
                                                              .eticketData![
                                                                  index]
                                                              .user!
                                                              .email
                                                              .toString(),
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  color:
                                                                      thirdColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.36,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Nama Akun",
                                                        style: GoogleFonts.inter(
                                                            fontSize: 12,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                124,
                                                                149,
                                                                149),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                          eticketCon
                                                              .eticketData![
                                                                  index]
                                                              .user!
                                                              .name
                                                              .toString(),
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  color:
                                                                      thirdColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Container(
                                            // width: MediaQuery.of(context).size.width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: thirdColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(100),
                                                      bottomRight:
                                                          Radius.circular(100),
                                                    ),
                                                  ),
                                                  height: 24,
                                                  width: 12,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.71,
                                                  child: Row(
                                                    children: List.generate(
                                                        150 ~/ 3,
                                                        (index) => Expanded(
                                                              child: Container(
                                                                color: index %
                                                                            2 ==
                                                                        0
                                                                    ? Colors
                                                                        .grey
                                                                        .shade500
                                                                    : Colors
                                                                        .transparent,
                                                                height: 1,
                                                              ),
                                                            )),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: thirdColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(100),
                                                      bottomLeft:
                                                          Radius.circular(100),
                                                    ),
                                                  ),
                                                  height: 24,
                                                  width: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.245,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Tanggal\nPembayaran",
                                                        style: GoogleFonts.inter(
                                                            fontSize: 10,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                124,
                                                                149,
                                                                149),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                          formattedDate,
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 12,
                                                                  color:
                                                                      thirdColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.245,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Waktu\nPembayaran",
                                                              style: GoogleFonts.inter(
                                                                  fontSize: 10,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      124,
                                                                      149,
                                                                      149),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 5.0),
                                                              child: Text(
                                                                formattedTime,
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        thirdColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.245,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "ID Eticket",
                                                        style: GoogleFonts.inter(
                                                            fontSize: 12,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                124,
                                                                149,
                                                                149),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                          "#${eticketCon.eticketData![index].id.toString()}",
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 10,
                                                                  color:
                                                                      thirdColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.245,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Status",
                                                              style: GoogleFonts.inter(
                                                                  fontSize: 10,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      124,
                                                                      149,
                                                                      149),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 5.0),
                                                              child: Text(
                                                                "Terbayar",
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        thirdColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.245,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Lottie.asset(
                                                          'assets/lottie/payment_done.json',
                                                          fit: BoxFit.cover),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ]),
                                      )
                                    ],
                                  ));
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                )));
  }
}
