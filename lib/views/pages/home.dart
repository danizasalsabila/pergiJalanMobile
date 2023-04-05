import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/controllers/destinasi_controller.dart';
import 'package:pergijalan_mobile/views/pages/list_category.dart';
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

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO HOMEPAGE-----------");
    final homeCon = Provider.of<DestinasiController>(context, listen: false);
    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      await homeCon.allDestinasi();
      await homeCon.setTenData();

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
              : 
        SingleChildScrollView(
          child: Consumer<DestinasiController>(
                  builder: (context, homeCon, child) {
                  return SafeArea(
                      child: Container(
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
                              Container(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0, top: 20, bottom: 8),
                                          child: Text(
                                            "Jelajahi keindahan Indonesia dengan minatmu!",
                                            style: GoogleFonts.mitr(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )),
                                    Container(
                                      // width: MediaQuery.of(context).size.width * 0.3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, bottom: 8, right: 16),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.grey.shade600,
                                            size: 20,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    172, 255, 255, 255),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 210,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: Container(
                                    height: 210,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 8.0, bottom: 3),
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
                        padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
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
                                                            q: "cagar alam")));
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
                                                        const ListByCategory(
                                                            q: "budaya")));
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
                                                            q: "taman hiburan")));
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
                                                        const ListByCategory(
                                                            q: "bahari")));
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
                                                            q: "tempat ibadah")));
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
                            left: 16, top: 8.0, bottom: 3, right: 16),
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
                            CircleAvatar(
                              radius: 13,
                              backgroundColor:
                                  const Color.fromARGB(172, 255, 255, 255),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              // scrollDirection: Axis.vertical,
                              controller: _scrollController,
                              itemCount:
                                  homeCon.destinasiDataSortIntoTen?.length,
                              itemBuilder: (context, index) {
                                // var destinasi = homeCon.destinasiDataSortIntoTen![index];
                                return Padding(
                                  padding: const EdgeInsets.only(left:16.0, right: 16),
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
                                                  DetailDestination(id:homeCon.destinasiDataSortIntoTen![index] ,)))),
                                      child: Container(
                                        height: 100,
                                        padding:
                                            EdgeInsets.only(left: 10, right: 10),
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 70,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        homeCon
                                                            .destinasiData![index]
                                                            .nameDestinasi!,
                                                        style: GoogleFonts
                                                            .notoSansDisplay(
                                                                fontSize: 13,
                                                                color:
                                                                    secondaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
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
                                                              color: titleColor,
                                                            ),
                                                            Text(
                                                              homeCon
                                                                  .destinasiDataSortIntoTen![
                                                                      index]
                                                                  .city!,
                                                              style: GoogleFonts
                                                                  .notoSansDisplay(
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
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              5.0,
                                                                          right:
                                                                              5.0),
                                                                  child: Text(
                                                                    homeCon
                                                                        .destinasiDataSortIntoTen![
                                                                            index]
                                                                        .hobby!,
                                                                    style: GoogleFonts.notoSansDisplay(
                                                                        fontSize:
                                                                            9,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
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
                                                                    left: 5.0),
                                                            child: Container(
                                                                height: 17,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                8),
                                                                    color:
                                                                        labelColor),
                                                                child: Center(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left: 5.0,
                                                                        right:
                                                                            5.0),
                                                                    child: Text(
                                                                      homeCon
                                                                          .destinasiDataSortIntoTen![
                                                                              index]
                                                                          .category!,
                                                                      style: GoogleFonts.notoSansDisplay(
                                                                          fontSize:
                                                                              9,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                )),
                                                          )
                                                        ],
                                                      )
                                                    ]),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.065,
                                                        child: Icon(
                                                            Icons
                                                                .compare_arrows_rounded,
                                                            color: descColor,
                                                            size: 19),
                                                      ),
                                                      Text(
                                                        "Jarak",
                                                        style: GoogleFonts
                                                            .notoSansDisplay(
                                                                fontSize: 11,
                                                                color: descColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ]),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              
                    SizedBox(height: 20,)
                    ]
                    
                    ),
                  ));
                }),
        ));
  }
}
