import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/owner_business_controller.dart';
import 'package:pergijalan_mobile/controllers/review_controller.dart';
import 'package:pergijalan_mobile/controllers/ticket_controller.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/detail_touristdestinasion.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/edit_destinationtour.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/profile_owner.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/ticket_list_destinasi.dart';
import 'package:provider/provider.dart';

import '../../../controllers/destinasi_controller.dart';
import 'create_destinationtour.dart';

class HomePageOwner extends StatefulWidget {
  const HomePageOwner({super.key});

  @override
  State<HomePageOwner> createState() => _HomePageOwnerState();
}

class _HomePageOwnerState extends State<HomePageOwner> {
  final ScrollController _scrollController = ScrollController();

  var now = new DateTime.now();
  int _index = 0;

  bool isLoading = false;
  double? avgRating;
  bool anyData = false;
  bool anyMostSales = false;
  List<T> createDotMap<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO HOME PAGE ADMIN-----------");

    final ownerBusinessHomeCon =
        Provider.of<DestinasiController>(context, listen: false);
    final ownerCon =
        Provider.of<OwnerBusinessController>(context, listen: false);
    final reviewData = Provider.of<ReviewController>(context, listen: false);
    final ticketData = Provider.of<TicketController>(context, listen: false);

    isLoading = true;

