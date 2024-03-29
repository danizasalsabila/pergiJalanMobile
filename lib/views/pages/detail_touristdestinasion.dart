import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/review_controller.dart';
import 'package:pergijalan_mobile/controllers/ticket_controller.dart';
import 'package:pergijalan_mobile/controllers/user_controller.dart';
import 'package:pergijalan_mobile/models/destinasi.dart';
import 'package:pergijalan_mobile/views/pages/ticket_list_page.dart';
import 'package:pergijalan_mobile/views/pages/account_login_user.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/destinasi_controller.dart';

class DetailDestination extends StatefulWidget {
  final Destinasi id;
  const DetailDestination({super.key, required this.id});

  @override
  State<DetailDestination> createState() => _DetailDestinationState();
}

class _DetailDestinationState extends State<DetailDestination> {
  // final TextEditingController reviewController = TextEditingController();
  // final reviewController = TextEditingController();
  TextEditingController? reviewController;

  String _review = '';

  double ratingController = 5;
  // int ratingController2 = 1;

  bool isLoading = false;
  bool isLoading2 = false;
  bool isUserLogin = false;

  String? text;
  bool avgRatingBool = false;
  double? avgRating;
  bool anyTicketData = false;

  List<String> data = [];
  final Completer<GoogleMapController> _controller = Completer();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO LIST DATA BY CATEGORY-----------");
    // final detailData = Provider.of<DestinasiController>(context, listen: false);
    final reviewData = Provider.of<ReviewController>(context, listen: false);
    final profileCon = Provider.of<UserController>(context, listen: false);
    final ticketCon = Provider.of<TicketController>(context, listen: false);

    isLoading = true;

