import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/eticket_controller.dart';
import 'package:pergijalan_mobile/controllers/owner_business_controller.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

class HistoryTicketByYear extends StatefulWidget {
  const HistoryTicketByYear({super.key});

  @override
  State<HistoryTicketByYear> createState() => _HistoryTicketByYearState();
}

class _HistoryTicketByYearState extends State<HistoryTicketByYear> {
  final List<String> dropDownYear = ['2022', '2023', '2024'];
  String? selectedYear;
  bool isLoading = false;
  int touchedIndex = -1;
  String? nameDestinasiChart;
  DateTime currentDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO SALES HISTORY BY YEAR-----------");
    final eticketCon = Provider.of<ETicketController>(context, listen: false);
    final ownerCon =
        Provider.of<OwnerBusinessController>(context, listen: false);
    isLoading = true;
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      try {
        eticketCon.uniqueDestinations.clear();
        eticketCon.uniqueNameDestinations.clear();
        eticketCon.listTicketSoldIdDestinasiYear.clear();

        eticketCon.ticketSoldIdDestinasi = 0;
        String currentYear = currentDate.year.toString();
        await eticketCon.allEticketByOwnerInYear(
            ownerCon.idOBLogin, currentYear);

        await eticketCon.getHistoryByYear(currentYear);
      } catch (e) {
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  getChartDestinasi() async {
    final eticketCon = Provider.of<ETicketController>(context, listen: false);
    final ownerCon =
        Provider.of<OwnerBusinessController>(context, listen: false);
    isLoading = true;
    try {
      eticketCon.uniqueNameDestinations.clear();
      eticketCon.uniqueDestinations.clear();
      eticketCon.listTicketSoldIdDestinasiYear.clear();

      await eticketCon.allEticketByOwnerInYear(
          ownerCon.idOBLogin, selectedYear);

      await eticketCon.getHistoryByYear(selectedYear);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
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
                      height: 510,
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
                              height: 50,
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
                                        selectedYear == null
                                            ? SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Text(
                                                  "Laporan Tahun Terakhir",
                                                  maxLines: 2,
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 18,
                                                      color: thirdColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            : SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Text(
                                                  "Laporan Tahun $selectedYear",
                                                  maxLines: 2,
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 18,
                                                      color: thirdColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          selectedYear == null
                                              ? "Tiket diurutkan berdasarkan tahun terakhir"
                                              : "Tiket diurutkan berdasarkan tahun $selectedYear",
                                          style: GoogleFonts.notoSansDisplay(
                                              fontSize: 12,
                                              color: captColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                      child: DropdownButton<String>(
                                    value: selectedYear,
                                    isDense: true,
                                    hint: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: const Center(
                                        child: Icon(
                                          Icons.calendar_month_outlined,
                                          color:
                                              Color.fromARGB(136, 36, 78, 79),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    icon: const SizedBox(),
                                    onChanged: (String? newValue) async {
                                      setState(() {
                                        selectedYear = newValue;
                                      });

                                      isLoading = true;
                                      Future.delayed(const Duration(seconds: 1))
                                          .then((value) async {
                                        try {
                                          await getChartDestinasi();
                                        } catch (e) {
                                          e;
                                        } finally {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      });
                                    },
                                    items: dropDownYear.map((String year) {
                                      return DropdownMenuItem<String>(
                                        value: year,
                                        child: Text(year),
                                      );
                                    }).toList(),
                                    underline: Container(),
                                    selectedItemBuilder:
                                        (BuildContext context) {
                                      return dropDownYear
                                          .map<Widget>((String year) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: const Icon(
                                            Icons.calendar_month_outlined,
                                            color:
                                                Color.fromARGB(136, 36, 78, 79),
                                            size: 20,
                                          ),
                                        );
                                      }).toList();
                                    },
                                  ))
                                ],
                              ),
                            ),
                           const SizedBox(
                              height: 10,
                            ),
                            eticketCon.eticketDataOwnerByYear != null
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
                                                              fontSize: 11,
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
                                                        "Rp ${eticketCon.totalIncomeTicketByYear.toString()}",
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
                                                                fontSize: 11,
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
                                                          "${eticketCon.eticketDataOwnerByYear!.length.toString()} Tiket",
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
                                : eticketCon.eticketDataOwnerByYear != null
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
                                                      .listTicketSoldIdDestinasiYear
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
                                                          .listTicketSoldIdDestinasiYear[
                                                      index]),
                                                  title: eticketCon
                                                      .listTicketSoldIdDestinasiYear[
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
                            eticketCon.eticketDataOwnerByYear != null
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
                                                fontSize: 10,
                                                color: captColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "Terjual",
                                            style: GoogleFonts.notoSansDisplay(
                                                fontSize: 10,
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
                            eticketCon.eticketDataOwnerByYear != null
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
                                              .uniqueNameDestinations.length,
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
                                                        height: 15,
                                                        width: 25,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 6.0),
                                                        child: Text(
                                                          eticketCon
                                                              .uniqueNameDestinations
                                                              .toList()[index],
                                                          style: GoogleFonts
                                                              .notoSansDisplay(
                                                                  fontSize: 11,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      64,
                                                                      64,
                                                                      64),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
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
                                                      eticketCon.listTicketSoldIdDestinasiYear[
                                                                  index] ==
                                                              null
                                                          ? "-"
                                                          : "${eticketCon.listTicketSoldIdDestinasiYear[index].toString()} Tiket",
                                                      style: GoogleFonts
                                                          .notoSansDisplay(
                                                              fontSize: 11,
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
                          selectedYear == null
                              ? Text(
                                  "Tahun Terakhir",
                                  style: GoogleFonts.notoSansDisplay(
                                      fontSize: 10,
                                      color: captColor,
                                      fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  "Tahun $selectedYear",
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
                    eticketCon.eticketDataOwnerByYear != null
                        ? SizedBox(
                            // width: MediaQuery.of(context),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  eticketCon.eticketDataOwnerByYear!.length,
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
                                                        .eticketDataOwnerByYear![
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
                                                        .eticketDataOwnerByYear![
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
                                                          "+ Rp${eticketCon.eticketDataOwnerByYear![index].price.toString()}",
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
                                                              .eticketDataOwnerByYear![
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
