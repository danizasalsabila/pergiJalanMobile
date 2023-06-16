import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/eticket_controller.dart';
import 'package:pergijalan_mobile/controllers/owner_business_controller.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

import '../../../controllers/ticket_controller.dart';

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

  bool isPressed = false;
  DateTime currentDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO HOMEPAGE-----------");
    final eticketCon = Provider.of<ETicketController>(context, listen: false);
    final ownerCon =
        Provider.of<OwnerBusinessController>(context, listen: false);
    isLoading = true;
    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        String currentYear = currentDate.year.toString();
        await eticketCon.allEticketByOwnerInYear(
            ownerCon.idOBLogin, currentYear);
        getChartDestinasi();
      } catch (e) {
        print(e);
      }

      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  void getChartDestinasi() {
    final eticketCon = Provider.of<ETicketController>(context, listen: false);
    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        eticketCon.getHistoryByYear();
      } catch (e) {
        print(e);
      }

      setState(() {
        isLoading = false;
      });
    });

    // setState(() {
    //   isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final ownerCon =
        Provider.of<OwnerBusinessController>(context, listen: false);
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
                    // SizedBox(height: 20,),
                    Stack(
                      children: [
                        Container(
                          height: 450,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40))),
                        ),
                        SizedBox(
                          height: 450,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Column(children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        selectedYear == null
                                            ? Text(
                                                "Laporan Tahun Terakhir",
                                                style: GoogleFonts.openSans(
                                                    fontSize: 20,
                                                    color: thirdColor,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            : Text(
                                                "Laporan Tahunan $selectedYear",
                                                style: GoogleFonts.openSans(
                                                    fontSize: 20,
                                                    color: thirdColor,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                        Text(
                                          "Tiket akan diurutkan berdasarkan satu tahun terakhir",
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
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    icon: SizedBox(),
                                    onChanged: (String? newValue) async {
                                      setState(() {
                                        selectedYear = newValue;
                                        isPressed = true;
                                      });
                                      isLoading = true;

                                      eticketCon.uniqueNameDestinations.clear();
                                      eticketCon.uniqueDestinations.clear();
                                      eticketCon.listTicketSoldIdDestinasi!
                                          .clear();

                                      await eticketCon.allEticketByOwnerInYear(
                                          ownerCon.idOBLogin, selectedYear);

                                      getChartDestinasi();

                                      setState(() {
                                        isLoading = false;
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
                                          child: Icon(
                                            Icons.calendar_month_outlined,
                                            color: Colors.grey,
                                            size: 20,
                                          ),
                                        );
                                      }).toList();
                                    },
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                      ),
                                    )
                                  : Row(
                                      children: <Widget>[
                                        // const SizedBox(
                                        //   height: 18,
                                        // ),
                                        eticketCon.eticketDataOwnerByYear !=
                                                null
                                            ? Expanded(
                                                child: AspectRatio(
                                                  aspectRatio: 2,
                                                  child: PieChart(
                                                    PieChartData(
                                                      pieTouchData:
                                                          PieTouchData(
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
                                                              .listTicketSoldIdDestinasi!
                                                              .length, (i) {
                                                        final isTouched =
                                                            i == touchedIndex;
                                                        final fontSize =
                                                            isTouched
                                                                ? 25.0
                                                                : 16.0;
                                                        final radius = isTouched
                                                            ? 60.0
                                                            : 50.0;
                                                        const shadows = [
                                                          Shadow(
                                                              color:
                                                                  Colors.black,
                                                              blurRadius: 2)
                                                        ];
                                                        Color randomColor =
                                                            getRandomColor(i);

                                                        return PieChartSectionData(
                                                          color: randomColor,
                                                          // value: 40,
                                                          title: eticketCon
                                                              .listTicketSoldIdDestinasi![
                                                                  i]
                                                              .toString(),
                                                          radius: radius,
                                                          titleStyle: TextStyle(
                                                            fontSize: fontSize,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                height: 200,
                                                child: Center(
                                                    child: Lottie.asset(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        "assets/lottie/no_data.json")),
                                              ),

                                        SizedBox(
                                          width: 28,
                                        ),
                                      ],
                                    ),
                              SizedBox(
                                height: 40,
                              ),
                              isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: 80,
                                        // width: MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            controller: _scrollController,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: eticketCon
                                                .uniqueNameDestinations.length,
                                            itemBuilder: (context, index) {
                                              Color randomColor =
                                                  getRandomColor(index);
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 30.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      eticketCon
                                                          .uniqueNameDestinations
                                                          .toList()[index],
                                                      style: GoogleFonts
                                                          .notoSansDisplay(
                                                              fontSize: 12,
                                                              color: captColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          eticketCon
                                                              .listTicketSoldIdDestinasi![
                                                                  index]
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .notoSansDisplay(
                                                                  fontSize: 25,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          49,
                                                                          49,
                                                                          49),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                        Text(
                                                          " Terjual",
                                                          style: GoogleFonts
                                                              .notoSansDisplay(
                                                                  fontSize: 12,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          49,
                                                                          49,
                                                                          49),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: randomColor,
                                                      ),
                                                      height: 10,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                    ),
                                                    // SizedBox(
                                                    //   height: 20,
                                                    // )
                                                  ],
                                                ),
                                              );
                                              // Column(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.end,
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.start,
                                              //   children: <Widget>[
                                              //     Indicator(
                                              //       color: Colors.blue,
                                              //       text: uniqueNameDestinations
                                              //           .toList()[index],
                                              //       isSquare: true,
                                              //     ),
                                              //   ],
                                              // );
                                            }),
                                      ),
                                    ),
                              eticketCon.eticketDataOwnerByYear != null
                                  ? Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Total Pendapatan",
                                            style: GoogleFonts.notoSansDisplay(
                                                fontSize: 12,
                                                color: captColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Rp ${eticketCon.totalIncomeTicketByYear.toString()}",
                                            style: GoogleFonts.notoSansDisplay(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 49, 49, 49),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                            ]),
                          ),
                        )
                      ],
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
                                fontSize: 18,
                                color: thirdColor,
                                fontWeight: FontWeight.w700),
                          ),
                          selectedYear == null
                              ? Text(
                                  "Tahun Terakhir",
                                  style: GoogleFonts.notoSansDisplay(
                                      fontSize: 10,
                                      color: captColor,
                                      fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  "Tahun $selectedYear",
                                  style: GoogleFonts.notoSansDisplay(
                                      fontSize: 10,
                                      color: captColor,
                                      fontWeight: FontWeight.w600),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    eticketCon.eticketDataOwnerByYear != null
                        ? Container(
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
                                  padding: EdgeInsets.only(
                                      left: 30, right: 30, bottom: 15),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
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
                                          Container(
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
                                          Container(
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
                                          Container(
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
                    SizedBox(
                      height: 20,
                    ),
                  ]);
                }),
              ),
            ),
    );
  }

  // void countIdDestinasi(){

  // }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

// class PieChartByYear extends StatefulWidget {
//   const PieChartByYear({super.key});

//   @override
//   State<StatefulWidget> createState() => PieChart2State();
// }

// class PieChart2State extends State<PieChartByYear> {

//   @override
//   Widget build(BuildContext context) {
//     return
//   }

// }

Color getRandomColor(int index) {
  Random random = Random(index);
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
