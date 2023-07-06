import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/destinasi_controller.dart';
import 'package:pergijalan_mobile/views/pages/detail_touristdestinasion.dart';
import 'package:provider/provider.dart';

class ListByCategory extends StatefulWidget {
  final String q;
  const ListByCategory({super.key, required this.q});

  @override
  State<ListByCategory> createState() => _ListByCategoryState();
}

class _ListByCategoryState extends State<ListByCategory> {
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO LIST DATA BY CATEGORY-----------");
    final listCat = Provider.of<DestinasiController>(context, listen: false);
    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        await listCat.destinasiCategory(widget.q);
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
    final listCat = Provider.of<DestinasiController>(context, listen: false);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: primaryColor,
            // size: 24,
          ),
        ),
        elevation: 0,
        toolbarHeight: 68,
        // centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          "Kategori Wisata ${widget.q}",
          style: GoogleFonts.openSans(
              fontSize: 14, color: primaryColor, fontWeight: FontWeight.w700),
        ),

        // title: widget,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Consumer<DestinasiController>(
                    builder: (context, homeCon, child) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Container(
                          child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: homeCon.destinasiCategoryData?.length,
                              itemBuilder: (context, index) {
                                // var destinasi = homeCon.destinasiCategoryData![index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 16, bottom: 7),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(9)),
                                    elevation: 3.0,
                                    shadowColor:
                                        Color.fromARGB(255, 196, 196, 196),
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: (() => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailDestination(
                                                      id: homeCon
                                                              .destinasiCategoryData![
                                                          index])))),
                                      child: Container(
                                        height: 100,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Container(
                                                  height: 70,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  child: homeCon
                                                              .destinasiCategoryData![
                                                                  index]
                                                              .destinationPicture ==
                                                          null
                                                      ? Image.asset(
                                                          "assets/images/no_image2.jpg",
                                                          fit: BoxFit.cover,
                                                        )
                                                      : CachedNetworkImage(
                                                          placeholder: (context,
                                                                  url) =>
                                                              Center(
                                                                  child:
                                                                      new CircularProgressIndicator()),
                                                          imageUrl: homeCon
                                                              .destinasiCategoryData![
                                                                  index]
                                                              .destinationPicture!,
                                                          fit: BoxFit.cover,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                            "assets/images/error_image.jpeg",
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.55,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          homeCon
                                                              .destinasiCategoryData![
                                                                  index]
                                                              .nameDestinasi!,
                                                          style: GoogleFonts
                                                              .notoSansDisplay(
                                                                  fontSize: 14,
                                                                  color:
                                                                      primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 2.0,
                                                                  bottom: 2.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on_outlined,
                                                                size: 14,
                                                                color:
                                                                    descColor,
                                                              ),
                                                              Text(
                                                                homeCon
                                                                    .destinasiCategoryData![
                                                                        index]
                                                                    .city!,
                                                                style: GoogleFonts.notoSansDisplay(
                                                                    fontSize:
                                                                        11,
                                                                    color:
                                                                        descColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 2,),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                // height: 17,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                5),
                                                                    color:
                                                                        thirdColor),
                                                                child: Center(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0,
                                                                        top: 2,
                                                                        bottom:
                                                                            2,
                                                                        right:
                                                                            5.0),
                                                                    child: Text(
                                                                      homeCon
                                                                          .destinasiCategoryData![
                                                                              index]
                                                                          .hobby!,
                                                                      style: GoogleFonts.notoSansDisplay(
                                                                          fontSize:
                                                                              11,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                )),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                              child: Container(
                                                                  // height: 17,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      color:
                                                                          labelColor),
                                                                  child: Center(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              5.0,
                                                                          top:
                                                                              2,
                                                                          bottom:
                                                                              2,
                                                                          right:
                                                                              5.0),
                                                                      child:
                                                                          Text(
                                                                        homeCon
                                                                            .destinasiCategoryData![index]
                                                                            .category!,
                                                                        style: GoogleFonts.notoSansDisplay(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w400),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  )),
                                                            )
                                                          ],
                                                        )
                                                      ]),
                                                ),
                                              ),
                                              // Container(
                                              //   width: MediaQuery.of(context)
                                              //           .size
                                              //           .width *
                                              //       0.15,
                                              //   child: Column(
                                              //       mainAxisAlignment:
                                              //           MainAxisAlignment
                                              //               .center,
                                              //       crossAxisAlignment:
                                              //           CrossAxisAlignment.end,
                                              //       children: [
                                              //         Container(
                                              //           width: MediaQuery.of(
                                              //                       context)
                                              //                   .size
                                              //                   .width *
                                              //               0.065,
                                              //           child: Icon(
                                              //               Icons
                                              //                   .compare_arrows_rounded,
                                              //               color: descColor,
                                              //               size: 19),
                                              //         ),
                                              //         Text(
                                              //           "Jarak",
                                              //           style: GoogleFonts
                                              //               .notoSansDisplay(
                                              //                   fontSize: 11,
                                              //                   color:
                                              //                       descColor,
                                              //                   fontWeight:
                                              //                       FontWeight
                                              //                           .w400),
                                              //           overflow: TextOverflow
                                              //               .ellipsis,
                                              //         ),
                                              //       ]),
                                              // )
                                            ]),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
    );
  }
}
