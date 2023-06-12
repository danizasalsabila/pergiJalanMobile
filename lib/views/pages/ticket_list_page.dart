import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/ticket_controller.dart';
import 'package:pergijalan_mobile/models/destinasi.dart';
import 'package:provider/provider.dart';

import 'ticket_create_order.dart';

class ListTicketDestination extends StatefulWidget {
  final Destinasi id;
  ListTicketDestination({super.key, required this.id});

  @override
  State<ListTicketDestination> createState() => _ListTicketDestinationState();
}

class _ListTicketDestinationState extends State<ListTicketDestination> {
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  var now = new DateTime.now();

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO LIST TIKET-----------");
    final ticketCon = Provider.of<TicketController>(context, listen: false);
    // print(widget.id.id);

    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        print(widget.id.id);
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
    String formattedDate = DateFormat('d MMMM yyyy').format(now);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Consumer<TicketController>(
                    builder: (context, ticketCon, child) {
                  return Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
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
                              color: Color.fromARGB(214, 12, 69, 104),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
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
                                      "Tiket Kunjungan",
                                      style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      formattedDate,
                                      style: GoogleFonts.notoSans(
                                          fontSize: 10,
                                          color: descColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 85,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: FaIcon(
                                              FontAwesomeIcons.locationDot,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                          ),
                                          Text(
                                            "Lokasi Anda",
                                            style: GoogleFonts.notoSansDisplay(
                                                fontSize: 10,
                                                color: captColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6.0, right: 6),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Row(
                                          children: List.generate(
                                              150 ~/ 3,
                                              (index) => Expanded(
                                                    child: Container(
                                                      color: index % 2 == 0
                                                          ? Colors.grey.shade300
                                                          : Colors.transparent,
                                                      height: 1,
                                                    ),
                                                  )),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: FaIcon(
                                              FontAwesomeIcons.mapLocation,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                          ),
                                          Text(
                                            widget.id.city.toString(),
                                            style: GoogleFonts.notoSansDisplay(
                                                fontSize: 10,
                                                color: captColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 130,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 250, 250, 250),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  ),
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Center(
                                          child: Container(
                                        height: 3,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: primaryColor),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Tiket Tersedia",
                                          style: GoogleFonts.notoSansDisplay(
                                              fontSize: 19,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Pilih berdasarkan persyaratan",
                                          style: GoogleFonts.notoSansDisplay(
                                              fontSize: 12,
                                              color: captColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
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
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  199,
                                                                  199,
                                                                  199)
                                                              .withOpacity(0.8),
                                                          spreadRadius: 2,
                                                          blurRadius: 4,
                                                          offset: const Offset(
                                                              0,
                                                              2), // changes position of shadow
                                                        ),
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        15, 18.0, 15, 15),
                                                    child: Column(children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Jenis Tiket",
                                                            style: GoogleFonts.inter(
                                                                fontSize: 16,
                                                                color:
                                                                    secondaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            "Harga Tiket",
                                                            style: GoogleFonts
                                                                .openSans(
                                                                    fontSize:
                                                                        11,
                                                                    color:
                                                                        captColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${widget.id.openHour.toString()} - ${widget.id.closedHour.toString()}",
                                                            style: GoogleFonts
                                                                .openSans(
                                                                    fontSize:
                                                                        10,
                                                                    color:
                                                                        captColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                "Rp ${ticketCon.ticketData![index].price.toString()}",
                                                                style: GoogleFonts.openSans(
                                                                    fontSize:
                                                                        19,
                                                                    color: Colors
                                                                        .orange,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                              Text(
                                                                "/pax",
                                                                style: GoogleFonts.openSans(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        captColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                          // DottedLine(
                                                          //   direction: Axis.vertical,

                                                          // )
                                                          // Flex(
                                                          //   direction: Axis.vertical,
                                                          //   children:[
                                                          //    const MySeparator(color: Colors.grey,)
                                                          //   ] )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Row(
                                                          children:
                                                              List.generate(
                                                                  150 ~/ 3,
                                                                  (index) =>
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          color: index % 2 == 0
                                                                              ? Colors.grey.shade300
                                                                              : Colors.transparent,
                                                                          height:
                                                                              1,
                                                                        ),
                                                                      )),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                          .orange[
                                                                      400],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        20,
                                                                        2.0,
                                                                        20,
                                                                        2),
                                                                child: Text(
                                                                  "Tiket ${index + 1}",
                                                                  style: GoogleFonts.openSans(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              "${ticketCon.ticketData![index].ticketSold} Terjual",
                                                              style: GoogleFonts.openSans(
                                                                  fontSize: 8,
                                                                  color:
                                                                      captColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      ticketCon
                                                                  .ticketData![
                                                                      index]
                                                                  .stock! <
                                                              5
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          2.0,
                                                                      bottom:
                                                                          4),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Text(
                                                                  "${ticketCon.ticketData![index].stock} Tiket tersisa!",
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          10,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          236,
                                                                          85,
                                                                          82),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.25,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    FaIcon(
                                                                      FontAwesomeIcons
                                                                          .textSlash,
                                                                      size: 10,
                                                                      color:
                                                                          captColor,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              3.0),
                                                                      child:
                                                                          Text(
                                                                        "Ubah pengunjung",
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: GoogleFonts.openSans(
                                                                            fontSize:
                                                                                9,
                                                                            color:
                                                                                captColor,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    FaIcon(
                                                                      FontAwesomeIcons
                                                                          .cancel,
                                                                      size: 10,
                                                                      color:
                                                                          captColor,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              5.0),
                                                                      child:
                                                                          Text(
                                                                        "Dibatalkan",
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: GoogleFonts.openSans(
                                                                            fontSize:
                                                                                9,
                                                                            color:
                                                                                captColor,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                 CreateOrderDetail( 
                                                                  idDestinasi: widget.id,
                                                                  idTicket: ticketCon.ticketData![index],
                                                                  ),
                                                          ),
                                                        );
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.41,
                                                              height: 33,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color:
                                                                      secondaryColor),
                                                              child: Center(
                                                                child: Text(
                                                                  "Pesan",
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    )
                                  ]),
                                )
                              ],
                            )
                          ],
                        ),
                      ]);
                }),
              ),
            ),
    );
  }
}
