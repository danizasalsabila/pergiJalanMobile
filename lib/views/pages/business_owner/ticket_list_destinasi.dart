import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/create_destinationtour.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/home.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/ticket_create_page.dart';
import 'package:provider/provider.dart';

import '../../../controllers/ticket_controller.dart';
import '../../../models/destinasi.dart';

class TicketListPage extends StatefulWidget {
  final Destinasi id;

  TicketListPage({super.key, required this.id});

  @override
  State<TicketListPage> createState() => _TicketListPageState();
}

class _TicketListPageState extends State<TicketListPage> {
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO LIST TIKET-----------");
    final ticketCon = Provider.of<TicketController>(context, listen: false);
    // print(widget.id.id);

    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        print("ID DESTINASI ${widget.id.id}");
        await ticketCon.getTicketbyIdDestination(widget.id.id);
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SafeArea(child: SingleChildScrollView(
              child: Consumer<TicketController>(
                  builder: (context, ticketCon, child) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 170,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            "assets/images/slicing.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: 170,
                          color: Color.fromARGB(186, 36, 78, 79),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePageOwner(),
                                ),
                              );
                            },
                            child: const SizedBox(
                              height: 50,
                              child: Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                                size: 27,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 65,
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "List Tiket",
                                  style: GoogleFonts.openSans(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 120,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: ticketCon.anyTicket == true
                                  ? Column(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Center(
                                            child: Container(
                                          height: 3,
                                          width: 34,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: thirdColor),
                                        )),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.fromLTRB(
                                      //       20, 10, 20, 0),
                                      //   child: Align(
                                      //     alignment: Alignment.topLeft,
                                      //     child: Text(
                                      //       "Pilih berdasarkan persyaratan",
                                      //       style: GoogleFonts.notoSansDisplay(
                                      //           fontSize: 15,
                                      //           color: captColor,
                                      //           fontWeight: FontWeight.w500),
                                      //     ),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 15,
                                      // ),
                                      SizedBox(
                                        child: MediaQuery.removePadding(
                                          removeBottom: true,
                                          removeTop: true,
                                          context: context,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              controller: _scrollController,
                                              itemCount:
                                                  ticketCon.ticketData?.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 0, 20, 15),
                                                  child: Container(
                                                    // height: 150,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    199,
                                                                    199,
                                                                    199)
                                                                .withOpacity(
                                                                    0.8),
                                                            spreadRadius: 2,
                                                            blurRadius: 4,
                                                            offset: const Offset(
                                                                0,
                                                                2), // changes position of shadow
                                                          ),
                                                        ],
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                15,
                                                                12.0,
                                                                15,
                                                                15),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Text(
                                                                    "Tiket ${index + 1}",
                                                                    style: GoogleFonts.inter(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .orange,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                ),
                                                                ticketCon.ticketData![index]
                                                                            .stock ==
                                                                        0
                                                                    ? Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Color.fromARGB(
                                                                                234,
                                                                                196,
                                                                                88,
                                                                                86),
                                                                            borderRadius:
                                                                                BorderRadius.circular(6)),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              10,
                                                                              2.0,
                                                                              10,
                                                                              2.0),
                                                                          child:
                                                                              Text(
                                                                            "Terjual Habis",
                                                                            style: GoogleFonts.inter(
                                                                                fontSize: 11,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : SizedBox()
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 7.0),
                                                              child: Row(
                                                                children: List
                                                                    .generate(
                                                                        150 ~/
                                                                            3,
                                                                        (index) =>
                                                                            Expanded(
                                                                              child: Container(
                                                                                color: index % 2 == 0 ? Colors.grey.shade300 : Colors.transparent,
                                                                                height: 1,
                                                                              ),
                                                                            )),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 10.0,
                                                              ),
                                                              child: Row(
                                                                // mainAxisAlignment:
                                                                //     MainAxisAlignment
                                                                //         .spaceBetween,
                                                                children: [
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.05,
                                                                    height: 60,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            60,
                                                                        color: ticketCon.ticketData![index].stock ==
                                                                                0
                                                                            ? Color.fromARGB(
                                                                                255,
                                                                                196,
                                                                                88,
                                                                                86)
                                                                            : labelColor,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.008,
                                                                      ),
                                                                    ),
                                                                    // color: Colors.green,
                                                                    // height: 10,
                                                                  ),
                                                                  Container(
                                                                    // height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.35,
                                                                    child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "Jenis Tiket",
                                                                            style: GoogleFonts.openSans(
                                                                                fontSize: 8,
                                                                                color: captColor,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                50,
                                                                            child:
                                                                                Text(
                                                                              "Nama Tiket",
                                                                              overflow: TextOverflow.fade,
                                                                              maxLines: 2,
                                                                              style: GoogleFonts.openSans(fontSize: 14, color: ticketCon.ticketData![index].stock == 0 ? Color.fromARGB(255, 190, 77, 75) : labelColor, fontWeight: FontWeight.w700),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.35,
                                                                            height:
                                                                                20,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                FaIcon(
                                                                                  FontAwesomeIcons.boxesStacked,
                                                                                  size: 9,
                                                                                  color: captColor,
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 4.0),
                                                                                  child: Text(
                                                                                    "Stok: ",
                                                                                    style: GoogleFonts.openSans(fontSize: 9, color: captColor, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.25,
                                                                                  child: Text(
                                                                                    ticketCon.ticketData![index].stock.toString(),
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.fade,
                                                                                    style: GoogleFonts.openSans(fontSize: 9, color: titleColor, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ]),
                                                                  ),
                                                                  Container(
                                                                    // height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.35,
                                                                    child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topRight,
                                                                            child:
                                                                                Text(
                                                                              "Harga Tiket",
                                                                              style: GoogleFonts.openSans(fontSize: 8, color: captColor, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                50,
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.topRight,
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  Text(
                                                                                    "Rp ${ticketCon.ticketData![index].price.toString()}",
                                                                                    style: GoogleFonts.openSans(fontSize: 14, color: Colors.orange, fontWeight: FontWeight.w700),
                                                                                  ),
                                                                                  Text(
                                                                                    "/pax",
                                                                                    style: GoogleFonts.openSans(fontSize: 12, color: captColor, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.35,
                                                                            height:
                                                                                20,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                const FaIcon(
                                                                                  FontAwesomeIcons.checkToSlot,
                                                                                  size: 9,
                                                                                  color: captColor,
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 4.0),
                                                                                  child: Text(
                                                                                    "Terjual: ",
                                                                                    style: GoogleFonts.openSans(fontSize: 9, color: captColor, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.17,
                                                                                  child: Text(
                                                                                    ticketCon.ticketData![index].ticketSold != null ? ticketCon.ticketData![index].ticketSold.toString() : "0",
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.fade,
                                                                                    style: GoogleFonts.openSans(fontSize: 9, color: titleColor, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ]),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(top: 2),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.34,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                219,
                                                                                219,
                                                                                219),
                                                                            width:
                                                                                1),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    height: 26,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Ubah",
                                                                        style: GoogleFonts.openSans(
                                                                            fontSize:
                                                                                8,
                                                                            color:
                                                                                labelColor,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.05,
                                                                  ),
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                           showDialog(
                                                                                // barrierDismissible = false,
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return AlertDialog(
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      ),
                                                                                      backgroundColor: Colors.white,
                                                                                      elevation: 5,
                                                                                      title: Text(
                                                                                        "Konfirmasi Hapus Tiket Wisata",
                                                                                        style: GoogleFonts.notoSansDisplay(fontSize: 16, color: thirdColor, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                      content: Text(
                                                                                        "Harap diketahui bahwa menghapus data akan menghapus semua informasi yang terkait dengan data tersebut",
                                                                                        style: GoogleFonts.notoSansDisplay(fontSize: 12, color: titleColor, fontWeight: FontWeight.w400),
                                                                                      ),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                            onPressed: () {
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            child: Text(
                                                                                              "Batal",
                                                                                              style: GoogleFonts.openSans(fontSize: 12, color: descColor, fontWeight: FontWeight.w600),
                                                                                            )),
                                                                                        // child: Text("No")),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(right: 10.0),
                                                                                          child: Container(
                                                                                            height: 35,
                                                                                            decoration: BoxDecoration(color: thirdColor, borderRadius: BorderRadius.circular(7)),
                                                                                            child: TextButton(
                                                                                                onPressed: () async {
                                                                                                  isLoading = true;
                                                                                                  final ticketCon = Provider.of<TicketController>(context, listen: false);

                                                                                                  try {
                                                                                                    await ticketCon.deleteTicket(ticketCon.ticketData![index].id);

                                                                                                    if (ticketCon.statusCodeDeleteTicket == 200) {
                                                                                                      Navigator.pop(context);
                                                                                                      setState(() {
                                                                                                        isLoading = false;
                                                                                                      });
                                                                                                      await ticketCon.getTicketbyIdDestination(widget.id.id);


                                                                                                      await Fluttertoast.showToast(msg: ticketCon.messageDeleteTicket.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: primaryColor.withOpacity(0.6), textColor: Colors.white, fontSize: 16.0);
                                                                                                    } else if (ticketCon.statusCodeDeleteTicket == 404) {
                                                                                                      // ignore: use_build_context_synchronously
                                                                                                      Navigator.pop(context);
                                                                                                      setState(() {
                                                                                                        isLoading = false;
                                                                                                      });
                                                                                                      await Fluttertoast.showToast(msg: ticketCon.messageDeleteTicket.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red[300], textColor: Colors.white, fontSize: 16.0);
                                                                                                    }
                                                                                                  } catch (e) {
                                                                                                    setState(() {
                                                                                                      isLoading = false;
                                                                                                    });
                                                                                                    // ignore: use_build_context_synchronously
                                                                                                    Navigator.pop(context);
                                                                                                    Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red[300], textColor: Colors.white, fontSize: 16.0);
                                                                                                  }
                                                                                                  setState(() {});
                                                                                                },
                                                                                                child: Text(
                                                                                                  "Hapus",
                                                                                                  style: GoogleFonts.openSans(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),
                                                                                                )),
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    );
                                                                                  });
                                                                        },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.34,
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              color: const Color.fromARGB(255, 219, 219,
                                                                                  219),
                                                                              width:
                                                                                  1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5)),
                                                                      height:
                                                                          26,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "Hapus",
                                                                          style: GoogleFonts.openSans(
                                                                              fontSize: 8,
                                                                              color: labelColor,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ])
                                  : Column(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Center(
                                            child: Container(
                                          height: 3,
                                          width: 34,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: thirdColor),
                                        )),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 100,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Center(
                                            child: Text(
                                          "Belum terdapat penjualan tiket\nTekan tombol + untuk menambah penjualan tiket",
                                          style: GoogleFonts.openSans(
                                              fontSize: 11,
                                              color: captColor,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        )),
                                      )
                                    ]),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                );
              }),
            )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
            elevation: 8,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTicketPage(
                    idDestinasi: widget.id.id!,
                  ),
                ),
              );
            },
            backgroundColor: thirdColor,
            child: const FaIcon(FontAwesomeIcons.plus)),
      ),
    );
  }
}