    Future.delayed(const Duration(seconds: 1)).then((value) async {
      try {
        print("get title destinasi : ${widget.id.nameDestinasi}");
        await reviewData.reviewDestinasiId(widget.id.id);
        await reviewData.getRatingAverageById(widget.id.id);
        await ticketCon.getTicketbyIdDestination(widget.id.id);

        if (reviewData.statusCodeAvgRating == 200) {
          avgRatingBool = true;
          avgRating = reviewData.avgRating!;
        } else {
          avgRatingBool = false;
        }

        if (profileCon.isLogin == false) {
          isUserLogin = false;
        } else {
          isUserLogin = true;
        }

        await Future.delayed(Duration.zero);
        text = widget.id.fasility.toString();

        if (text!.contains(',')) {
          data = text!.split(',');
        } else {
          print('Teks fasilitas tidak mengandung koma');
          data = [text!];
        }

        if (ticketCon.anyTicket == true) {
          anyTicketData = true;
          print("ada $anyTicketData");
        } else {
          anyTicketData = false;
          print("tidak ada $anyTicketData");
        }
      } catch (e) {
        e;
      }
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
    // reviewController = TextEditingController(text: reviewData.reviewData![index].review ?? "");
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
                      builder: (context, homeCon, child) {
                    // print("------ ${widget.id.latitude}");
                    // print("------ ${widget.id.longitude}");
                    //   String? latitude =  widget.id.latitude;
                    // double lat = double.parse(latitude!);
                    // print("LAT: $lat");

                    //   String? longitude =  widget.id.longitude;
                    // double long = double.parse(longitude!);
                    return Column(children: [
                      Stack(children: [
                        // Container(
                        //   color: Colors.black,
                        //   height: 400,
                        // ),
                        Container(
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: widget.id.destinationPicture == null
                                ? Image.asset(
                                    "assets/images/no_image2.jpg",
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    placeholder: (context, url) => Center(
                                        child: new CircularProgressIndicator()),
                                    imageUrl: widget.id.destinationPicture!,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      "assets/images/error_image.jpeg",
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 295,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: thirdColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 13.0,
                                          right: 13.0,
                                          top: 3,
                                          bottom: 3),
                                      child: Text(
                                        widget.id.category.toString(),
                                        style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            color: backgroundColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              )
                            ],
                          ),
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
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
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
                                                        BorderRadius.circular(
                                                            5),
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
                                                                  fontSize: 11,
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
                                        color: descColor,
                                      ),
                                      Text(
                                        widget.id.city!,
                                        style: GoogleFonts.openSans(
                                            fontSize: 13,
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
                                        color: descColor,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 2.0),
                                        child: widget.id.openHour != null &&
                                                widget.id.closedHour != null
                                            ? Row(
                                                children: [
                                                  Text(
                                                    widget.id.openHour
                                                        .toString(),
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 13,
                                                        color: descColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    " - ",
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 13,
                                                        color: descColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    widget.id.closedHour
                                                        .toString(),
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 13,
                                                        color: descColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                "-",
                                                style: GoogleFonts.openSans(
                                                    fontSize: 12,
                                                    color: descColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                                avgRatingBool
                                    ? Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, top: 8),
                                              child: RatingBarIndicator(
                                                rating: avgRating!,
                                                itemBuilder: (context, ndex) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 17.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0, top: 8.0),
                                              child: Text(
                                                avgRating!.toStringAsFixed(1),
                                                style: GoogleFonts.openSans(
                                                    fontSize: 13,
                                                    color: descColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
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
                        height: MediaQuery.of(context).size.height * 0.6,
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
                                                  top: 4.0, bottom: 6.0),
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
                                                    child: Text(
                                                      widget.id.contact != null
                                                          ? widget.id.contact!
                                                          : "-",
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 13,
                                                              color: descColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ReadMoreText(
                                              widget.id.description!,
                                              textAlign: TextAlign.justify,
                                              style: GoogleFonts.openSans(
                                                  fontSize: 13,
                                                  color: descColor,
                                                  fontWeight: FontWeight.w400),
                                              trimLines: 3,
                                              trimMode: TrimMode.Line,
                                              colorClickableText:
                                                  secondaryColor,
                                              trimCollapsedText:
                                                  " Baca lebih banyak",
                                              trimExpandedText: " Sembunyikan",
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0, bottom: 14.0),
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8.0, 8, 8, 12),
                                              child: Container(
                                                height: 80,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    border: Border.all(
                                                      color: descColor,
                                                    )),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
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
                                                                Icons
                                                                    .access_time,
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
                                                                  padding: const EdgeInsets
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
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.17,
                                                                          child:
                                                                              Center(
                                                                            child: widget.id.minutesSpend != null
                                                                                ? Text(
                                                                                    widget.id.minutesSpend.toString(),
                                                                                    overflow: TextOverflow.clip,
                                                                                    maxLines: 3,
                                                                                    style: GoogleFonts.openSans(fontSize: 12, color: titleColor, fontWeight: FontWeight.w500),
                                                                                  )
                                                                                : Text(
                                                                                    "-",
                                                                                    style: GoogleFonts.openSans(fontSize: 12, color: titleColor, fontWeight: FontWeight.w500),
                                                                                  ),
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
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 18,
                                                                bottom: 18),
                                                        child: Container(
                                                          width: 1,
                                                          color: descColor,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
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
                                                                child:
                                                                    Container(
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
                                                                              widget.id.recWeather.toString(),
                                                                              style: GoogleFonts.openSans(fontSize: 12, color: titleColor, fontWeight: FontWeight.w500),
                                                                            )
                                                                          : Text(
                                                                              "-",
                                                                              maxLines: 4,
                                                                              style: GoogleFonts.openSans(fontSize: 12, color: titleColor, fontWeight: FontWeight.w500),
                                                                            )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ]),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 18,
                                                                bottom: 18),
                                                        child: Container(
                                                          width: 1,
                                                          color: descColor,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
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
                                                                  padding: const EdgeInsets
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
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.16,
                                                                          child: widget.id.hobby != null
                                                                              ? Text(
                                                                                  widget.id.hobby.toString(),
                                                                                  style: GoogleFonts.openSans(fontSize: 12, color: titleColor, fontWeight: FontWeight.w500),
                                                                                )
                                                                              : Text(
                                                                                  "-",
                                                                                  maxLines: 1,
                                                                                  style: GoogleFonts.openSans(fontSize: 12, color: titleColor, fontWeight: FontWeight.w500),
                                                                                ))
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
                                                  fontSize: 14,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            widget.id.fasility == null ||
                                                    widget.id.fasility == ''
                                                ? Text(
                                                    "Tidak terdapat fasilitas",
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 11,
                                                        color: descColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: SizedBox(
                                                      height: 30,
                                                      child: ListView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          shrinkWrap: true,
                                                          // controller: _scrollController,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              data.length,
                                                          itemBuilder:
                                                              (context, i) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      right:
                                                                          8.0),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    color:
                                                                        labelColorBack),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          12.0,
                                                                      right:
                                                                          12.0),
                                                                  child: Center(
                                                                    child: Text(
                                                                      data[i],
                                                                      style: GoogleFonts.openSans(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  ),
                                            const SizedBox(
                                              height: 14,
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
                                            Text(
                                              "Lokasi wisata",
                                              style: GoogleFonts.kanit(
                                                  fontSize: 15,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .location_searching_sharp,
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
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 13,
                                                              color: descColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
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
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: secondaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    height: 20,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    child: Center(
                                                      child: Text(
                                                        "Google Map",
                                                        style:
                                                            GoogleFonts.kanit(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(
                                            //       top: 3.0),
                                            //   child: SizedBox(
                                            //     height: MediaQuery.of(context)
                                            //             .size
                                            //             .height *
                                            //         0.2,
                                            //     child: ClipRRect(
                                            //       borderRadius:
                                            //           BorderRadius.circular(8),
                                            //       child: isLoading
                                            //           ? const Center(
                                            //               child:
                                            //                   CircularProgressIndicator(
                                            //                 color: Colors.blue,
                                            //               ),
                                            //             )
                                            //           : SizedBox(
                                            //               width: MediaQuery.of(
                                            //                       context)
                                            //                   .size
                                            //                   .width,
                                            //               height: 600,
                                            //               child: GoogleMap(
                                            //                 mapType:
                                            //                     MapType.normal,
                                            //                 zoomControlsEnabled:
                                            //                     false,
                                            //                 initialCameraPosition:
                                            //                     CameraPosition(
                                            //                   target: LatLng(
                                            //                       // widget.id.latitude!.toDouble() ,
                                            //                       // widget.id.longitude!.toDouble()
                                            //                       -6.175392,
                                            //                       106.827153
                                            //                       // lat,
                                            //                       // long
                                            //                       ),
                                            //                   zoom: 12,
                                            //                 ),
                                            //                 onMapCreated:
                                            //                     (GoogleMapController
                                            //                         controller) {
                                            //                   _controller
                                            //                       .complete(
                                            //                           controller);
                                            //                 },
                                            //               ),
                                            //             ),
                                            //     ),
                                            //   ),
                                            // ),
                                            // SizedBox(height: 10)
                                          ],
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 10,
                                    // )
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color:
                                            Color.fromARGB(255, 250, 250, 250),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0, right: 16),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              isUserLogin == true
                                                  ? InkWell(
                                                      onTap: () async {
                                                        await showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
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
                                                                                14,
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(10),
                                                                        child: RatingBar
                                                                            .builder(
                                                                          initialRating:
                                                                              5,
                                                                          minRating:
                                                                              1,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          allowHalfRating:
                                                                              false,
                                                                          itemCount:
                                                                              5,
                                                                          itemPadding:
                                                                              EdgeInsets.symmetric(horizontal: 4.0),
                                                                          itemBuilder: (context, _) =>
                                                                              Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Colors.amber,
                                                                          ),
                                                                          onRatingUpdate:
                                                                              (rating) {
                                                                            setState(() {
                                                                              ratingController = rating;
                                                                            });
                                                                            print(rating);
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      Text(
                                                                        "Tulis ulasan anda",
                                                                        style: GoogleFonts.openSans(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 10.0),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              100,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              border: Border.all(color: descColor)),
                                                                          child:
                                                                              TextField(
                                                                                maxLines: 3,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              border: InputBorder.none,
                                                                            ),
                                                                            controller:
                                                                                reviewController,
                                                                            keyboardType:
                                                                                TextInputType.multiline,
                                                                            textInputAction:
                                                                                TextInputAction.next,
                                                                            onChanged:
                                                                                (text) {
                                                                              setState(() {
                                                                                _review = text;
                                                                              });
                                                                            },
                                                                            onSubmitted:
                                                                                (text) {
                                                                              setState(() {
                                                                                _review = text;
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          setState(
                                                                              () {
                                                                            isLoading2 =
                                                                                true;
                                                                          });
                                                                          // final reviewText = reviewController.text;
                                                                          final reviewData = Provider.of<ReviewController>(
                                                                              context,
                                                                              listen: false);
                                                                          final userCon = Provider.of<UserController>(
                                                                              context,
                                                                              listen: false);
                                                                          try {
                                                                            int intRating =
                                                                                ratingController.toInt();

                                                                            await reviewData.addReviewId(
                                                                                id: widget.id.id,
                                                                                idUser: userCon.idUserLogin,
                                                                                rating: intRating,
                                                                                review: _review);

                                                                            if (reviewData.statusCode ==
                                                                                200) {
                                                                              setState(() {
                                                                                isLoading2 = false;
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
                                                                              Navigator.pop(context, false);
                                                                              await reviewData.reviewDestinasiId(widget.id.id);
                                                                              await reviewData.getRatingAverageById(widget.id.id);
                                                                              if (reviewData.statusCodeAvgRating == 200) {
                                                                                avgRatingBool = true;
                                                                                avgRating = reviewData.avgRating!;
                                                                              } else {
                                                                                avgRatingBool = false;
                                                                              }
                                                                            }
                                                                          } catch (e) {
                                                                            print("$e");
                                                                          }
                                                                          setState(
                                                                              () {
                                                                            isLoading2 =
                                                                                false;
                                                                          });
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              bottom: 10,
                                                                              top: 40),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: secondaryColor,
                                                                            ),
                                                                            child:
                                                                                const Center(child: Text("Kirim", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))),
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
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                                color:
                                                                    descColor)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          16.0),
                                                              child: Text(
                                                                "Tulis tinjauan disini",
                                                                style: GoogleFonts.openSans(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        descColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          8.0),
                                                              child: Icon(
                                                                Icons.edit,
                                                                size: 20,
                                                                color:
                                                                    descColor,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () async {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Masuk ke akun anda sebelum memberikan ulasan",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                primaryColor
                                                                    .withOpacity(
                                                                        0.5),
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginUser(),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                                color:
                                                                    descColor)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          16.0),
                                                              child: Text(
                                                                "Tulis tinjauan disini",
                                                                style: GoogleFonts.openSans(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        descColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          8.0),
                                                              child: Icon(
                                                                Icons.edit,
                                                                size: 20,
                                                                color:
                                                                    descColor,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                              const SizedBox(height: 5),
                                              ListView.builder(
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  controller: _scrollController,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: reviewData
                                                      .reviewData!.length,
                                                  itemBuilder:
                                                      (context, index) {
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
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.1,
                                                                child:
                                                                    const CircleAvatar(
                                                                  radius: 20,
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          230,
                                                                          230,
                                                                          230),
                                                                  child: FaIcon(
                                                                    FontAwesomeIcons
                                                                        .solidUser,
                                                                    size: 15,
                                                                    color:
                                                                        secondaryColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            12.0),
                                                                child: SizedBox(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.7,
                                                                        child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                reviewData.reviewData![index].user!.name!.toString() != null ? reviewData.reviewData![index].user!.name! : '-',
                                                                                style: GoogleFonts.openSans(fontSize: 13, color: titleColor, fontWeight: FontWeight.w500),
                                                                              ),
                                                                              const Padding(
                                                                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                                                                child: CircleAvatar(
                                                                                  radius: 2,
                                                                                  backgroundColor: Colors.black,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                reviewData.reviewData![index].rating.toString(),
                                                                                style: GoogleFonts.openSans(fontSize: 13, color: titleColor, fontWeight: FontWeight.w500),
                                                                              ),
                                                                              const Padding(
                                                                                padding: EdgeInsets.only(left: 4.0),
                                                                                child: Icon(
                                                                                  Icons.star,
                                                                                  size: 15,
                                                                                  color: Colors.amber,
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 5.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.7,
                                                                          // height: 80,
                                                                          child: Text(
                                                                              reviewData.reviewData![index].review!,
                                                                              // maxLines: 10,
                                                                              style: GoogleFonts.openSans(fontSize: 13, color: descColor, fontWeight: FontWeight.w500)),
                                                                        ),
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
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            color: Colors
                                                                .grey.shade300,
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
                      const SizedBox(
                        height: 80,
                      )
                    ]);
                  }),
                ),
          bottomNavigationBar: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : isUserLogin == false
                  ? GestureDetector(
                      onTap: () async {
                        Fluttertoast.showToast(
                            msg: "Masuk ke akun anda sebelum membeli tiket",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: primaryColor.withOpacity(0.5),
                            textColor: Colors.white,
                            fontSize: 16.0);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginUser(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18, bottom: 10, top: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: secondaryColor,
                          ),
                          child: const Center(
                              child: Text("Pilih Tiket",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600))),
                        ),
                      ),
                    )
                  : anyTicketData == true
                      ? GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListTicketDestination(
                                  id: widget.id,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, right: 18, bottom: 10, top: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: secondaryColor,
                              ),
                              child: const Center(
                                  child: Text("Pilih Tiket",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600))),
                            ),
                          ),
                        )
                      : const SizedBox()),
    );
  }
}
