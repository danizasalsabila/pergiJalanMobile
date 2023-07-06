import 'package:cached_network_image/cached_network_image.dart';
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
          : SafeArea(
            child: SingleChildScrollView(
              child: Consumer<DestinasiController>(
                        builder: (context, homeCon, child) {
                      return SizedBox(
                          child: Column(children: [
                            const SizedBox(height: 20,),
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
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: Container(
                                                        height: 70,
                                                        width: MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                        child: homeCon.destinasiData![
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
                                                                Center(child: new CircularProgressIndicator( )),
                                                            imageUrl:
                                                                 homeCon.destinasiData![
                                                                    index]
                                                                .destinationPicture!,
                                                                      fit: BoxFit.cover,
                                                            errorWidget: (context,
                                                                    url, error) =>
                                                                Image.asset(
                                                            "assets/images/error_image.jpeg",
                                                            fit: BoxFit.fitWidth,
                                                          ),
                                                          ),
                                                      ),
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
                                                                        fontSize: 14,
                                                                        color:
                                                                            primaryColor,
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
                                                                      size: 14,
                                                                      color:
                                                                          descColor,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left: 2.0),
                                                                      child: Text(
                                                                        homeCon
                                                                            .destinasiData![
                                                                                index]
                                                                            .city!.toUpperCase(),
                                                                        style: GoogleFonts.notoSansDisplay(
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
                                                                              right:
                                                                                  5.0, 
                                                                              top: 2,
                                                                              bottom: 2,),
                                                                          child: homeCon.destinasiData![index].hobby !=
                                                                                  null
                                                                              ? Text(
                                                                                  homeCon.destinasiData![index].hobby!.toString(),
                                                                                  style: GoogleFonts.notoSansDisplay(
                                                                                      fontSize: 11,
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.w400),
                                                                                  overflow:
                                                                                      TextOverflow.ellipsis,
                                                                                )
                                                                              :  Text(
                                                                                  "Lainnya",  style: GoogleFonts.notoSansDisplay(
                                                                                      fontSize: 11,
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.w400),),
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
                                                                                    5),
                                                                            color:
                                                                                labelColor),
                                                                        child: Center(
                                                                          child:
                                                                              Padding(
                                                                            padding: const EdgeInsets
                                                                                    .only(
                                                                                left:
                                                                                    5.0,
                                                                                    
                                                                              top: 2,
                                                                              bottom: 2,
                                                                                right:
                                                                                    5.0),
                                                                            child:
                                                                                Text(
                                                                              homeCon
                                                                                  .destinasiData![index]
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
            ),
          ) ,
    );
  }
}