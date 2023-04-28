import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/review_controller.dart';
import 'package:pergijalan_mobile/models/destinasi.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/destinasi_controller.dart';

class DetailDestinationOwner extends StatefulWidget {
  final Destinasi id;
  const DetailDestinationOwner({super.key, required this.id});

  @override
  State<DetailDestinationOwner> createState() => _DetailDestinationOwnerState();
}

class _DetailDestinationOwnerState extends State<DetailDestinationOwner> {
  // final TextEditingController reviewController = TextEditingController();
  // final reviewController = TextEditingController();
  TextEditingController? reviewController;

  String _review = '';

  double ratingController = 5;
  // int ratingController2 = 1;

  bool isLoading = false;
  bool isLoading2 = false;
  final Completer<GoogleMapController> _controller = Completer();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO DETAIL DESTINATION OWNER PAGE-----------");
    final reviewData = Provider.of<ReviewController>(context, listen: false);
    isLoading = true;

    Future.delayed(const Duration(seconds: 1)).then((value) async {
      try {
        print("get title destinasi : ${widget.id.nameDestinasi}");
        await reviewData.reviewDestinasiId(widget.id.id);
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : SingleChildScrollView(
                child: Consumer<DestinasiController>(
                    builder: (context, homeConOwner, child) {
                  return Column(children: [
                    Stack(children: [
                      SizedBox(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/images/slicing.jpg",
                              fit: BoxFit.cover,
                            )),
                      ),
                      Positioned(
                          top: 40,
                          left: 16,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: CircleAvatar(
                                  backgroundColor:
                                      Colors.grey.shade50.withOpacity(0.7),
                                  child: const Icon(Icons.chevron_left,
                                      color: primaryColor)),
                            ),
                          )),
                      Column(children: [
                        SizedBox(
                          height: 330,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16, 16.0, 16, 16),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: Text(
                                      widget.id.nameDestinasi!,
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                      style: GoogleFonts.rubik(
                                          fontSize: 20,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  widget.id.security == 1
                                      ? InkWell(
                                          onTap: () {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Kawasan dengan pengawasan security",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: primaryColor
                                                    .withOpacity(0.5),
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Color.fromARGB(
                                                      132, 27, 177, 197)),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0,
                                                          right: 5.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Keamanan",
                                                        style: GoogleFonts
                                                            .openSans(
                                                                fontSize: 9,
                                                                color:
                                                                    secondaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3.0),
                                                        child: Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                          size: 15,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 17,
                                      color: titleColor,
                                    ),
                                    Text(
                                      widget.id.city!,
                                      style: GoogleFonts.openSans(
                                          fontSize: 12,
                                          color: descColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: CircleAvatar(
                                        radius: 2,
                                        backgroundColor: Colors.black,
                                      ),
                                    ),
                                    Icon(
                                      Icons.access_time,
                                      size: 15,
                                      color: titleColor,
                                    ),
                                    widget.id.openHour == null &&
                                            widget.id.closedHour == null
                                        ? Text(
                                            "Anda belum memasukkan waktu kunjungan",
                                            style: GoogleFonts.openSans(
                                                fontSize: 9,
                                                color: Colors.red.shade700,
                                                fontWeight: FontWeight.w500),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0),
                                            child: Text(
                                              "${widget.id.openHour} - ${widget.id.closedHour} WIB",
                                              style: GoogleFonts.openSans(
                                                  fontSize: 12,
                                                  color: descColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                  ],
                                ),
                              )
                            ]),
                          ),
                        )
                      ]),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: thirdColor,
                        labelColor: Colors.grey.shade700,
                        unselectedLabelColor:
                            Color.fromARGB(255, 197, 197, 197),
                        tabs: [
                          Tab(
                            child: Text("    Overview    "),
                          ),
                          Tab(
                            child: Text("    Tinjauan    "),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    color: Color.fromARGB(255, 250, 250, 250),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, right: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 13,
                                          ),
                                          Text(
                                            "Deskripsi",
                                            style: GoogleFonts.kanit(
                                                fontSize: 17,
                                                color: primaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, bottom: 2.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  color: descColor,
                                                  size: 17,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: widget.id.contact !=
                                                          null
                                                      ? Text(
                                                          widget.id.contact
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  fontSize: 12,
                                                                  color:
                                                                      descColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        )
                                                      : Text(
                                                          "Anda belum memasukkan kontak tempat wisata",
                                                          maxLines: 4,
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .red
                                                                      .shade600,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ReadMoreText(
                                            widget.id.description!,
                                            style: GoogleFonts.openSans(
                                                fontSize: 13,
                                                color: descColor,
                                                fontWeight: FontWeight.w400),
                                            trimLines: 3,
                                            trimMode: TrimMode.Line,
                                            colorClickableText: secondaryColor,
                                            trimCollapsedText:
                                                " Baca lebih banyak",
                                            trimExpandedText: " Sembunyikan",
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 12.0),
                                            child: Container(
                                              height: 0.8,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: descColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    color: Color.fromARGB(255, 250, 250, 250),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, right: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 13,
                                          ),
                                          Text(
                                            "Rekomendasi",
                                            style: GoogleFonts.kanit(
                                                fontSize: 17,
                                                color: primaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 8, 8, 12),
                                            child: Container(
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  border: Border.all(
                                                    color: descColor,
                                                  )),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.27,
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                                // width: MediaQuery.of(
                                                                //             context)
                                                                //         .size
                                                                //         .width *
                                                                //     0.08,
                                                                child:
                                                                    const Icon(
                                                              Icons.access_time,
                                                              color:
                                                                  primaryColor,
                                                              size: 22,
                                                            )),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.17,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            4.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Waktu",
                                                                      style: GoogleFonts.openSans(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              descColor,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.17,
                                                                        child:
                                                                            Center(
                                                                          child: widget.id.minutesSpend != null
                                                                              ? Text(
                                                                                  widget.id.minutesSpend.toString(),
                                                                                  overflow: TextOverflow.clip,
                                                                                  maxLines: 3,
                                                                                  style: GoogleFonts.openSans(fontSize: 12, color: titleColor, fontWeight: FontWeight.w600),
                                                                                )
                                                                              : Text("Anda belum memasukkan rekomendasi waktu", maxLines: 4, style: GoogleFonts.openSans(fontSize: 9, color: Colors.red.shade600, fontWeight: FontWeight.w500)),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ]),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 18,
                                                              bottom: 18),
                                                      child: Container(
                                                        width: 1,
                                                        color: descColor,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.27,
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                                // width: MediaQuery.of(
                                                                //             context)
                                                                //         .size
                                                                //         .width *
                                                                //     0.08,
                                                                child: Icon(
                                                              Icons
                                                                  .cloud_outlined,
                                                              size: 22,
                                                              color:
                                                                  primaryColor,
                                                            )),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          4.0),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.17,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Cuaca",
                                                                      style: GoogleFonts.openSans(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              descColor,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    widget.id.recWeather !=
                                                                            null
                                                                        ? Text(
                                                                            widget.id.recWeather != null
                                                                                ? widget.id.recWeather!
                                                                                : "-",
                                                                            style: GoogleFonts.openSans(
                                                                                fontSize: 12,
                                                                                color: titleColor,
                                                                                fontWeight: FontWeight.w600),
                                                                          )
                                                                        : Text(
                                                                            "Anda belum memasukkan rekomendasi cuaca",
                                                                            maxLines:
                                                                                4,
                                                                            style: GoogleFonts.openSans(
                                                                                fontSize: 9,
                                                                                color: Colors.red.shade600,
                                                                                fontWeight: FontWeight.w500))
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ]),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 18,
                                                              bottom: 18),
                                                      child: Container(
                                                        width: 1,
                                                        color: descColor,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.27,
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                                // width: MediaQuery.of(
                                                                //             context)
                                                                //         .size
                                                                //         .width *
                                                                //     0.08,
                                                                child: Icon(
                                                              Icons
                                                                  .local_activity_outlined,
                                                              size: 22,
                                                              color:
                                                                  primaryColor,
                                                            )),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.17,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            4.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Minat",
                                                                      style: GoogleFonts.openSans(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              descColor,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.16,
                                                                        child: widget.id.hobby !=
                                                                                null
                                                                            ? Text(
                                                                                widget.id.hobby.toString(),
                                                                                style: GoogleFonts.openSans(fontSize: 12, color: titleColor, fontWeight: FontWeight.w400),
                                                                              )
                                                                            : Text("Anda belum memasukkan rekomendasi minat",
                                                                                maxLines: 4,
                                                                                style: GoogleFonts.openSans(fontSize: 9, color: Colors.red.shade600, fontWeight: FontWeight.w500)))
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ]),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Fasilitas umum yang tersedia",
                                            style: GoogleFonts.kanit(
                                                fontSize: 12,
                                                color: primaryColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: widget.id.fasility != null
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: labelColorBack),
                                                    child: Text(
                                                      widget.id.fasility
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 13,
                                                              color:
                                                                  primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  )
                                                : Text(
                                                    "Anda belum memasukkan fasilitas umum",
                                                    maxLines: 4,
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 9,
                                                        color:
                                                            Colors.red.shade600,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    color: Color.fromARGB(255, 250, 250, 250),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, right: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.location_searching_sharp,
                                                size: 17,
                                                color: titleColor,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.67,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    widget.id.address != null
                                                        ? widget.id.address!
                                                        : "-",
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 12,
                                                        color: descColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  if (widget.id.urlMap !=
                                                      null) {
                                                    var url =
                                                        widget.id.urlMap ?? "-";

                                                    try {
                                                      // ignore: deprecated_member_use
                                                      await launch(url);

                                                      if (url == null) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Tidak terdapat lokasi map",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      }
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Anda tidak memberikan link Google Map",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            Colors.red[300],
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);
                                                    return;
                                                  }
                                                },
                                                child: widget.id.urlMap != null
                                                    ? Container(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                secondaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                        height: 20,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                        child: Center(
                                                          child: Text(
                                                            "Google Map",
                                                            style: GoogleFonts.kanit(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                       width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                      child: Align(
                                                        alignment: Alignment.topRight,
                                                        child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.red.shade600,
                                                            child: Text("!", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                                                            radius: 9,
                                                          ),
                                                      ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3.0),
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: isLoading
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.blue,
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 600,
                                                        child: GoogleMap(
                                                          mapType:
                                                              MapType.normal,
                                                          zoomControlsEnabled:
                                                              false,
                                                          initialCameraPosition:
                                                              CameraPosition(
                                                            target: LatLng(
                                                                // widget.id.latitude!.toDouble() ,
                                                                // widget.id.longitude!.toDouble()
                                                                -6.175392,
                                                                106.827153
                                                                // lat,
                                                                // long
                                                                ),
                                                            zoom: 12,
                                                          ),
                                                          onMapCreated:
                                                              (GoogleMapController
                                                                  controller) {
                                                            _controller
                                                                .complete(
                                                                    controller);
                                                          },
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    ),
                                  )
                                : Consumer<ReviewController>(
                                    builder: (context, reviewData, child) {
                                    return SingleChildScrollView(
                                        child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      color: Color.fromARGB(255, 250, 250, 250),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, right: 16),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            Colors.white,
                                                        title: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Berapa penilaian anda tentang tempat wisata ini?",
                                                                style: GoogleFonts.openSans(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child: RatingBar
                                                                    .builder(
                                                                  initialRating:
                                                                      5,
                                                                  minRating: 1,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      false,
                                                                  itemCount: 5,
                                                                  itemPadding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              4.0),
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    setState(
                                                                        () {
                                                                      ratingController =
                                                                          rating;
                                                                    });
                                                                    print(
                                                                        rating);
                                                                  },
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                "Tulis ulasan anda",
                                                                style: GoogleFonts.openSans(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10.0),
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      border: Border.all(
                                                                          color:
                                                                              descColor)),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        reviewController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .multiline,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    onChanged:
                                                                        (text) {
                                                                      setState(
                                                                          () {
                                                                        _review =
                                                                            text;
                                                                      });
                                                                    },
                                                                    onSubmitted:
                                                                        (text) {
                                                                      setState(
                                                                          () {
                                                                        _review =
                                                                            text;
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    isLoading2 =
                                                                        true;
                                                                  });
                                                                  // final reviewText = reviewController.text;
                                                                  final reviewData = Provider.of<
                                                                          ReviewController>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                                  try {
                                                                    int intRating =
                                                                        ratingController
                                                                            .toInt();
                                                                    await reviewData.addReviewId(
                                                                        id: widget
                                                                            .id
                                                                            .id,
                                                                        rating:
                                                                            intRating,
                                                                        review:
                                                                            _review);

                                                                    if (reviewData
                                                                            .statusCode ==
                                                                        200) {
                                                                      setState(
                                                                          () {
                                                                        isLoading2 =
                                                                            false;
                                                                      });
                                                                      Fluttertoast.showToast(
                                                                          // msg: reviewData.messageAddReview
                                                                          //     .toString(),
                                                                          msg: "Terima kasih atas review Anda!",
                                                                          toastLength: Toast.LENGTH_SHORT,
                                                                          gravity: ToastGravity.BOTTOM,
                                                                          timeInSecForIosWeb: 1,
                                                                          backgroundColor: primaryColor.withOpacity(0.6),
                                                                          textColor: Colors.white,
                                                                          fontSize: 13);
                                                                      // ignore: use_build_context_synchronously
                                                                      Navigator.pop(
                                                                          context,
                                                                          false);
                                                                      await reviewData.reviewDestinasiId(
                                                                          widget
                                                                              .id
                                                                              .id);
                                                                    }
                                                                  } catch (e) {
                                                                    print("$e");
                                                                  }
                                                                  setState(() {
                                                                    isLoading2 =
                                                                        false;
                                                                  });
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10,
                                                                      top: 40),
                                                                  child:
                                                                      Container(
                                                                    height: 40,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color:
                                                                          secondaryColor,
                                                                    ),
                                                                    child: const Center(
                                                                        child: Text(
                                                                            "Kirim",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w600))),
                                                                  ),
                                                                ),
                                                              )
                                                            ]),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: descColor)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0),
                                                      child: Text(
                                                        "Tulis tinjauan disini",
                                                        style: GoogleFonts
                                                            .openSans(
                                                                fontSize: 11,
                                                                color:
                                                                    descColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 8.0),
                                                      child: Icon(
                                                        Icons.edit,
                                                        size: 20,
                                                        color: descColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                controller: _scrollController,
                                                scrollDirection: Axis.vertical,
                                                itemCount: reviewData
                                                    .reviewData!.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0,
                                                                top: 20.0,
                                                                right: 8,
                                                                left: 6),
                                                        child: Row(
                                                          children: [
                                                            const CircleAvatar(
                                                              radius: 20,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          230,
                                                                          230,
                                                                          230),
                                                              child: Icon(
                                                                Icons
                                                                    .people_alt_outlined,
                                                                color:
                                                                    secondaryColor,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0),
                                                              child: Container(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            "Nama User",
                                                                            style: GoogleFonts.openSans(
                                                                                fontSize: 11,
                                                                                color: titleColor,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                          const Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 8.0, right: 8.0),
                                                                            child:
                                                                                CircleAvatar(
                                                                              radius: 2,
                                                                              backgroundColor: Colors.black,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            reviewData.reviewData![index].rating.toString(),
                                                                            style: GoogleFonts.openSans(
                                                                                fontSize: 11,
                                                                                color: titleColor,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                          const Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 4.0),
                                                                            child:
                                                                                Icon(
                                                                              Icons.star,
                                                                              size: 15,
                                                                              color: Colors.amber,
                                                                            ),
                                                                          ),
                                                                        ]),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              3.0),
                                                                      child: Text(
                                                                          reviewData
                                                                              .reviewData![
                                                                                  index]
                                                                              .review!,
                                                                          style: GoogleFonts.openSans(
                                                                              fontSize: 13,
                                                                              color: descColor,
                                                                              fontWeight: FontWeight.w500)),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0,
                                                                right: 8.0),
                                                        child: Container(
                                                          height: 1,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          color: descColor,
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                }),
                                            const SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                                  })
                          ]),
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ]);
                }),
              ),
      ),
    );
  }
}
