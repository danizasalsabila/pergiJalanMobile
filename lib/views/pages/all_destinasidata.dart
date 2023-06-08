import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/views/pages/detail_touristdestinasion.dart';
import 'package:provider/provider.dart';

import '../../controllers/destinasi_controller.dart';

class AllDestinasiPage extends StatefulWidget {
  const AllDestinasiPage({super.key});

  @override
  State<AllDestinasiPage> createState() => _AllDestinasiPageState();
}

class _AllDestinasiPageState extends State<AllDestinasiPage> {
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();


    @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO LIST ALL DESTINASI -----------");
    final allData = Provider.of<DestinasiController>(context, listen: false);
    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
          await allData.allDestinasi();

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
    return Scaffold(
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
                    return SizedBox(
                        child: Column(children: [
                      MediaQuery.removePadding(
                              removeTop: true,
                              context: context,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount:
                                      homeCon.destinasiData?.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, right: 16),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        elevation: 2.0,
                                        shadowColor: const Color.fromARGB(
                                            255, 196, 196, 196),
                                        color: Color.fromARGB(255, 250, 250, 250),
                                        child: InkWell(
                                          onTap: (() => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailDestination(
                                                        id: homeCon
                                                                .destinasiData![
                                                            index],
                                                      )))),
                                          child: Container(
                                            height: 100,
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            width:
                                                MediaQuery.of(context).size.width,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment
                                                //         .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 70,
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.25,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8),
                                                        child: Image.asset(
                                                          "assets/images/slicing.jpg",
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 12.0),
                                                    child: Container(
                                                      width: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.4,
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
                                                                  .destinasiData![
                                                                      index]
                                                                  .nameDestinasi!,
                                                              style: GoogleFonts
                                                                  .notoSansDisplay(
                                                                      fontSize: 13,
                                                                      color:
                                                                          secondaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
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
                                                                    size: 15,
                                                                    color:
                                                                        titleColor,
                                                                  ),
                                                                  Text(
                                                                    homeCon
                                                                        .destinasiData![
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
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                    height: 17,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                    8),
                                                                        color:
                                                                            thirdColor),
                                                                    child: Center(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                                .only(
                                                                            left:
                                                                                5.0,
                                                                            right:
                                                                                5.0),
                                                                        child: homeCon.destinasiData![index].hobby !=
                                                                                null
                                                                            ? Text(
                                                                                homeCon.destinasiData![index].hobby!.toString(),
                                                                                style: GoogleFonts.notoSansDisplay(
                                                                                    fontSize: 9,
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.w500),
                                                                                overflow:
                                                                                    TextOverflow.ellipsis,
                                                                              )
                                                                            :  Text(
                                                                                "Lainnya",  style: GoogleFonts.notoSansDisplay(
                                                                                    fontSize: 9,
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.w500),),
                                                                      ),
                                                                    )),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              5.0),
                                                                  child: Container(
                                                                      height: 17,
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
                                                                              right:
                                                                                  5.0),
                                                                          child:
                                                                              Text(
                                                                            homeCon
                                                                                .destinasiData![index]
                                                                                .category!,
                                                                            style: GoogleFonts.notoSansDisplay(
                                                                                fontSize:
                                                                                    9,
                                                                                color:
                                                                                    Colors.black,
                                                                                fontWeight: FontWeight.w500),
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
                                                  //           CrossAxisAlignment
                                                  //               .end,
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

                      SizedBox(
                        height: 20,
                      )
                    ]));
                  }),
          ) ,
    );
  }
}