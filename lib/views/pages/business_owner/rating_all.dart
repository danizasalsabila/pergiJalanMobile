import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:provider/provider.dart';

import '../../../controllers/owner_business_controller.dart';
import '../../../controllers/review_controller.dart';

class AllRatingReviewPage extends StatefulWidget {
  const AllRatingReviewPage({super.key});

  @override
  State<AllRatingReviewPage> createState() => _AllRatingReviewPageState();
}

class _AllRatingReviewPageState extends State<AllRatingReviewPage> {
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO ALL RATING ADMIN-----------");

    final ownerCon =
        Provider.of<OwnerBusinessController>(context, listen: false);
    final reviewData = Provider.of<ReviewController>(context, listen: false);

    isLoading = true;

    Future.delayed(const Duration(seconds: 2)).then((value) async {
      try {
        await reviewData.getRatingAverageByOwner(ownerCon.idOBLogin);
        await reviewData.reviewIdOwner(ownerCon.idOBLogin);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            color: const Color.fromARGB(255, 31, 31, 31),
          ),
        ),
        title: Text(
          "Penilaian Wisatawan",
          style: GoogleFonts.openSans(
              fontSize: 15,
              color: const Color.fromARGB(255, 31, 31, 31),
              fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SingleChildScrollView(
              child: Consumer<ReviewController>(
                  builder: (context, reviewCon, child) {
                return Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: reviewCon.reviewDataByOwner != null
                      ? Column(children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 211, 211, 211)
                                      .withOpacity(0.7),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      2, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 18, 8, 18),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    reviewCon.avgRatingOwner!
                                                        .toStringAsFixed(1),
                                                    style: GoogleFonts.kanit(
                                                        fontSize: 40,
                                                        color: Color.fromARGB(
                                                            255, 32, 32, 32),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  RatingBarIndicator(
                                                    rating: reviewCon
                                                        .avgRatingOwner!,
                                                    itemBuilder:
                                                        (context, ndex) =>
                                                            const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    itemCount: 5,
                                                    itemSize: 15.0,
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    "${reviewCon.reviewDataByOwner!.length.toString()} Ulasan",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 12,
                                                        color: captColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ]),
                                          ),
                                          Container(
                                              width: 1,
                                              // height: ,
                                              height: 80,
                                              color: Color.fromARGB(
                                                  255, 218, 218, 218)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                  "Bintang 5",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: captColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                height: 5,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    FractionallySizedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      // heightFactor: 10,
                                                      widthFactor: reviewCon
                                                              .ratefive! /
                                                          reviewCon
                                                              .reviewDataByOwner!
                                                              .length,
                                                      child: Container(
                                                        height: 5,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.amber,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  reviewCon.ratefive!
                                                      .toString(),
                                                  style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: Color.fromARGB(
                                                          255, 46, 46, 46),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                  "Bintang 4",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: captColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                height: 5,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    FractionallySizedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      // heightFactor: 10,
                                                      widthFactor: reviewCon
                                                              .ratefour! /
                                                          reviewCon
                                                              .reviewDataByOwner!
                                                              .length,
                                                      child: Container(
                                                        height: 5,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.amber,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  reviewCon.ratefour!
                                                      .toString(),
                                                  style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: Color.fromARGB(
                                                          255, 46, 46, 46),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                  "Bintang 3",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: captColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                height: 5,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    FractionallySizedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      // heightFactor: 10,
                                                      widthFactor: reviewCon
                                                              .ratethree! /
                                                          reviewCon
                                                              .reviewDataByOwner!
                                                              .length,
                                                      child: Container(
                                                        height: 5,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.amber,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  reviewCon.ratethree!
                                                      .toString(),
                                                  style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: Color.fromARGB(
                                                          255, 46, 46, 46),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                  "Bintang 2",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: captColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                height: 5,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    FractionallySizedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      // heightFactor: 10,
                                                      widthFactor: reviewCon
                                                              .ratetwo! /
                                                          reviewCon
                                                              .reviewDataByOwner!
                                                              .length,
                                                      child: Container(
                                                        height: 5,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.amber,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  reviewCon.ratetwo!.toString(),
                                                  style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: Color.fromARGB(
                                                          255, 46, 46, 46),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                  "Bintang 1",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: captColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                height: 5,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    FractionallySizedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      // heightFactor: 10,
                                                      widthFactor: reviewCon
                                                              .rateone! /
                                                          reviewCon
                                                              .reviewDataByOwner!
                                                              .length,
                                                      child: Container(
                                                        height: 5,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.amber,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  reviewCon.rateone!.toString(),
                                                  style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: Color.fromARGB(
                                                          255, 46, 46, 46),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          )
                                        ]),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Urutan berdasarkan yang terbaru",
                                style: GoogleFonts.notoSansDisplay(
                                    fontSize: 12,
                                    color: descColor,
                                    fontWeight: FontWeight.w500),
                              )),
                          const Divider(
                            thickness: 1,
                            color: descColor,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            // padding: const EdgeInsets.only(left: 26, right: 26),
                            // width: MediaQuery.of(context).size.width,
                            // height: 800,
                            // decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     border: Border.all(
                            //         color: Colors.grey.shade300, width: 1.5),
                            //     borderRadius: BorderRadius.circular(10)),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              // physics: const ClampingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              controller: _scrollController,
                              itemCount: reviewCon.reviewDataByOwner?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: SizedBox(
                                    // height: 30,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.135,
                                                child: const Align(
                                                  alignment: Alignment.topLeft,
                                                  child: CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 230, 230, 230),
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .solidUser,
                                                      size: 12,
                                                      color: secondaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          reviewCon
                                                              .reviewDataByOwner![
                                                                  index]
                                                              .user!
                                                              .name
                                                              .toString(),
                                                          style: GoogleFonts.openSans(
                                                              fontSize: 13,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  31,
                                                                  31,
                                                                  31),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          reviewCon
                                                              .reviewDataByOwner![
                                                                  index]
                                                              .createdAt!
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  fontSize: 10,
                                                                  color:
                                                                      captColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 8),
                                                          child:
                                                              RatingBarIndicator(
                                                            rating: reviewCon
                                                                .reviewDataByOwner![
                                                                    index]
                                                                .rating!
                                                                .toDouble(),
                                                            itemBuilder:
                                                                (context,
                                                                        ndex) =>
                                                                    const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 15.0,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          reviewCon
                                                              .reviewDataByOwner![
                                                                  index]
                                                              .review
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  fontSize: 12,
                                                                  color:
                                                                      descColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Color.fromARGB(
                                                    255, 228, 228, 228),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 12.0, 18, 12),
                                                child: Text(
                                                  reviewCon
                                                      .reviewDataByOwner![index]
                                                      .destinasi!
                                                      .nameDestinasi
                                                      .toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 12,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 31, 31, 31),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              )),
                                          Divider(
                                            thickness: 1,
                                            color: Colors.grey.shade300,
                                          ),
                                        ]),
                                    // color: Colors.blue,
                                  ),
                                );
                              },
                            ),

                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ])
                      : SizedBox(
                          height: 200,
                          child: Center(
                            child: Text(
                              "Belum terdapat penilaian",
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  color: captColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                );
              }),
            ),
    );
  }
}
