import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/views/pages/detail_touristdestinasion.dart';
import 'package:pergijalan_mobile/views/pages/login_user.dart';
import 'package:provider/provider.dart';

import '../../../controllers/destinasi_controller.dart';
import 'create_destinationtour.dart';

class HomePageOwner extends StatefulWidget {
  const HomePageOwner({super.key});

  @override
  State<HomePageOwner> createState() => _HomePageOwnerState();
}

class _HomePageOwnerState extends State<HomePageOwner> {
  final ScrollController _scrollController = ScrollController();

  var now = new DateTime.now();

  bool isLoading = false;

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO HOME PAGE ADMIN-----------");
    isLoading = true;

    final ownerBusinessHomeCon =
        Provider.of<DestinasiController>(context, listen: false);
    isLoading = true;

    Future.delayed(Duration(seconds: 2)).then((value) async {
      try {
        await ownerBusinessHomeCon.allDestinasi();
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
    String formattedDate = DateFormat('EEEEE, d MMM yyyy').format(now);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginUser()));
            },
            child: Icon(
              Icons.settings,
              color: Colors.grey.shade400,
            )),
        title: Text(
          'Dashboard',
          style: GoogleFonts.kanit(
              fontSize: 18,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w400),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
            elevation: 5,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateDestinationTourist(),
                ),
              );
            },
            backgroundColor: primaryColor,
            child: const FaIcon(FontAwesomeIcons.plus)
            //  Icon(
            //   Icons.add,
            //   size: 36,
            //   color: Colors.white,
            // ),
            ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SingleChildScrollView(
              child: Consumer<DestinasiController>(
                  builder: (context, homeCon, child) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Laporan Peningkatan",
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, top: 1, bottom: 7),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Usaha Nama Pemilik",
                          style: GoogleFonts.openSans(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 100,
                              child: Stack(children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.people,
                                    size: 90,
                                    color: Colors.grey.shade100,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "Total Rating",
                                        style: GoogleFonts.openSans(
                                            fontSize: 10,
                                            color: descColor,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 29,
                                          color: Colors.amber,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            "4.5",
                                            style: GoogleFonts.kanit(
                                                fontSize: 44,
                                                color: thirdColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 100,
                              child: Stack(children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.stacked_line_chart_rounded,
                                    size: 90,
                                    color: Colors.grey.shade100,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "Tiket Terjual",
                                        style: GoogleFonts.openSans(
                                            fontSize: 10,
                                            color: descColor,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            "120",
                                            style: GoogleFonts.kanit(
                                                fontSize: 44,
                                                color: labelColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ]),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Container(
                        height: 220,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            // color: primaFryColor,
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                // Color.fromARGB(255, 0, 119, 134),
                                Color.fromARGB(255, 17, 93, 139),
                                Color.fromARGB(255, 13, 183, 206),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 15.0, 16, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.37,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color.fromARGB(71, 255, 255, 255)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        "Penjualan Tiket Terbanyak",
                                        style: GoogleFonts.openSans(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "1",
                                  style: GoogleFonts.kanit(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          Text(
                            "Hari Ini",
                            style: GoogleFonts.openSans(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            formattedDate,
                            style: GoogleFonts.openSans(
                                fontSize: 18,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16),
                            child: Container(
                              height: 73,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Center(
                                            child: Text(
                                              "Terjual",
                                              style: GoogleFonts.openSans(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      166, 36, 78, 79),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Center(
                                            child: Text(
                                              "90",
                                              style: GoogleFonts.kanit(
                                                  fontSize: 26,
                                                  color: thirdColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 52,
                                      width: 1,
                                      color: Color.fromARGB(92, 36, 78, 79),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Center(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "Tempat Wisata",
                                              style: GoogleFonts.openSans(
                                                  fontSize: 10,
                                                  color: Color.fromARGB(
                                                      166, 36, 78, 79),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 39,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Center(
                                            child: Text(
                                              "Nama Wisata",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.kanit(
                                                  fontSize: 13,
                                                  color: thirdColor,
                                                  fontWeight: FontWeight.w600),
                                              overflow: TextOverflow.fade,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 52,
                                      width: 1,
                                      color: Color.fromARGB(92, 36, 78, 79),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Center(
                                            child: Text(
                                              "Sisa Tiket",
                                              style: GoogleFonts.openSans(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      166, 36, 78, 79),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          child: Center(
                                            child: Text(
                                              "20",
                                              style: GoogleFonts.kanit(
                                                  fontSize: 26,
                                                  color: thirdColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 8),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Kelola Wisatamu",
                          style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: descColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: homeCon.destinasiData?.length,
                          itemBuilder: (context, index) {
                            return isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    ),
                                  )
                                : Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
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
                                      child: SizedBox(
                                          child: Column(
                                        children: [
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 70,
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.23,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8),
                                                        child: Image.asset(
                                                          "assets/images/slicing.jpg",
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                  Container(
                                                    height: 70,
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.23,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8),
                                                        color: Color.fromARGB(
                                                            106, 75, 150, 111)),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0, right: 8.0),
                                                child: SizedBox(
                                                  height: 70,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.44,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            homeCon
                                                                .destinasiData![
                                                                    index]
                                                                .nameDestinasi
                                                                .toString(),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxLines: 1,
                                                            style: GoogleFonts
                                                                .notoSansDisplay(
                                                                    fontSize: 15,
                                                                    color:
                                                                        thirdColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                          ),
                                                          Row(
                                                            children: [
                                                              FaIcon(
                                                                FontAwesomeIcons
                                                                    .locationDot,
                                                                size: 13,
                                                                color: descColor,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            3.0),
                                                                child: Text(
                                                                  homeCon
                                                                      .destinasiData![
                                                                          index]
                                                                      .city
                                                                      .toString(),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: GoogleFonts.notoSans(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade600,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 2.0,
                                                                    top: 4),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      labelColorBack,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3)),
                                                              height: 19,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.21,
                                                              child: Center(
                                                                  child: Text(
                                                                "Ubah",
                                                                style: GoogleFonts.openSans(
                                                                    fontSize: 9,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )),
                                                            ),
                                                          )
                                                        ]),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: InkWell(
                                                  onTap: () async {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            backgroundColor:
                                                                Colors.white,
                                                            elevation: 5,
                                                            title: Text(
                                                              "Konfirmasi Hapus ${homeCon.destinasiData![index].nameDestinasi.toString()}",
                                                              style: GoogleFonts
                                                                  .notoSansDisplay(
                                                                      fontSize:
                                                                          17,
                                                                      color:
                                                                          thirdColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                            ),
                                                            content: Text(
                                                              "Harap diketahui bahwa menghapus data akan menghapus semua informasi terkait dengan data tersebut",
                                                              style: GoogleFonts
                                                                  .notoSansDisplay(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          titleColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                    "Batal",
                                                                    style: GoogleFonts.openSans(
                                                                        fontSize:
                                                                            14,
                                                                        color:
                                                                            descColor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600),
                                                                  )),
                                                              // child: Text("No")),
                                                              Padding(
                                                                padding: const EdgeInsets.only(right: 10.0),
                                                                child: Container(
                                                                  height: 35,
                                                                  decoration: BoxDecoration(color: thirdColor, borderRadius: BorderRadius.circular(7)),
                                                                  child: TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        isLoading =
                                                                            true;
                                                                        final ownerBusinessHomeCon = Provider.of<
                                                                                DestinasiController>(
                                                                            context,
                                                                            listen:
                                                                                false);
                                                                        try {
                                                                          await ownerBusinessHomeCon.deleteDestinasi(homeCon
                                                                              .destinasiData![
                                                                                  index]
                                                                              .id);

                                                                          if (ownerBusinessHomeCon
                                                                                  .statusCodeDeleteDestinasi ==
                                                                              200) {
                                                                            setState(
                                                                                () {
                                                                              isLoading =
                                                                                  false;
                                                                            });
                                                                            // ignore: use_build_context_synchronously
                                                                            Navigator.pop(context);
                                                                            await ownerBusinessHomeCon
                                                                                .allDestinasi();

                                                                            Fluttertoast.showToast(
                                                                                msg: ownerBusinessHomeCon
                                                                                    .messageDeleteDestinasi
                                                                                    .toString(),
                                                                                toastLength: Toast
                                                                                    .LENGTH_SHORT,
                                                                                gravity: ToastGravity
                                                                                    .BOTTOM,
                                                                                timeInSecForIosWeb:
                                                                                    1,
                                                                                backgroundColor: primaryColor.withOpacity(
                                                                                    0.6),
                                                                                textColor: Colors
                                                                                    .white,
                                                                                fontSize:
                                                                                    16.0);
                                                                          } else if (ownerBusinessHomeCon
                                                                                  .statusCodeDeleteDestinasi ==
                                                                              404) {
                                                                            setState(
                                                                                () {
                                                                              isLoading =
                                                                                  false;
                                                                            });
                                                                            // ignore: use_build_context_synchronously
                                                                            Navigator.pop(context);

                                                                            Fluttertoast.showToast(
                                                                                msg: ownerBusinessHomeCon
                                                                                    .messageDeleteDestinasi
                                                                                    .toString(),
                                                                                toastLength: Toast
                                                                                    .LENGTH_SHORT,
                                                                                gravity: ToastGravity
                                                                                    .BOTTOM,
                                                                                timeInSecForIosWeb:
                                                                                    1,
                                                                                backgroundColor: Colors.red[
                                                                                    300],
                                                                                textColor: Colors
                                                                                    .white,
                                                                                fontSize:
                                                                                    16.0);
                                                                          }
                                                                        } catch (e) {
                                                                          setState(
                                                                              () {
                                                                            isLoading =
                                                                                false;
                                                                          });
                                                                          // ignore: use_build_context_synchronously
                                                                            Navigator.pop(context);
                                                                          Fluttertoast.showToast(
                                                                              msg: e
                                                                                  .toString(),
                                                                              toastLength:
                                                                                  Toast
                                                                                      .LENGTH_SHORT,
                                                                              gravity:
                                                                                  ToastGravity
                                                                                      .BOTTOM,
                                                                              timeInSecForIosWeb:
                                                                                  1,
                                                                              backgroundColor:
                                                                                  Colors.red[
                                                                                      300],
                                                                              textColor:
                                                                                  Colors
                                                                                      .white,
                                                                              fontSize:
                                                                                  16.0);
                                                                        }
                                                                      },
                                                                      child:
                                                                           Text(
                                                                              "Hapus", style: GoogleFonts.openSans(
                                                                        fontSize:
                                                                            12,
                                                                        color:
                                                                            Colors.white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600),)),
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  child: Container(
                                                    height: 22,
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.061,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 209, 39, 27),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  211,
                                                                  211,
                                                                  211)
                                                              .withOpacity(0.7),
                                                          spreadRadius: 1,
                                                          blurRadius: 4,
                                                          offset: const Offset(2,
                                                              2), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Center(
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .solidTrashCan,
                                                        color: Colors.white,
                                                        size: 11,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 15,
                                            ),
                                            child: Container(
                                              height: 1,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.grey.shade100,
                                            ),
                                          )
                                        ],
                                      )),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }),
            ),
    );
  }
}
