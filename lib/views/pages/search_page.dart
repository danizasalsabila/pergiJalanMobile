import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/views/pages/detail_touristdestinasion.dart';
import 'package:pergijalan_mobile/views/widgets/bar_searchfloating.dart';
import 'package:provider/provider.dart';

import '../../controllers/destinasi_controller.dart';

enum Data { loading, noData, hasData, error }

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String queries = '';
  bool isLoading = false;
  final TextEditingController queryController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Widget resultData() {
    return Consumer<DestinasiController>(builder: (context, searchCon, child) {
      if (searchCon.destinasiQueryData == Data.loading) {
        print("b");

        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (searchCon.destinasiQueryData == Data.hasData) {
        print("a");
        return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            itemCount: searchCon.destinasiQueryData?.length,
            itemBuilder: (context, index) {
              print("--------- ${queries.isEmpty}");
              // var destinasi = searchCon.destinasiQueryData![index];
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 16, bottom: 7),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                  elevation: 3.0,
                  shadowColor: Color.fromARGB(255, 196, 196, 196),
                  color: Colors.white,
                  child: InkWell(
                    onTap: (() => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailDestination(
                                id: searchCon.destinasiQueryData![index])))),
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      searchCon.destinasiQueryData![index]
                                          .nameDestinasi!,
                                      style: GoogleFonts.notoSansDisplay(
                                          fontSize: 13,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2.0, bottom: 2.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 15,
                                            color: titleColor,
                                          ),
                                          Text(
                                            searchCon.destinasiQueryData![index]
                                                .city!,
                                            style: GoogleFonts.notoSansDisplay(
                                                fontSize: 11,
                                                color: descColor,
                                                fontWeight: FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 17,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: thirdColor),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                child: Text(
                                                  searchCon
                                                      .destinasiQueryData![
                                                          index]
                                                      .hobby!,
                                                  style: GoogleFonts
                                                      .notoSansDisplay(
                                                          fontSize: 9,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Container(
                                              height: 17,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: labelColor),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0,
                                                          right: 5.0),
                                                  child: Text(
                                                    searchCon
                                                        .destinasiQueryData![
                                                            index]
                                                        .category!,
                                                    style: GoogleFonts
                                                        .notoSansDisplay(
                                                            fontSize: 9,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.065,
                                      child: Icon(Icons.compare_arrows_rounded,
                                          color: descColor, size: 19),
                                    ),
                                    Text(
                                      "Jarak",
                                      style: GoogleFonts.notoSansDisplay(
                                          fontSize: 11,
                                          color: descColor,
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ]),
                            )
                          ]),
                    ),
                  ),
                ),
              );
            });
      } else {
        return SizedBox();
      }
    });
  }

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO SEARCH PAGE-----------");
    final listCat = Provider.of<DestinasiController>(context, listen: false);
    isLoading = true;

    Future.delayed(Duration(seconds: 2)).then((value) async {
      try {
        // await listCat.searchDestinasi(q);
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : Consumer<DestinasiController>(
                  builder: (context, searchCon, child) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Expanded(
                              // flex: 1,
                              child: SearchAppBar(),
                            ),
                            Text("abkkdk"),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(left: 16.0, right: 16.0),
                      //   child: Text(
                      //     "Inspirasi Wisata Terbaik",
                      //     style: GoogleFonts.kanit(
                      //         fontSize: 24,
                      //         color: primaryColor,
                      //         fontWeight: FontWeight.w700),
                      //   ),
                      // ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(left: 16.0, right: 16.0),
                      //   child: Text(
                      //     "Temukan destinasi impianmu berdasarkan\nnama, kota dan kategori wisata",
                      //     style: GoogleFonts.openSans(
                      //         fontSize: 13,
                      //         color: descColor,
                      //         fontWeight: FontWeight.w600),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(left: 16.0, right: 16.0),
                      //   child: TextField(
                      //     onChanged: (String query) {
                      //       debugPrint('data: $query');
                      //       if (query.isNotEmpty) {
                      //         queryController.clear();
                      //         setState(() {
                      //           queries = query;
                      //           print(queries);
                      //         });
                      //         searchCon.searchDestinasi(query);
                      //       } else {
                      //         queryController.clear();
                      //       }
                      //     },
                      //     textInputAction: TextInputAction.search,
                      //     decoration: InputDecoration(
                      //         enabledBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(15),
                      //             borderSide: BorderSide(
                      //               color: Colors.grey.shade300,
                      //             )),
                      //         focusedBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(15),
                      //             borderSide: const BorderSide(
                      //                 color: secondaryColor, width: 2)),
                      //         filled: true,
                      //         fillColor: Colors.grey.shade300,
                      //         contentPadding: const EdgeInsets.all(10),
                      //         prefixIcon: const Padding(
                      //           padding:
                      //               EdgeInsets.only(left: 22.0, right: 18),
                      //           child: Icon(
                      //             Icons.search,
                      //             color: Colors.grey,
                      //           ),
                      //         ),
                      //         hintStyle: const TextStyle(
                      //           fontSize: 13,
                      //           color: Colors.grey,
                      //         ),
                      //         hintText: "Cari Tempat Wisata"),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 40,
                      // ),
                      queries.isEmpty
                          ? const SizedBox()
                          : Container(
                            height: MediaQuery.of(context).size.height *0.5,
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  controller: _scrollController,
                                  itemCount:
                                      searchCon.destinasiQueryData?.length,
                                  itemBuilder: (context, index) {
                                    print("--------- ${queries.isEmpty}");
                                    // var destinasi = searchCon.destinasiQueryData![index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 16, bottom: 7),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(9)),
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
                                                          id: searchCon
                                                                  .destinasiQueryData![
                                                              index])))),
                                          child: Container(
                                            height: 100,
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 70,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
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
                                                            searchCon
                                                                .destinasiQueryData![
                                                                    index]
                                                                .nameDestinasi!,
                                                            style: GoogleFonts
                                                                .notoSansDisplay(
                                                                    fontSize:
                                                                        13,
                                                                    color:
                                                                        secondaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 2.0,
                                                                    bottom:
                                                                        2.0),
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
                                                                  searchCon
                                                                      .destinasiQueryData![
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
                                                                          BorderRadius.circular(
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
                                                                      child:
                                                                          Text(
                                                                        searchCon
                                                                            .destinasiQueryData![index]
                                                                            .hobby!,
                                                                        style: GoogleFonts.notoSansDisplay(
                                                                            fontSize:
                                                                                9,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.w500),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  )),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child:
                                                                    Container(
                                                                        height:
                                                                            17,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(
                                                                                8),
                                                                            color:
                                                                                labelColor),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 5.0, right: 5.0),
                                                                            child:
                                                                                Text(
                                                                              searchCon.destinasiQueryData![index].category!,
                                                                              style: GoogleFonts.notoSansDisplay(fontSize: 9, color: Colors.black, fontWeight: FontWeight.w500),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        )),
                                                              )
                                                            ],
                                                          )
                                                        ]),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.065,
                                                            child: Icon(
                                                                Icons
                                                                    .compare_arrows_rounded,
                                                                color:
                                                                    descColor,
                                                                size: 19),
                                                          ),
                                                          Text(
                                                            "Jarak",
                                                            style: GoogleFonts
                                                                .notoSansDisplay(
                                                                    fontSize:
                                                                        11,
                                                                    color:
                                                                        descColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ]),
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                      // isLoading
                      //     ? const Center(
                      //         child: CircularProgressIndicator(
                      //           color: Colors.blue,
                      //         ),
                      //       )
                      //     : queries.isNotEmpty
                      // ? ListView.builder(
                      //     shrinkWrap: true,
                      //     scrollDirection: Axis.vertical,
                      //     controller: _scrollController,
                      //     itemCount:
                      //         searchCon.destinasiQueryData?.length,
                      //     itemBuilder: (context, index) {
                      //       print("--------- ${queries.isEmpty}");
                      //       // var destinasi = searchCon.destinasiQueryData![index];
                      //       return Padding(
                      //         padding: const EdgeInsets.only(
                      //             left: 8.0, right: 16, bottom: 7),
                      //         child: Card(
                      //           shape: RoundedRectangleBorder(
                      //               borderRadius:
                      //                   BorderRadius.circular(9)),
                      //           elevation: 3.0,
                      //           shadowColor: Color.fromARGB(
                      //               255, 196, 196, 196),
                      //           color: Colors.white,
                      //           child: InkWell(
                      //             onTap: (() => Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         DetailDestination(
                      //                             id: searchCon
                      //                                     .destinasiQueryData![
                      //                                 index])))),
                      //             child: Container(
                      //               height: 100,
                      //               padding: EdgeInsets.only(
                      //                   left: 10, right: 10),
                      //               width: MediaQuery.of(context)
                      //                   .size
                      //                   .width,
                      //               child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment
                      //                           .spaceBetween,
                      //                   children: [
                      //                     Container(
                      //                       height: 70,
                      //                       width: MediaQuery.of(
                      //                                   context)
                      //                               .size
                      //                               .width *
                      //                           0.25,
                      //                       decoration:
                      //                           BoxDecoration(
                      //                         borderRadius:
                      //                             BorderRadius
                      //                                 .circular(8),
                      //                         color: Colors.blue,
                      //                       ),
                      //                     ),
                      //                     Container(
                      //                       width: MediaQuery.of(
                      //                                   context)
                      //                               .size
                      //                               .width *
                      //                           0.4,
                      //                       child: Column(
                      //                           crossAxisAlignment:
                      //                               CrossAxisAlignment
                      //                                   .start,
                      //                           mainAxisAlignment:
                      //                               MainAxisAlignment
                      //                                   .center,
                      //                           children: [
                      //                             Text(
                      //                               searchCon
                      //                                   .destinasiQueryData![
                      //                                       index]
                      //                                   .nameDestinasi!,
                      //                               style: GoogleFonts.notoSansDisplay(
                      //                                   fontSize:
                      //                                       13,
                      //                                   color:
                      //                                       secondaryColor,
                      //                                   fontWeight:
                      //                                       FontWeight
                      //                                           .w600),
                      //                               overflow:
                      //                                   TextOverflow
                      //                                       .ellipsis,
                      //                             ),
                      //                             Padding(
                      //                               padding:
                      //                                   const EdgeInsets
                      //                                           .only(
                      //                                       top:
                      //                                           2.0,
                      //                                       bottom:
                      //                                           2.0),
                      //                               child: Row(
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment
                      //                                         .start,
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .start,
                      //                                 children: [
                      //                                   Icon(
                      //                                     Icons
                      //                                         .location_on_outlined,
                      //                                     size: 15,
                      //                                     color:
                      //                                         titleColor,
                      //                                   ),
                      //                                   Text(
                      //                                     searchCon
                      //                                         .destinasiQueryData![
                      //                                             index]
                      //                                         .city!,
                      //                                     style: GoogleFonts.notoSansDisplay(
                      //                                         fontSize:
                      //                                             11,
                      //                                         color:
                      //                                             descColor,
                      //                                         fontWeight:
                      //                                             FontWeight.w500),
                      //                                     overflow:
                      //                                         TextOverflow
                      //                                             .ellipsis,
                      //                                   )
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                             Row(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment
                      //                                       .start,
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .start,
                      //                               children: [
                      //                                 Container(
                      //                                     height:
                      //                                         17,
                      //                                     decoration: BoxDecoration(
                      //                                         borderRadius: BorderRadius.circular(
                      //                                             8),
                      //                                         color:
                      //                                             thirdColor),
                      //                                     child:
                      //                                         Center(
                      //                                       child:
                      //                                           Padding(
                      //                                         padding: const EdgeInsets.only(
                      //                                             left: 5.0,
                      //                                             right: 5.0),
                      //                                         child:
                      //                                             Text(
                      //                                           searchCon.destinasiQueryData![index].hobby!,
                      //                                           style: GoogleFonts.notoSansDisplay(
                      //                                               fontSize: 9,
                      //                                               color: Colors.white,
                      //                                               fontWeight: FontWeight.w500),
                      //                                           overflow:
                      //                                               TextOverflow.ellipsis,
                      //                                         ),
                      //                                       ),
                      //                                     )),
                      //                                 Padding(
                      //                                   padding: const EdgeInsets
                      //                                           .only(
                      //                                       left:
                      //                                           5.0),
                      //                                   child: Container(
                      //                                       height: 17,
                      //                                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: labelColor),
                      //                                       child: Center(
                      //                                         child:
                      //                                             Padding(
                      //                                           padding:
                      //                                               const EdgeInsets.only(left: 5.0, right: 5.0),
                      //                                           child:
                      //                                               Text(
                      //                                             searchCon.destinasiQueryData![index].category!,
                      //                                             style: GoogleFonts.notoSansDisplay(fontSize: 9, color: Colors.black, fontWeight: FontWeight.w500),
                      //                                             overflow: TextOverflow.ellipsis,
                      //                                           ),
                      //                                         ),
                      //                                       )),
                      //                                 )
                      //                               ],
                      //                             )
                      //                           ]),
                      //                     ),
                      //                     Container(
                      //                       width: MediaQuery.of(
                      //                                   context)
                      //                               .size
                      //                               .width *
                      //                           0.15,
                      //                       child: Column(
                      //                           mainAxisAlignment:
                      //                               MainAxisAlignment
                      //                                   .center,
                      //                           crossAxisAlignment:
                      //                               CrossAxisAlignment
                      //                                   .end,
                      //                           children: [
                      //                             Container(
                      //                               width: MediaQuery.of(
                      //                                           context)
                      //                                       .size
                      //                                       .width *
                      //                                   0.065,
                      //                               child: Icon(
                      //                                   Icons
                      //                                       .compare_arrows_rounded,
                      //                                   color:
                      //                                       descColor,
                      //                                   size: 19),
                      //                             ),
                      //                             Text(
                      //                               "Jarak",
                      //                               style: GoogleFonts.notoSansDisplay(
                      //                                   fontSize:
                      //                                       11,
                      //                                   color:
                      //                                       descColor,
                      //                                   fontWeight:
                      //                                       FontWeight
                      //                                           .w400),
                      //                               overflow:
                      //                                   TextOverflow
                      //                                       .ellipsis,
                      //                             ),
                      //                           ]),
                      //                     )
                      //                   ]),
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     })
                      // : Center(
                      //   child: SizedBox(
                      //       child: Text("Masukkan kata kunci", style: GoogleFonts.openSans(
                      // fontSize: 13,
                      // color: Colors.grey.shade400,
                      // fontWeight: FontWeight.w600),),
                      //     ),
                      // ),
                    ]);
              })),
    );
  }
}
