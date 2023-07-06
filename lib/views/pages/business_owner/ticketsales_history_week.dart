// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/eticket_controller.dart';
import 'package:pergijalan_mobile/controllers/owner_business_controller.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

class HistoryTicketByWeek extends StatefulWidget {
  const HistoryTicketByWeek({super.key});

  @override
  State<HistoryTicketByWeek> createState() => _HistoryTicketByWeekState();
}

class _HistoryTicketByWeekState extends State<HistoryTicketByWeek> {
  String? selectedWeek;

  bool isLoading = false;
  int touchedIndex = -1;
  DateTime currentDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO SALES HISTORY BY WEEK-----------");
    final eticketCon = Provider.of<ETicketController>(context, listen: false);
    final ownerCon =
        Provider.of<OwnerBusinessController>(context, listen: false);
    isLoading = true;
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      try {
        eticketCon.uniqueDestinationsWeek.clear();
        eticketCon.uniqueNameDestinationsWeek.clear();
        eticketCon.listTicketSoldIdDestinasiWeek.clear();

        print("-------- $currentDate");
        eticketCon.ticketSoldIdDestinasiWeek = 0;

        String currentWeek = DateFormat('yyyy-MM-dd').format(currentDate);
        print("A-------- $currentWeek");

        await eticketCon.allEticketByOwnerInWeek(
            ownerCon.idOBLogin, currentWeek);

        await eticketCon.getHistoryByWeek(currentWeek);
      } catch (e) {
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  getChartDestinasi(selectedWeek) async {
    final eticketCon = Provider.of<ETicketController>(context, listen: false);
    final ownerCon =
        Provider.of<OwnerBusinessController>(context, listen: false);
    isLoading = true;
    try {
      eticketCon.uniqueDestinationsWeek.clear();
      eticketCon.uniqueNameDestinationsWeek.clear();
      eticketCon.listTicketSoldIdDestinasiWeek.clear();

      print("2 $selectedWeek");
      await eticketCon.allEticketByOwnerInWeek(
          ownerCon.idOBLogin, selectedWeek);

      await eticketCon.getHistoryByWeek(selectedWeek);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.grey,
              splashColor: secondaryColor,
              textTheme: TextTheme(
                subtitle1: TextStyle(color: Colors.black),
                button: TextStyle(color: Colors.black),
              ),
              accentColor: Colors.black,
              colorScheme: ColorScheme.light(
                  primary: secondaryColor,
                  primaryVariant: Color.fromARGB(255, 49, 49, 49),
                  secondaryVariant: Color.fromARGB(255, 49, 49, 49),
                  onSecondary: Color.fromARGB(255, 49, 49, 49),
                  onPrimary: Colors.white,
                  surface: Color.fromARGB(255, 49, 49, 49),
                  onSurface: Color.fromARGB(255, 49, 49, 49),
                  secondary: Color.fromARGB(255, 49, 49, 49)),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? Text(""),
          );
        },
        initialDate: selectedDate,
        firstDate: DateTime(2022, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedWeek = DateFormat('yyyy-MM-dd').format(selectedDate);
        print("1 $selectedWeek");

        isLoading = true;
        Future.delayed(const Duration(seconds: 1)).then((value) async {
          try {
            await getChartDestinasi(selectedWeek);
          } catch (e) {
            e;
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        });
      });
    }
  }

  Color getRandomColor(int index) {
    Random random = Random(index);
    return Color.fromARGB(
      255,
      random.nextInt(242),
      random.nextInt(234),
      random.nextInt(211),
    );
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
                child: Consumer<ETicketController>(
                    builder: (context, eticketCon, child) {
                  return Column(children: [
                    Container(
                      height: 550,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40))),
                      child: SizedBox(
                        // height: 600,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(children: [
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        selectedWeek == null
                                            ? SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Text(
                                                  "Laporan Mingguan",
                                                  maxLines: 2,
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 16,
                                                      color: thirdColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            : SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                                child: Text(
                                                  "Laporan $selectedWeek",
                                                  maxLines: 2,
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 16,
                                                      color: thirdColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          selectedWeek == null
                                              ? "Tiket diurutkan berdasarkan 7 hari sebelumnya di minggu ini"
                                              : "Tiket diurutkan berdasarkan 7 hari sebelum $selectedWeek",
                                          style: GoogleFonts.notoSansDisplay(
                                              fontSize: 12,
                                              color: captColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              244, 231, 231, 231)),
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      height: 50,
                                      child: const Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.calendar,
                                            size: 15,
                                            color:
                                                Color.fromARGB(255, 19, 15, 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            eticketCon.eticketDataOwnerByWeek != null
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Container(
                                      height: 56,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 211, 211, 211),
                                            width: 0.7,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "Total Pendapatan",
                                                      style: GoogleFonts
                                                          .notoSansDisplay(
                                                              fontSize: 12,
                                                              color: captColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 2.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        "Rp ${eticketCon.totalIncomeTicketByWeek.toString()}",
                                                        style: GoogleFonts
                                                            .notoSansDisplay(
                                                                fontSize: 13,
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    49,
                                                                    49,
                                                                    49),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                height: 35,
                                                width: 1,
                                                color: const Color.fromARGB(
                                                    255, 218, 218, 218),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        "Total Penjualan",
                                                        style: GoogleFonts
                                                            .notoSansDisplay(
                                                                fontSize: 12,
                                                                color:
                                                                    captColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2.0),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "${eticketCon.eticketDataOwnerByWeek!.length.toString()} Tiket",
                                                          style: GoogleFonts
                                                              .notoSansDisplay(
                                                                  fontSize: 13,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      49,
                                                                      49,
                                                                      49),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    ),
                                  )
                                : eticketCon.eticketDataOwnerByWeek != null
                                    ? Expanded(
                                        flex: 1,
                                        child: AspectRatio(
                                          aspectRatio: 2,
                                          child: PieChart(
                                            PieChartData(
                                              pieTouchData: PieTouchData(
                                                touchCallback:
                                                    (FlTouchEvent event,
                                                        pieTouchResponse) {
                                                  setState(() {
                                                    if (!event
                                                            .isInterestedForInteractions ||
                                                        pieTouchResponse ==
                                                            null ||
                                                        pieTouchResponse
                                                                .touchedSection ==
                                                            null) {
                                                      touchedIndex = -1;
                                                      return;
                                                    }
                                                    touchedIndex =
                                                        pieTouchResponse
                                                            .touchedSection!
                                                            .touchedSectionIndex;
                                                  });
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 0,
                                              centerSpaceRadius: 50,
                                              sections: List.generate(
                                                  eticketCon
                                                      .listTicketSoldIdDestinasiWeek
                                                      .length, (index) {
                                                final isTouched =
                                                    index == touchedIndex;
                                                final fontSize =
                                                    isTouched ? 35.0 : 22.0;
                                                final radius =
                                                    isTouched ? 60.0 : 50.0;
                                                const shadows = [
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2)
                                                ];
                                                Color randomColor =
                                                    getRandomColor(index);
                                                return PieChartSectionData(
                                                  color: randomColor,
                                                  value: double.parse(eticketCon
                                                          .listTicketSoldIdDestinasiWeek[
                                                      index]),
                                                  title: eticketCon
                                                      .listTicketSoldIdDestinasiWeek[
                                                          index]
                                                      .toString(),
                                                  radius: radius,
                                                  titleStyle: GoogleFonts.kanit(
                                                    fontSize: fontSize,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    shadows: shadows,
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height: 220,
                                        child: Center(
                                            child: Lottie.asset(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                "assets/lottie/no_data.json")),
                                      ),
                            eticketCon.eticketDataOwnerByWeek != null
                                ? Center(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Tempat Wisata",
                                            style: GoogleFonts.notoSansDisplay(
                                                fontSize: 11,
                                                color: captColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "Terjual",
                                            style: GoogleFonts.notoSansDisplay(
                                                fontSize: 11,
                                                color: captColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 5,
                            ),
                            eticketCon.eticketDataOwnerByWeek != null
                                ? Container(
                                    color: const Color.fromARGB(
                                        255, 202, 202, 202),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 0.6,
                                  )
                                : SizedBox(),
                            const SizedBox(
                              height: 10,
                            ),
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.topCenter,
                                    child: SizedBox(
                                      height: 90,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          controller: _scrollController,
                                          scrollDirection: Axis.vertical,
                                          itemCount: eticketCon
                                              .uniqueNameDestinationsWeek
                                              .length,
                                          itemBuilder: (context, index) {
                                            Color randomColor =
                                                getRandomColor(index);
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0,
                                                  left: 10,
                                                  bottom: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: randomColor,
                                                        ),
                                                        height: 20,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.55,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 6.0),
                                                          child: Text(
                                                            eticketCon
                                                                .uniqueNameDestinationsWeek
                                                                .toList()[index],
                                                            style: GoogleFonts
                                                                .notoSansDisplay(
                                                                    fontSize:
                                                                        12,
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        64,
                                                                        64,
                                                                        64),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                            maxLines: 3,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Text(
                                                      // ignore: unnecessary_null_comparison
                                                      eticketCon.listTicketSoldIdDestinasiWeek[
                                                                  index] ==
                                                              null
                                                          ? "-"
                                                          : "${eticketCon.listTicketSoldIdDestinasiWeek[index].toString()} Tiket",
                                                      style: GoogleFonts
                                                          .notoSansDisplay(
                                                              fontSize: 12,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  66,
                                                                  66,
                                                                  66),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ),

                                                  // SizedBox(
                                                  //   height: 20,
                                                  // )
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                          ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Penjualan Terbaru",
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                color: thirdColor,
                                fontWeight: FontWeight.w700),
                          ),
                          selectedWeek == null
                              ? Text(
                                  "Minggu Terakhir",
                                  style: GoogleFonts.notoSansDisplay(
                                      fontSize: 10,
                                      color: captColor,
                                      fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  "Minggu $selectedWeek",
                                  style: GoogleFonts.notoSansDisplay(
                                      fontSize: 10,
                                      color: captColor,
                                      fontWeight: FontWeight.w500),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    eticketCon.eticketDataOwnerByWeek != null
                        ? SizedBox(
                            // width: MediaQuery.of(context),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  eticketCon.eticketDataOwnerByWeek!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, bottom: 15),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 85,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                                    255, 198, 198, 198)
                                                .withOpacity(0.7),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: const Offset(2,
                                                2), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: ClipOval(
                                                    child: Image.asset(
                                                        "assets/logo/owner.png"))),
                                            // color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.39,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    eticketCon
                                                        .eticketDataOwnerByWeek![
                                                            index]
                                                        .destinasi!
                                                        .nameDestinasi
                                                        .toString(),
                                                    // "Nama Destinasi",
                                                    style: GoogleFonts
                                                        .notoSansDisplay(
                                                            fontSize: 13,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                81,
                                                                81,
                                                                81),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  Text(
                                                    eticketCon
                                                        .eticketDataOwnerByWeek![
                                                            index]
                                                        .dateVisit
                                                        .toString(),
                                                    // "Nama Destinasi",
                                                    style: GoogleFonts
                                                        .notoSansDisplay(
                                                            fontSize: 10,
                                                            color: captColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ]),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.21,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 0.8,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.19,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          "+ Rp${eticketCon.eticketDataOwnerByWeek![index].price.toString()}",
                                                          maxLines: 2,
                                                          style: GoogleFonts
                                                              .notoSansDisplay(
                                                                  fontSize: 13,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      81,
                                                                      81,
                                                                      81),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                        ),
                                                        Text(
                                                          eticketCon
                                                              .eticketDataOwnerByWeek![
                                                                  index]
                                                              .dateBook
                                                              .toString(),
                                                          overflow:
                                                              TextOverflow.fade,
                                                          maxLines: 2,
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: GoogleFonts
                                                              .notoSansDisplay(
                                                                  fontSize: 8,
                                                                  color:
                                                                      captColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                            // color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : SizedBox(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Text(
                                  "Belum terdapat penjualan",
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.notoSansDisplay(
                                      fontSize: 11,
                                      color: captColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]);
                }),
              ),
            ),
    );
  }
}
