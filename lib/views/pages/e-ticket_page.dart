import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/models/eticket.dart';
import 'package:pergijalan_mobile/views/pages/account_user_page.dart';
import 'package:pergijalan_mobile/views/widgets/bar_mainnavigation.dart';
import 'package:provider/provider.dart';

import '../../controllers/eticket_controller.dart';
import '../../models/destinasi.dart';

class ETicketPage extends StatefulWidget {
  final int id;
  final Destinasi idDestinasi;


  const ETicketPage({super.key, required this.id, required this.idDestinasi});

  @override
  State<ETicketPage> createState() => _ETicketPageState();
}

class _ETicketPageState extends State<ETicketPage> {
  bool isLoading = false;

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO LIST TIKET-----------");

    final eticketCon = Provider.of<ETicketController>(context, listen: false);
    isLoading = true;
    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        await eticketCon.eticketById(widget.id);
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
      bottomNavigationBar: isLoading
          ? const SizedBox()
          : Container(
              decoration: const BoxDecoration(
                color: secondaryColor,
              ),
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainNavigation(),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    "Kembali",
                    style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SingleChildScrollView(
              child: Consumer<ETicketController>(
                  builder: (context, ticketCon, child) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      // color: primaFryColor,
                      gradient: LinearGradient(
                        end: Alignment.topCenter,
                        begin: Alignment.center,
                        colors: [
                          secondaryColor,
                          Color.fromARGB(255, 12, 69, 104),
                          // thirdColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(children: [
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "E-Tiket",
                            style: GoogleFonts.openSans(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8))),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            top: 1,
                            bottom: 1,
                            right: 16,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Lottie.asset(
                                        'assets/lottie/payment_done.json',
                                        fit: BoxFit.cover)),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  // width: MediaQuery.of(context).size.width * 0.6,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Pembayaran Berhasil",
                                          style: GoogleFonts.openSans(
                                              fontSize: 16,
                                              color: secondaryColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "Selamat menikmati perjalanan\ndan liburan anda",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.openSans(
                                              fontSize: 10,
                                              color: captColor,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ]),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 3),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8))),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 15, bottom: 10, right: 22, left: 22),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Nama Pengunjung",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: captColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ticketCon.eticketDataiD!.nameVisitor
                                              .toString(),
                                          style: GoogleFonts.inter(
                                              fontSize: 15,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "#${ticketCon.eticketDataiD!.id}"
                                              .toString(),
                                          style: GoogleFonts.inter(
                                              fontSize: 11,
                                              color: captColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 20,
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: List.generate(
                                              150 ~/ 3,
                                              (index) => Expanded(
                                                    child: Container(
                                                      color: index % 2 == 0
                                                          ? Colors.grey.shade400
                                                          : Colors.transparent,
                                                      height: 1,
                                                    ),
                                                  )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.38,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Kontak Pengunjung",
                                              style: GoogleFonts.inter(
                                                  fontSize: 10,
                                                  color: captColor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Text(
                                                ticketCon
                                                    .eticketDataiD!.contactVisitor
                                                    .toString(),
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.38,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tanggal Pengunjung",
                                              style: GoogleFonts.inter(
                                                  fontSize: 10,
                                                  color: captColor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Text(
                                                ticketCon
                                                    .eticketDataiD!.dateVisit
                                                    .toString(),
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.38,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Jenis Tiket",
                                              style: GoogleFonts.inter(
                                                  fontSize: 10,
                                                  color: captColor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Text(
                                                "Nama Tiket",
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.38,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Harga",
                                              style: GoogleFonts.inter(
                                                  fontSize: 10,
                                                  color: captColor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Text(
                                               "Rp ${ticketCon
                                                    .eticketDataiD!.price
                                                    .toString()}",
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.38,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tempat Wisata",
                                              style: GoogleFonts.inter(
                                                  fontSize: 8,
                                                  color: captColor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Text(
                                                "Nama Wisata",
                                                maxLines: 4,
                                                style: GoogleFonts.inter(
                                                    fontSize: 10,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2.0),
                                              child: Text(
                                                "Jam tutup buka",
                                                style: GoogleFonts.inter(
                                                    fontSize: 10,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.38,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Lokasi",
                                              style: GoogleFonts.inter(
                                                  fontSize: 10,
                                                  color: captColor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Text(
                                                "Alamat",
                                                maxLines: 5,
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: secondaryColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(100),
                                        bottomRight: Radius.circular(100),
                                      ),
                                    ),
                                    height: 24,
                                    width: 12,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.71,
                                    child: Row(
                                      children: List.generate(
                                          150 ~/ 3,
                                          (index) => Expanded(
                                                child: Container(
                                                  color: index % 2 == 0
                                                      ? Colors.grey.shade500
                                                      : Colors.transparent,
                                                  height: 1,
                                                ),
                                              )),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: secondaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        bottomLeft: Radius.circular(100),
                                      ),
                                    ),
                                    height: 24,
                                    width: 12,
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 7,
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 22.0, right: 22),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                            "Peraturan Pembelian dan Kunjungan",
                                            style: GoogleFonts.inter(
                                                fontSize: 15,
                                                color: primaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Stack(
                                        children: [
                                          SizedBox(
                                            height: 55,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            child: Image.asset(
                                              "assets/logo/logo_putih.png",
                                            ),
                                          ),
                                          Container(
                                            height: 55,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Color.fromARGB(
                                                    143, 255, 255, 255)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.solidCircle,
                                          size: 4,
                                          color: titleColor,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "Pembatalan dan Pengembalian Uang",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 11,
                                                      color: captColor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, top: 2),
                                                child: Text(
                                                  "Tiket tidak dapat dibatalkan atau dikembalikan setelah dibeli, kecuali dalam keadaan tertentu yang ditetapkan oleh tempat wisata.",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 9,
                                                      color: captColor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.solidCircle,
                                          size: 4,
                                          color: titleColor,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "Penukaran Tiket",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 11,
                                                      color: captColor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, top: 2),
                                                child: Text(
                                                  "Pengguna harus menukarkan tiket elektronik dengan tiket fisik yang sah di pintu masuk tempat wisata. Pengguna harus menunjukkan identitas yang valid sesuai dengan ketentuan yang berlaku.",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 9,
                                                      color: captColor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 6,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Padding(
                                  //       padding: const EdgeInsets.only(top: 5.0),
                                  //       child: FaIcon(
                                  //         FontAwesomeIcons.solidCircle,
                                  //         size: 4,
                                  //         color: titleColor,
                                  //       ),
                                  //     ),
                                  //     Align(
                                  //       alignment: Alignment.topLeft,
                                  //       child: Container(
                                  //         width:
                                  //             MediaQuery.of(context).size.width * 0.7,
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           mainAxisAlignment: MainAxisAlignment.start,
                                  //           children: [
                                  //             Padding(
                                  //               padding:
                                  //                   const EdgeInsets.only(left: 8.0),
                                  //               child: Text(
                                  //                 "Penggunaan Tiket",
                                  //                 style: GoogleFonts.inter(
                                  //                     fontSize: 11,
                                  //                     color: captColor,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //             ),
                                  //             Padding(
                                  //               padding: const EdgeInsets.only(
                                  //                   left: 8.0, top: 5),
                                  //               child: Text(
                                  //                 "Tiket hanya berlaku untuk pemiliknya dan tidak dapat dipindahtangankan atau dijual kepada pihak lain tanpa izin resmi dari tempat wisata.",
                                  //                 style: GoogleFonts.inter(
                                  //                     fontSize: 9,
                                  //                     color: captColor,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
                );
              }),
            ),
    );
  }
}
