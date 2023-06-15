import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/controllers/destinasi_controller.dart';
import 'package:pergijalan_mobile/views/pages/home_all_destinasidata.dart';
import 'package:pergijalan_mobile/views/pages/home_list_category.dart';
import 'package:pergijalan_mobile/views/pages/detail_touristdestinasion.dart';
import 'package:provider/provider.dart';

import '../../config/theme_color.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int _index = 0;

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
    print("-------------DIRECT TO HOMEPAGE-----------");
    final homeCon = Provider.of<DestinasiController>(context, listen: false);
    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        await homeCon.allDestinasi();
        await homeCon.setRandomDestinasi();
        await homeCon.setTenData();
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
                    Stack(
                      children: [
                        Container(
                            height: 310,
                            color: Colors.white,
                            child: Container(
                              decoration: const BoxDecoration(
                                // color: primaFryColor,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    secondaryColor,
                                    backgroundColor,
                                  ],
                                ),
                              ),
                            )),
                        Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: Container(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      "PergiJalan",
                                      style: GoogleFonts.oleoScript(
                                          fontSize: 23,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 75,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.8,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, top: 20, bottom: 8),
                                      child: Text(
                                        "Jelajahi keindahan Indonesia dengan minatmu!",
                                        style: GoogleFonts.notoSansDisplay(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                              ),
                            ),
                            Container(
                              height: 220,
                              child: Container(
                                height: 220,
                                width: MediaQuery.of(context).size.width,
                                // color: Colors.white,
                                child: PageView.builder(
                                  itemCount: homeCon.destinasiRandom?.length,
                                  controller:
                                      PageController(viewportFraction: 0.85),
                                  onPageChanged: (int index) => setState(() {
                                    _index = index;
                                  }),
                                  itemBuilder: (context, index) {
                                    return Transform.scale(
                                      scale: index == _index ? 1 : 0.92,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 220,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.asset(
                                                    "assets/images/slicing.jpg",
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                            //buat transparant
                                            Container(
                                                height: 220,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: const Color.fromARGB(
                                                        57, 33, 149, 243))),
                                            SizedBox(
                                                height: 220,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 158,
                                                    ),
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          height: 54,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          151,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.5,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10,
                                                                        5.0,
                                                                        10,
                                                                        0),
                                                                child: Text(
                                                                  homeCon
                                                                      .destinasiRandom![
                                                                          index]
                                                                      .nameDestinasi
                                                                      .toString(),
                                                                  style: GoogleFonts.notoSansDisplay(
                                                                      fontSize:
                                                                          15,
                                                                      color:
                                                                          primaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      10,
                                                                      0,
                                                                      10,
                                                                      5),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .location_on_outlined,
                                                                        size:
                                                                            15,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 3.0),
                                                                        child:
                                                                            Text(
                                                                          homeCon
                                                                              .destinasiRandom![index]
                                                                              .city
                                                                              .toString(),
                                                                          style: GoogleFonts.notoSansDisplay(
                                                                              fontSize: 10,
                                                                              color: Colors.grey.shade600,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Text(
                                                                        // ignore: prefer_if_null_operators, unnecessary_null_comparison
                                                                        homeCon.destinasiRandom![index].hobby.toString() !=
                                                                                null
                                                                            ? homeCon.destinasiRandom![index].hobby.toString()
                                                                            : "Lainnya",
                                                                        style: GoogleFonts.notoSansDisplay(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Colors.grey.shade600,
                                                                            fontWeight: FontWeight.w400),
                                                                      ),
                                                                      const Padding(
                                                                        padding:
                                                                             EdgeInsets.only(left: 3.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .location_pin,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: createDotMap<Widget>(
                                    homeCon.destinasiRandom!,
                                    // listHeaderBanner2,
                                    (index, image) {
                                      return Container(
                                        alignment: Alignment.centerLeft,
                                        height: 6,
                                        width: 6,
                                        margin: const EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _index == index
                                                ? primaryColor
                                                : secondaryColor),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 8.0, bottom: 3),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Kategori Wisata",
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              color: primaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 3),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Temukan tempat wisata berdasarkan kategori pilihanmu",
                          style: GoogleFonts.notoSansDisplay(
                              fontSize: 11,
                              color: descColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),

                    //SERVICE BAR
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 90,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ListByCategory(
                                                q: "Cagar Alam")));
                              },
                              child: SizedBox(
                                height: 80,
                                width: MediaQuery.of(context).size.width * 0.18,
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 33,
                                          child: Image.asset(
                                            "assets/servicebar/cagaralam.png",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          child: Text(
                                            "Cagar\nAlam",
                                            style: GoogleFonts.inter(
                                                fontSize: 9,
                                                color: descColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ListByCategory(q: "Budaya")));
                              },
                              child: SizedBox(
                                height: 80,
                                width: MediaQuery.of(context).size.width * 0.18,
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 33,
                                          child: Image.asset(
                                            "assets/servicebar/budaya.png",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          child: Text(
                                            "Budaya",
                                            style: GoogleFonts.inter(
                                                fontSize: 9,
                                                color: descColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ListByCategory(
                                                q: "Taman Hiburan")));
                              },
                              child: SizedBox(
                                height: 80,
                                width: MediaQuery.of(context).size.width * 0.18,
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 33,
                                          child: Image.asset(
                                            "assets/servicebar/tamanhiburan.png",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          child: Text(
                                            "Taman\nHiburan",
                                            style: GoogleFonts.inter(
                                                fontSize: 9,
                                                color: descColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ListByCategory(q: "Bahari")));
                              },
                              child: SizedBox(
                                height: 80,
                                width: MediaQuery.of(context).size.width * 0.18,
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 33,
                                          child: Image.asset(
                                            "assets/servicebar/bahari.png",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          child: Text(
                                            "Bahari",
                                            style: GoogleFonts.inter(
                                                fontSize: 9,
                                                color: descColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ListByCategory(
                                                q: "Tempat Ibadah")));
                              },
                              child: SizedBox(
                                height: 80,
                                width: MediaQuery.of(context).size.width * 0.18,
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 33,
                                          child: Image.asset(
                                            "assets/servicebar/tempatibadah.png",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          child: Text(
                                            "Tempat\nIbadah",
                                            style: GoogleFonts.inter(
                                                fontSize: 9,
                                                color: descColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 8.0, bottom: 0, right: 26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Wisata Terbaru",
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                            Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AllDestinasiPage())) ; 
                            },
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "Lihat Semua",
                                  style: GoogleFonts.inter(
                                      fontSize: 9,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView.builder(
                                shrinkWrap: true,
                                controller: _scrollController,
                                itemCount:
                                    homeCon.destinasiDataSortIntoTen?.length,
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
                                                              .destinasiDataSortIntoTen![
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
                                                                      .destinasiDataSortIntoTen![
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
                                                                      child: homeCon.destinasiDataSortIntoTen![index].hobby !=
                                                                              null
                                                                          ? Text(
                                                                              homeCon.destinasiDataSortIntoTen![index].hobby!.toString(),
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
                                                                              .destinasiDataSortIntoTen![index]
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
              ));
  }
}
