// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/views/pages/detail_touristdestinasion.dart';
import 'package:pergijalan_mobile/views/widgets/bar_searchfloating.dart';
import 'package:provider/provider.dart';

import '../../controllers/destinasi_controller.dart';

// enum DestinasiL { loading, noData, hasData, error }

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // String? queries;
  bool isLoading2 = false;
  bool isLoading = false;
  bool isfirst = false;
  final TextEditingController queryController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void initState() {
    print(" ");
    print("-------------DIRECT TO PROFILE-----------");
    final searchCon = Provider.of<DestinasiController>(context, listen: false);
    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        searchCon.destinasiQueryData!.clear();
        isfirst = searchCon.isfirstpage;
        print("ada data ga? $isfirst");
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
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  Widget resultData(BuildContext context) {
    return Consumer<DestinasiController>(builder: (context, searchCon, child) {
      if (searchCon.destinasiQueryData != null &&
          searchCon.destinasiQueryData!.isNotEmpty) {
        print("a");
        searchCon.isfirstpage = false;

        return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            itemCount: searchCon.destinasiQueryData?.length,
            itemBuilder: (context, index) {
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:  BorderRadius.circular(8),
                                
                              child: Container(
                                height: 70,
                                width: MediaQuery.of(context).size.width * 0.25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: searchCon.destinasiQueryData![index]
                                            .destinationPicture ==
                                        null
                                    ? Image.asset(
                                        "assets/images/no_image2.jpg",
                                        fit: BoxFit.cover,
                                      )
                                    : CachedNetworkImage(
                                        placeholder: (context, url) => Center(
                                            child:
                                                new CircularProgressIndicator()),
                                        imageUrl: searchCon
                                            .destinasiQueryData![index]
                                            .destinationPicture!,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          "assets/images/error_image.jpeg",
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        searchCon.destinasiQueryData![index]
                                            .nameDestinasi!,
                                        style: GoogleFonts.notoSansDisplay(
                                            fontSize: 14,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w500),
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
                                                  .city!.toUpperCase(),
                                              style: GoogleFonts.notoSansDisplay(
                                                  fontSize: 11,
                                                  color: descColor,
                                                  fontWeight: FontWeight.w400),
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
                                                      BorderRadius.circular(5),
                                                  color: thirdColor),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 5.0, right: 5.0, 
                                                            bottom: 1,
                                                            top: 1,),
                                                  child: searchCon
                                                              .destinasiQueryData![
                                                                  index]
                                                              .hobby !=
                                                          null
                                                      ? Text(
                                                          searchCon
                                                              .destinasiQueryData![
                                                                  index]
                                                              .hobby!,
                                                          style: GoogleFonts
                                                              .notoSansDisplay(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      : SizedBox(),
                                                ),
                                              )),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5.0),
                                            child: Container(
                                                // height: 17,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                    color: labelColor),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            bottom: 1,
                                                            top: 1,
                                                            right: 5.0),
                                                    child: Text(
                                                      searchCon
                                                          .destinasiQueryData![
                                                              index]
                                                          .category!,
                                                      style: GoogleFonts
                                                          .notoSansDisplay(
                                                              fontSize: 11,
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
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
                            //   width: MediaQuery.of(context).size.width * 0.15,
                            //   child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.end,
                            //       children: [
                            //         Container(
                            //           width: MediaQuery.of(context).size.width *
                            //               0.065,
                            //           child: Icon(Icons.compare_arrows_rounded,
                            //               color: descColor, size: 19),
                            //         ),
                            //         Text(
                            //           "Jarak",
                            //           style: GoogleFonts.notoSansDisplay(
                            //               fontSize: 11,
                            //               color: descColor,
                            //               fontWeight: FontWeight.w400),
                            //           overflow: TextOverflow.ellipsis,
                            //         ),
                            //       ]),
                            // )
                          ]),
                    ),
                  ),
                ),
              );
            });
      } else if (searchCon.destinasiQueryData!.isEmpty &&
          searchCon.statusCodeSearch != 200) {
        searchCon.isfirstpage = true;

        // searchCon.clearData();
        print("b");
        print(searchCon.destinasiQueryData);
        return const SizedBox();
      } else if (searchCon.statusCodeSearch == 404) {
        searchCon.isfirstpage = true;

        print("c");
        return Center(child: Text("404"));
      } else {
        searchCon.isfirstpage = true;

        return const SizedBox();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          body:
              //  isLoading
              //     ? const Center(
              //         child: CircularProgressIndicator(
              //           color: Colors.blue,
              //         ),
              //       )
              //     :
              Consumer<DestinasiController>(
                  builder: (context, searchCon, child) {
            // print("query ${queries}");
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: SearchAppBar(),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 0.5,
                      child: SingleChildScrollView(
                        child: isLoading
                            ? const Padding(
                                padding: EdgeInsets.only(top: 60.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : searchCon.isfirstpage == true &&
                                    searchCon.statusCodeSearch == 200
                                ? resultData(context)
                                : SizedBox(),
                      ),
                    ),
                  )
                ]);
          })),
    );
  }
}
