import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pergijalan_mobile/views/widgets/bar_mainnavigation.dart';
import 'package:provider/provider.dart';

import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/eticket_controller.dart';
import 'package:pergijalan_mobile/controllers/user_controller.dart';
import 'package:pergijalan_mobile/views/pages/eticket_page.dart';

import '../../models/destinasi.dart';
import '../../models/eticket.dart';

class StatusOrderPayment extends StatefulWidget {
  final int id;
  int totalPrice;
  // final Destinasi idDestinasi;
  StatusOrderPayment({
    Key? key,
    required this.id,
    required this.totalPrice,
  }) : super(key: key);

  @override
  State<StatusOrderPayment> createState() => _StatusOrderPaymentState();
}

class _StatusOrderPaymentState extends State<StatusOrderPayment> {
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
      //  Timer(Duration(seconds: 3), () {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (context) => ETicketPage(id: widget.id, )));
      //   });

      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  _showAlert(BuildContext context) {
    final eticketCon = Provider.of<ETicketController>(context, listen: false);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: backgroundColor,
              content: Container(
                                  height: 350,

                child: Center(
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Lottie.asset('assets/lottie/payment_done.json',
                              fit: BoxFit.cover)),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Pembayaran Sukses",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: Color.fromARGB(255, 61, 61, 61),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Rp ${widget.totalPrice.toString()}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            color: Color.fromARGB(255, 61, 61, 61),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tanggal Pembayaran",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                color: captColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              eticketCon.eticketDataiD!.dateBook!
                                  .substring(0, 10),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 61, 61, 61),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Waktu Pembayaran",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                color: captColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              eticketCon.eticketDataiD!.dateBook!
                                  .substring(10, 19),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 61, 61, 61),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Metode Pembayaran",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                color: captColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "Mandiri Transfer",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 61, 61, 61),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MainNavigation(
                                    indexNav: 2,
                                  )));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Lihat Riwayat Pembelian",
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(8))),
                      ), SizedBox(height:
                      8),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MainNavigation(
                                    indexNav: 0,
                                  )));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Kembali",
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            decoration: BoxDecoration(
                                // color: secondaryColor,
                                color: backgroundColor,
                                border: Border.all(color: secondaryColor),
                                borderRadius: BorderRadius.circular(8))),
                      )
                    ],
                  ),
                ),
              ),
              // content: Text(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Consumer<ETicketController>(builder: (context, eticketCon, child) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: CircleAvatar(
                      child: InkWell(
                        onTap: () {
                          _showAlert(context);
                        },
                        child: Center(
                            child: CircularProgressIndicator(
                          color: primaryColor,
                          strokeWidth: 6,
                        )),
                      ),
                      radius: 45,
                      backgroundColor: Colors.grey.shade300,
                    )),
                    SizedBox(
                      height: 14,
                    ),
                    Center(
                      child: Text(
                        "Status:\nBelum Bayar",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Color.fromARGB(255, 61, 61, 61),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Center(
                        child: Text(
                          "Lakukan Pembayaran",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Color.fromARGB(255, 61, 61, 61),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      // height: 45,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(18, 20.0, 18, 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Mandiri Virtual Akun",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: captColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: Image.asset(
                                      "assets/logo/mandiri_logo.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Nomor Virtual Akun",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: captColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    eticketCon.eticketDataiD!.virtualAccount
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 61, 61, 61),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Pembayaran",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: captColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Rp ${widget.totalPrice.toString()}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 61, 61, 61),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              // Align(
                              //   alignment: Alignment.topRight,
                              //   child: Text(
                              //     eticketCon.eticketDataiD!.dateBook.toString(),
                              //     textAlign: TextAlign.center,
                              //     style: GoogleFonts.inter(
                              //         fontSize: 11,
                              //         color: captColor,
                              //         fontWeight: FontWeight.w500),
                              //   ),
                              // ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "E-tiket akan terbit setelah pembayaran\nterverifikasi",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 11,
                            color: descColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ]);
            }),
    );
  }
}
