import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/eticket_controller.dart';
import 'package:pergijalan_mobile/controllers/user_controller.dart';
import 'package:pergijalan_mobile/views/pages/eticket_page.dart';
import 'package:provider/provider.dart';

import '../../models/destinasi.dart';
import '../../models/eticket.dart';

class StatusOrderPayment extends StatefulWidget {
  final int id;
  // final Destinasi idDestinasi;
  StatusOrderPayment({super.key, required this.id, 
  // required this.idDestinasi
  });

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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ETicketPage(
                                    id: widget.id,
                                  )));
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
                                    "Rp ${eticketCon.eticketDataiD!.totalPrice.toString()}",
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
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  eticketCon.eticketDataiD!.dateBook.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: captColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
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
