import 'package:cached_network_image/cached_network_image.dart';
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
                            // color: Colors.white,
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
                            const SizedBox(
                              height: 60,
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
                                          fontSize: 24,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Container(
                            //   height: 75,
                            //   child: Align(
                            //     alignment: Alignment.topLeft,
                            //     child: Container(
                            //         width:
                            //             MediaQuery.of(context).size.width * 0.8,
                            //         child: Padding(
                            //           padding: const EdgeInsets.only(
                            //               left: 16.0, top: 20, bottom: 8),
                            //           child: Text(
                            //             "Jelajahi keindahan Indonesia yang kami rekomendasikan untuk kamu!",
                            //             style: GoogleFonts.notoSansDisplay(
                            //                 fontSize: 15,
                            //                 color: Colors.white,
                            //                 fontWeight: FontWeight.w500),
                            //           ),
                            //         )),
                            //   ),
                            // ),
                            Container(
                              height: 220,
                              child: Container(
                                height: 220,
                                width: MediaQuery.of(context).size.width,
                                // color: Colors.white,
                                child: PageView.builder(
                                  itemCount: homeCon.destinasiRandom?.length,
                                  controller:
                                      PageController(viewportFraction: 0.9),
                                  onPageChanged: (int index) => setState(() {
                                    _index = index;
                                  }),
                                  itemBuilder: (context, index) {
                                    return Transform.scale(
                                      scale: index == _index ? 1 : 0.96,
                                      child: InkWell(
                                        onTap: (() => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailDestination(
                                                      id: homeCon.destinasiRandom![
                                                          index],
                                                    )))),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 220,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: homeCon
                                                              .destinasiRandom![
                                                                  index]
                                                              .destinationPicture ==
                                                          null
                                                      ? Image.asset(
                                                          "assets/images/no_image2.jpg",
                                                          fit: BoxFit.cover,
                                                        )
                                                      : CachedNetworkImage(
                                                          imageUrl: homeCon
                                                              .destinasiRandom![
                                                                  index]
                                                              .destinationPicture!,
                                                          fit: BoxFit.cover,
                                                          placeholder: (context,
                                                                  url) =>
                                                              Center(
                                                                  child:
                                                                      new CircularProgressIndicator()),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                            "assets/images/error_image.jpeg",
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              //buat transparant
                                              Container(
                                                  height: 220,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color.fromARGB(
                                                          41, 33, 149, 243))),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Column(
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment.end,
                                                    //     mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: const Color.fromARGB(
                                                                199,
                                                                47,
                                                                125,
                                                                104),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(5)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  12.0, 2, 12, 2),
                                                          child: Text(
                                                            // ignore: prefer_if_null_operators, unnecessary_null_comparison
                                                            homeCon
                                                                        .destinasiRandom![
                                                                            index]
                                                                        .category !=
                                                                    null
                                                                ? homeCon
                                                                    .destinasiRandom![
                                                                        index]
                                                                    .category
                                                                    .toString()
                                                                : "Lainnya",
                                                            style: GoogleFonts
                                                                .notoSansDisplay(
                                                                    fontSize: 12,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                        ),
                                                      ),
                                                      
                                                    ],
                                                  ),
                                                ),
                                              ),
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
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    bottomLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomRight: Radius
                                                                        .circular(
                                                                            10)),
                                                                color: Color
                                                                    .fromARGB(
                                                                        202,
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
                                                                    0.75,
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
                                                                            16,
                                                                        color:
                                                                            primaryColor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
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
                                                                              14,
                                                                          color:
                                                                              descColor,
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
                                                                                fontSize: 12,
                                                                                color: descColor,
                                                                                fontWeight: FontWeight.w500),
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
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
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
                    const SizedBox(
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
                              fontSize: 13,
                              color: descColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),

                    //SERVICE BAR
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 100,
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
                                        SizedBox(
                                          child: Text(
                                            "Cagar\nAlam",
                                            textAlign: TextAlign.center,style: GoogleFonts.inter(
                                                fontSize: 11,
                                                color: descColor,
                                                fontWeight: FontWeight.w400),
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
                                            textAlign: TextAlign.center,style: GoogleFonts.inter(
                                                fontSize: 11,
                                                color: descColor,
                                                fontWeight: FontWeight.w400),
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
                                            textAlign: TextAlign.center,style: GoogleFonts.inter(
                                                fontSize: 11,
                                                color: descColor,
                                                fontWeight: FontWeight.w400),
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
                                            textAlign: TextAlign.center,style: GoogleFonts.inter(
                                                fontSize: 11,
                                                color: descColor,
                                                fontWeight: FontWeight.w400),
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
                                            textAlign: TextAlign.center,style: GoogleFonts.inter(
                                                fontSize: 11,
                                                color: descColor,
                                                fontWeight: FontWeight.w400),
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
                      height: 20,
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllDestinasiPage()));
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Lihat Semua",
                                style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: descColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
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
                                                    child: homeCon
                                                                .destinasiDataSortIntoTen![
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
                                                                .destinasiDataSortIntoTen![
                                                                    index]
                                                                .destinationPicture!,
                                                            fit: BoxFit.cover,
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Image.asset(
                                                              "assets/images/error_image.jpeg",
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0),
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
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
                                                                .destinasiData![
                                                                    index]
                                                                .nameDestinasi!,
                                                            style: GoogleFonts
                                                                .notoSansDisplay(
                                                                    fontSize:
                                                                        14,
                                                                    color:
                                                                       const Color.fromARGB(255, 9, 54, 82),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
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
                                                                      .center,
                                                              children: [
                                                               const  Icon(
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
                                                                        .destinasiDataSortIntoTen![
                                                                            index]
                                                                        .city!.toUpperCase(),
                                                                    style: GoogleFonts.inter(
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
                                                         const SizedBox(height: 2,),
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
                                                                          BorderRadius.circular(
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
                                                                              bottom: 2,
                                                                          right:
                                                                              5.0),
                                                                      child: homeCon.destinasiDataSortIntoTen![index].hobby !=
                                                                              null
                                                                          ? Text(
                                                                              homeCon.destinasiDataSortIntoTen![index].hobby!.toString(),
                                                                              style: GoogleFonts.notoSansDisplay(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w400),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            )
                                                                          : Text(
                                                                              "Lainnya",
                                                                              style: GoogleFonts.notoSansDisplay(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w400),
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
                                                                        // height:
                                                                            // 17,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(
                                                                                5),
                                                                            color:
                                                                                labelColor),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 5.0, right: 5.0, top: 2, bottom: 2),
                                                                            child:
                                                                                Text(
                                                                              homeCon.destinasiDataSortIntoTen![index].category!,
                                                                              style: GoogleFonts.notoSansDisplay(fontSize: 11, color: Colors.black, fontWeight: FontWeight.w400),
                                                                              overflow: TextOverflow.ellipsis,
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
