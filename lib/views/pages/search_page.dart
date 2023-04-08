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
  String queries='';
  bool isLoading = false;
  final TextEditingController queryController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Widget resultData() {
    return Consumer<DestinasiController>(builder: (context, searchCon, child) {
      // ignore: unrelated_type_equality_checks
      if (searchCon.destinasiQueryData == Data.loading){
        print("b");
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (searchCon.destinasiQueryData!.isNotEmpty) {
        print("a");
        return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            itemCount: searchCon.destinasiQueryData?.length,
            itemBuilder: (context, index) {
              // print("--------- ${queries!.isEmpty}");
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
      } else if(searchCon.destinasiQueryData!.isEmpty){
        return Text("Data tidak ditemukan");
      }
      
      else {
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

    Future.delayed(const Duration(seconds: 2)).then((value) async {
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
                        const SizedBox(
                          // flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 15.0),
                            child: SearchAppBar(),
                          ),
                        ),
                        queries.isEmpty == false
                            ? const Text("oy")
                            : 
                            Expanded(
                              // flex: 2,
                              child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 0.5,
                                  child: SingleChildScrollView(
                                    child: resultData(),

                                    // child: ListView.builder(
                                    //     shrinkWrap: true,
                                    //     scrollDirection: Axis.vertical,
                                    //     controller: _scrollController,
                                    //     itemCount:
                                    //         searchCon.destinasiQueryData?.length,
                                    //     itemBuilder: (context, index) {
                                    //       // print("--------- ${queries!.isEmpty}");
                                    //       return Padding(
                                    //         padding: const EdgeInsets.only(
                                    //             left: 8.0, right: 16, bottom: 7),
                                    //         child: Card(
                                    //           shape: RoundedRectangleBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(9)),
                                    //           elevation: 3.0,
                                    //           shadowColor: const Color.fromARGB(
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
                                    //                                   const Icon(
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
                                    //     }),
                                  ),
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