    Future.delayed(const Duration(seconds: 2)).then((value) async {
      try {
        await ownerBusinessHomeCon.destinasiByIdOwner(ownerCon.idOBLogin);
        await reviewData.getRatingAverageByOwner(ownerCon.idOBLogin);
        await ticketData.getMostSalesTicketByOwner(ownerCon.idOBLogin);

        if (reviewData.statusCodeAvgRatingOwner == 200) {
          avgRating = reviewData.avgRatingOwner!;
          print(avgRating);
        } else {
          avgRating = 0;
        }

        if (ownerBusinessHomeCon.destinasiByOwnerStatusCode == 200) {
          anyData = true;
          print("oke");
          await ticketData.getTicketbyIdOwner(ownerCon.idOBLogin);
        } else {
          anyData = false;

          print(" gak oke");
        }

        if (ticketData.anySoldTicket == true) {
          anyMostSales = true;
        } else {
          anyMostSales = false;
        }
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  Color getRandomColor(int index) {
    Random random = Random(index);
    return Color.fromARGB(
      188,
      random.nextInt(36),
      random.nextInt(78),
      random.nextInt(79),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEEE, d MMM yyyy').format(now);
    final ownerCon =
        Provider.of<OwnerBusinessController>(context, listen: false);
    final ticketData = Provider.of<TicketController>(context, listen: false);

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: isLoading
          ? const Center(child: SizedBox())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                  elevation: 8,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateDestinationTourist(),
                      ),
                    );
                  },
                  backgroundColor: thirdColor,
                  child: const FaIcon(FontAwesomeIcons.plus)),
            ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SingleChildScrollView(
              child: Consumer<DestinasiController>(
                  builder: (context, homeCon, child) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 15),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Dashboard",
                                  style: GoogleFonts.inter(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 49, 49, 49),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 1, bottom: 7),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Laporan Pengelolaan ${ownerCon.nameLogin.toString()}",
                                  style: GoogleFonts.notoSansDisplay(
                                      fontSize: 11,
                                      color: descColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OwnerProfilePage(),
                                ),
                              );
                            },
                            child: const CircleAvatar(
                                radius: 21,
                                backgroundImage: AssetImage(
                                  "assets/logo/owner.png",
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       top: 8.0, bottom: 8, right: 20, left: 16),
                    //   child: Align(
                    //       alignment: Alignment.topLeft,
                    //       child: Text(
                    //         "Penjualan Tiket Terbanyak",
                    //         textAlign: TextAlign.left,
                    //         style: GoogleFonts.notoSansDisplay(
                    //             fontSize: 13,
                    //             color: descColor,
                    //             fontWeight: FontWeight.w500),
                    //       )),
                    // ),
                    //banner ticket sold (slicing)
                    anyMostSales == true
                        ? Container(
                            height: 186,
                            child: Consumer<TicketController>(
                                builder: (context, ticketCon, child) {
                              return Swiper(
                                  autoplay: true,
                                  itemCount:
                                      ticketCon.ticketDataMostSales!.length,
                                  // controller:
                                  //     PageController(viewportFraction: 0.85),
                                  onIndexChanged: (int index) => setState(() {
                                        _index = index;
                                      }),
                                  itemBuilder: (context, index) {
                                    Color randomColor = getRandomColor(index);
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Transform.scale(
                                        scale: index == _index ? 1 : 0.8,
                                        child: Container(
                                          height: 186,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                end: Alignment.bottomLeft,
                                                begin: Alignment.center,
                                                colors: [
                                                  randomColor,
                                                  Color.fromARGB(
                                                      255, 75, 150, 111),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Column(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 15.0, 16, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.37,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Color.fromARGB(
                                                            71, 255, 255, 255)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Center(
                                                        child: Text(
                                                          ticketCon
                                                              .ticketDataMostSales![
                                                                  index]
                                                              .destinasi!
                                                              .nameDestinasi
                                                              .toString(),
                                                          //           "sd k ckwe k dcw ekdcewk dkew dkw ekd cej cfe kfmc ke k k k kmn m",
                                                          overflow:
                                                              TextOverflow.fade,
                                                          // "Penjualan Tiket Terbanyak",
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5.0),
                                                    child: Text(
                                                      "${index + 1}",
                                                      style: GoogleFonts.kanit(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
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
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              formattedDate,
                                              style: GoogleFonts.openSans(
                                                  fontSize: 15,
                                                  color: Colors.grey.shade400,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0, right: 16),
                                              child: Container(
                                                height: 55,
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2)),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                            child: Center(
                                                              child: Text(
                                                                "Tiket Terjual",
                                                                style: GoogleFonts.openSans(
                                                                    fontSize: 9,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            166,
                                                                            36,
                                                                            78,
                                                                            79),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                            height: 30,
                                                            child: Center(
                                                              child: Text(
                                                                "${ticketCon.ticketDataMostSales![index].ticketSold.toString()}",
                                                                style: GoogleFonts.openSans(
                                                                    fontSize:
                                                                        15,
                                                                    color:
                                                                        thirdColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 1,
                                                        color: Color.fromARGB(
                                                            92, 36, 78, 79),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                            child: Center(
                                                              child: Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                "Tiket",
                                                                style: GoogleFonts.openSans(
                                                                    fontSize: 9,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            166,
                                                                            36,
                                                                            78,
                                                                            79),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 30,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                            child: Center(
                                                              child: Text(
                                                                ticketCon
                                                                    .ticketDataMostSales![
                                                                        index]
                                                                    .destinasi!
                                                                    .nameDestinasi
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts.openSans(
                                                                    fontSize:
                                                                        11,
                                                                    color:
                                                                        thirdColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                maxLines: 2,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 1,
                                                        color: Color.fromARGB(
                                                            92, 36, 78, 79),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                            child: Center(
                                                              child: Text(
                                                                "Sisa Stok",
                                                                style: GoogleFonts.openSans(
                                                                    fontSize: 9,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            166,
                                                                            36,
                                                                            78,
                                                                            79),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 30,
                                                            child: Center(
                                                              child: Text(
                                                                ticketCon
                                                                    .ticketDataMostSales![
                                                                        index]
                                                                    .stock
                                                                    .toString(),
                                                                style: GoogleFonts.openSans(
                                                                    fontSize:
                                                                        15,
                                                                    color:
                                                                        thirdColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
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
                                    );
                                  });
                            }),
                          )
                        : SizedBox(),

                    // anyMostSales == true
                    //     ? Column(
                    //         children: [
                    //           SizedBox(height: 8),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: <Widget>[
                    //               Row(
                    //                 children: createDotMap<Widget>(
                    //                   ticketData.ticketDataMostSales!,
                    //                   // listHeaderBanner2,
                    //                   (index, image) {
                    //                     return Container(
                    //                       alignment: Alignment.centerLeft,
                    //                       height: 5,
                    //                       width: 5,
                    //                       margin:
                    //                           const EdgeInsets.only(right: 3),
                    //                       decoration: BoxDecoration(
                    //                           shape: BoxShape.circle,
                    //                           color: _index == index
                    //                               ? labelColor
                    //                               : captColor),
                    //                     );
                    //                   },
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       )
                    //     : const SizedBox(),

                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 29,
                                          color: Colors.amber,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            avgRating == 0
                                                ? "-"
                                                : avgRating!.toStringAsFixed(1),
                                            textAlign: TextAlign.center,
                                            // "oke",
                                            style: GoogleFonts.kanit(
                                                fontSize: 44,
                                                color: Color.fromARGB(
                                                    255, 71, 71, 71),
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
                                isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.blue,
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 45),
                                                child: Text(
                                                  ticketData.ticketSoldOwner !=
                                                          0
                                                      ? ticketData
                                                          .ticketSoldOwner
                                                          .toString()
                                                      : '0',
                                                  style: GoogleFonts.kanit(
                                                      fontSize: 44,
                                                      color: labelColor,
                                                      fontWeight:
                                                          FontWeight.w500),
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
                    // const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Upload Terbaru",
                          style: GoogleFonts.notoSansDisplay(
                              fontSize: 14,
                              color: Color.fromARGB(255, 49, 49, 49),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : anyData == false
                            ? Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                    child: Text(
                                  "Belum terdapat pendaftaran tempat wisata\nTekan tombol + untuk menambah tempat wisata",
                                  style: GoogleFonts.openSans(
                                      fontSize: 11,
                                      color: captColor,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                )),
                              )
                            : Container(
                                padding:
                                    const EdgeInsets.only(left: 26, right: 26),
                                // width: MediaQuery.of(context).size.width,
                                // decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     border: Border.all(
                                //         color: Colors.grey.shade300, width: 1.5),
                                //     borderRadius: BorderRadius.circular(10)),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  controller: _scrollController,
                                  itemCount:
                                      homeCon.destinasiDataByOwner?.length,
                                  itemBuilder: (context, index) {
                                    return isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.blue,
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          const Color.fromARGB(
                                                                  255,
                                                                  211,
                                                                  211,
                                                                  211)
                                                              .withOpacity(0.7),
                                                      spreadRadius: 1,
                                                      blurRadius: 4,
                                                      offset: const Offset(2,
                                                          2), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: Colors.white,
                                                  // border: Border.all(
                                                  //     color: Colors.grey.shade300, width: 1.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, left: 10.0),
                                                child: InkWell(
                                                  onTap: (() => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailDestinationOwner(
                                                                id: homeCon
                                                                        .destinasiDataByOwner![
                                                                    index],
                                                              )))),
                                                  child: SizedBox(
                                                      child: Column(
                                                    children: [
                                                      Row(
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                height: 70,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.23,
                                                                child:
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/images/slicing.jpg",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )),
                                                              ),
                                                              Container(
                                                                height: 70,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.23,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                8),
                                                                    color: Color
                                                                        .fromARGB(
                                                                            106,
                                                                            75,
                                                                            150,
                                                                            111)),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 4.0,
                                                                    right: 8.0),
                                                            child: SizedBox(
                                                              height: 70,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.44,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        homeCon
                                                                            .destinasiDataByOwner![index]
                                                                            .nameDestinasi
                                                                            .toString(),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1,
                                                                        style: GoogleFonts.notoSansDisplay(
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                thirdColor,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          FaIcon(
                                                                            FontAwesomeIcons.locationDot,
                                                                            size:
                                                                                13,
                                                                            color:
                                                                                descColor,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 3.0),
                                                                            child:
                                                                                Text(
                                                                              homeCon.destinasiDataByOwner![index].city.toString(),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: GoogleFonts.notoSans(fontSize: 10, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => EditDestinationOwnerPage(
                                                                                            id: homeCon.destinasiDataByOwner![index],
                                                                                          )));
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 2.0, top: 4),
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: captColor), borderRadius: BorderRadius.circular(3)),
                                                                                height: 19,
                                                                                width: MediaQuery.of(context).size.width * 0.17,
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  "Ubah",
                                                                                  style: GoogleFonts.openSans(fontSize: 9, color: thirdColor, fontWeight: FontWeight.w500),
                                                                                )),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.007,
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
                                                                                        "Konfirmasi Hapus ${homeCon.destinasiDataByOwner![index].nameDestinasi.toString()}",
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
                                                                                                  final ownerBusinessHomeCon = Provider.of<DestinasiController>(context, listen: false);
                                                                                                  final ownerCon = Provider.of<OwnerBusinessController>(context, listen: false);
                                                                                                  try {
                                                                                                    await ownerBusinessHomeCon.deleteDestinasi(homeCon.destinasiDataByOwner![index].id);

                                                                                                    if (ownerBusinessHomeCon.statusCodeDeleteDestinasi == 200) {
                                                                                                      // ignore: use_build_context_synchronously
                                                                                                      // Navigator.pop(context);
                                                                                                      // ignore: use_build_context_synchronously

                                                                                                      // await ownerBusinessHomeCon.destinasiByIdOwner(ownerCon.idOBLogin);
                                                                                                      setState(() {
                                                                                                        isLoading = false;
                                                                                                      });
                                                                                                      Navigator.push(
                                                                                                        context,
                                                                                                        MaterialPageRoute(
                                                                                                          builder: (context) => const HomePageOwner(),
                                                                                                        ),
                                                                                                      );

                                                                                                      Fluttertoast.showToast(msg: ownerBusinessHomeCon.messageDeleteDestinasi.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: primaryColor.withOpacity(0.6), textColor: Colors.white, fontSize: 16.0);
                                                                                                    } else if (ownerBusinessHomeCon.statusCodeDeleteDestinasi == 404) {
                                                                                                      // ignore: use_build_context_synchronously
                                                                                                      Navigator.pop(context);
                                                                                                      setState(() {
                                                                                                        isLoading = false;
                                                                                                      });
                                                                                                      await Fluttertoast.showToast(msg: ownerBusinessHomeCon.messageDeleteDestinasi.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red[300], textColor: Colors.white, fontSize: 16.0);
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
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(top: 4),
                                                                              child: Container(
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), border: Border.all(color: captColor)),
                                                                                height: 19,
                                                                                width: MediaQuery.of(context).size.width * 0.17,
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  "Hapus",
                                                                                  style: GoogleFonts.openSans(fontSize: 9, color: thirdColor, fontWeight: FontWeight.w500),
                                                                                )),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    ]),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            TicketListPage(
                                                                      id: homeCon
                                                                              .destinasiDataByOwner![
                                                                          index],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              // onTap: () async {
                                                              //   showDialog(
                                                              //       context:
                                                              //           context,
                                                              //       builder:
                                                              //           (context) {
                                                              //         return AlertDialog(
                                                              //           shape:
                                                              //               RoundedRectangleBorder(
                                                              //             borderRadius:
                                                              //                 BorderRadius.circular(10),
                                                              //           ),
                                                              //           backgroundColor:
                                                              //               Colors.white,
                                                              //           elevation:
                                                              //               5,
                                                              //           title:
                                                              //               Text(
                                                              //             "Konfirmasi Hapus ${homeCon.destinasiDataByOwner![index].nameDestinasi.toString()}",
                                                              //             style: GoogleFonts.notoSansDisplay(
                                                              //                 fontSize: 17,
                                                              //                 color: thirdColor,
                                                              //                 fontWeight: FontWeight.w600),
                                                              //           ),
                                                              //           content:
                                                              //               Text(
                                                              //             "Harap diketahui bahwa menghapus data akan menghapus semua informasi terkait dengan data tersebut",
                                                              //             style: GoogleFonts.notoSansDisplay(
                                                              //                 fontSize: 13,
                                                              //                 color: titleColor,
                                                              //                 fontWeight: FontWeight.w400),
                                                              //           ),
                                                              //           actions: [
                                                              //             TextButton(
                                                              //                 onPressed: () {
                                                              //                   Navigator.pop(context);
                                                              //                 },
                                                              //                 child: Text(
                                                              //                   "Batal",
                                                              //                   style: GoogleFonts.openSans(fontSize: 14, color: descColor, fontWeight: FontWeight.w600),
                                                              //                 )),
                                                              //             // child: Text("No")),
                                                              //             Padding(
                                                              //               padding:
                                                              //                   const EdgeInsets.only(right: 10.0),
                                                              //               child:
                                                              //                   Container(
                                                              //                 height: 35,
                                                              //                 decoration: BoxDecoration(color: thirdColor, borderRadius: BorderRadius.circular(7)),
                                                              //                 child: TextButton(
                                                              //                     onPressed: () async {
                                                              //                       isLoading = true;
                                                              //                       final ownerBusinessHomeCon = Provider.of<DestinasiController>(context, listen: false);
                                                              //                       final ownerCon = Provider.of<OwnerBusinessController>(context, listen: false);
                                                              //                       try {
                                                              //                         await ownerBusinessHomeCon.deleteDestinasi(homeCon.destinasiDataByOwner![index].id);

                                                              //                         if (ownerBusinessHomeCon.statusCodeDeleteDestinasi == 200) {
                                                              //                           // ignore: use_build_context_synchronously
                                                              //                           Navigator.pop(context);
                                                              //                           // ignore: use_build_context_synchronously
                                                              //                           setState(() {
                                                              //                             isLoading = false;
                                                              //                           });
                                                              //                           await ownerBusinessHomeCon.destinasiByIdOwner(ownerCon.idOBLogin);

                                                              //                           await Fluttertoast.showToast(msg: ownerBusinessHomeCon.messageDeleteDestinasi.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: primaryColor.withOpacity(0.6), textColor: Colors.white, fontSize: 16.0);
                                                              //                         } else if (ownerBusinessHomeCon.statusCodeDeleteDestinasi == 404) {
                                                              //                           // ignore: use_build_context_synchronously
                                                              //                           Navigator.pop(context);
                                                              //                           setState(() {
                                                              //                             isLoading = false;
                                                              //                           });
                                                              //                           await Fluttertoast.showToast(msg: ownerBusinessHomeCon.messageDeleteDestinasi.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red[300], textColor: Colors.white, fontSize: 16.0);
                                                              //                         }
                                                              //                       } catch (e) {
                                                              //                         setState(() {
                                                              //                           isLoading = false;
                                                              //                         });
                                                              //                         // ignore: use_build_context_synchronously
                                                              //                         Navigator.pop(context);
                                                              //                         Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red[300], textColor: Colors.white, fontSize: 16.0);
                                                              //                       }
                                                              //                       setState(() {});
                                                              //                     },
                                                              //                     child: Text(
                                                              //                       "Hapus",
                                                              //                       style: GoogleFonts.openSans(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
                                                              //                     )),
                                                              //               ),
                                                              //             )
                                                              //           ],
                                                              //         );
                                                              //       });
                                                              // },
                                                              child: Container(
                                                                height: 22,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.072,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  // border: Border.all(color: thirdColor),
                                                                  color: Color
                                                                      .fromARGB(
                                                                          183,
                                                                          36,
                                                                          78,
                                                                          79),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Color.fromARGB(
                                                                              255,
                                                                              211,
                                                                              211,
                                                                              211)
                                                                          .withOpacity(
                                                                              0.7),
                                                                      spreadRadius:
                                                                          1,
                                                                      blurRadius:
                                                                          4,
                                                                      offset: const Offset(
                                                                          2,
                                                                          2), // changes position of shadow
                                                                    ),
                                                                  ],
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: FaIcon(
                                                                    FontAwesomeIcons
                                                                        .ticket,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 11,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 15,
                                                        ),
                                                        child: Container(
                                                          height: 1,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          color: Colors
                                                              .grey.shade100,
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ),
                                          );
                                  },
                                ),
                              ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }),
            ),
    );
  }
}
