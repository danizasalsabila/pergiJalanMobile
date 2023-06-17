import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/eticket_controller.dart';
import 'package:pergijalan_mobile/controllers/owner_business_controller.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

class HistoryTicketByMonths extends StatefulWidget {
  const HistoryTicketByMonths({super.key});

  @override
  State<HistoryTicketByMonths> createState() => _HistoryTicketByMonthsState();
}

class _HistoryTicketByMonthsState extends State<HistoryTicketByMonths> {
  final List<String> dropDownYear = ['2022', '2023'];
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuMonth = [
      DropdownMenuItem(
          value: "1",
          child: Text(
            "Januari",
            style: GoogleFonts.notoSansDisplay(
                fontSize: 14, color: titleColor, fontWeight: FontWeight.w400),
          )),
      DropdownMenuItem(
          value: "2",
          child: Text(
            "Februari",
            style: GoogleFonts.notoSansDisplay(
                fontSize: 14, color: titleColor, fontWeight: FontWeight.w400),
          )),
      DropdownMenuItem(
          value: "3",
          child: Text(
            "Maret",
            style: GoogleFonts.notoSansDisplay(
                fontSize: 14, color: titleColor, fontWeight: FontWeight.w400),
          )),
      DropdownMenuItem(
          value: "4",
          child: Text(
            "April",
            style: GoogleFonts.notoSansDisplay(
                fontSize: 14, color: titleColor, fontWeight: FontWeight.w400),
          )),
      DropdownMenuItem(
          value: "5",
          child: Text(
            "Mei",
            style: GoogleFonts.notoSansDisplay(
                fontSize: 14, color: titleColor, fontWeight: FontWeight.w400),
          )),
      DropdownMenuItem(
          value: "6",
          child: Text(
            "Juni",
            style: GoogleFonts.notoSansDisplay(
                fontSize: 14, color: titleColor, fontWeight: FontWeight.w400),
          )),
      DropdownMenuItem(
          value: "7",
          child: Text(
            "Juli",
            style: GoogleFonts.notoSansDisplay(
                fontSize: 14, color: titleColor, fontWeight: FontWeight.w400),
          )),
      DropdownMenuItem(
          value: "8",
          child: Text(
            "Agustus",
            style: GoogleFonts.notoSansDisplay(
                fontSize: 14, color: titleColor, fontWeight: FontWeight.w400),
          )),
      DropdownMenuItem(
          value: "9",
          child: Text(
            "September",
            style: GoogleFonts.notoSansDisplay(
                fontSize: 14, color: titleColor, fontWeight: FontWeight.w400),
          )),
      DropdownMenuItem(
          value: "10",
          child: Text(
            "Oktober",
            style: GoogleFonts.notoSansDisplay(
                fontSize: 14, color: titleColor, fontWeight: FontWeight.w400),
          )),
      DropdownMenuItem(
          value: "11",
          child: Text(
            "November",
            style: GoogleFonts.notoSansDisplay(
                fontSize: 14, color: titleColor, fontWeight: FontWeight.w400),
          )),
      DropdownMenuItem(
          value: "12",
          child: Text(
            "Desember",
            style: GoogleFonts.notoSansDisplay(
                fontSize: 14, color: titleColor, fontWeight: FontWeight.w400),
          )),
    ];
    return menuMonth;
  }

  String? selectedYear;
  String? selectedMonth;

  bool isLoading = false;
  int touchedIndex = -1;
  DateTime currentDate = DateTime.now();
  DateTime currentMonth = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO SALES HISTORY BY MONTH-----------");
    final eticketCon = Provider.of<ETicketController>(context, listen: false);
    final ownerCon =
        Provider.of<OwnerBusinessController>(context, listen: false);
    isLoading = true;
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      try {
        eticketCon.uniqueDestinationsMonth.clear();
        eticketCon.uniqueNameDestinationsMonth.clear();
        eticketCon.listTicketSoldIdDestinasiMonth.clear();

        String currentYear = currentDate.year.toString();
        String currentMonth = currentDate.month.toString();
        eticketCon.ticketSoldIdDestinasiMonth = 0;

        await eticketCon.allEticketByOwnerInMonth(
            ownerCon.idOBLogin, currentYear, currentMonth);

        await eticketCon.getHistoryByMonth(currentYear, currentMonth);
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
      eticketCon.uniqueDestinationsMonth.clear();
      eticketCon.uniqueNameDestinationsMonth.clear();
      eticketCon.listTicketSoldIdDestinasiMonth.clear();
      // eticketCon.addcountMonthDataLength.clear();

      await eticketCon.allEticketByOwnerInMonth(
          ownerCon.idOBLogin, selectedYear, selectedMonth);

      await eticketCon.getHistoryByMonth(selectedYear, selectedMonth);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Color getRandomColor(int index) {
    // isLoading = true;
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
                              height: 70,
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
                                                  "Laporan Bulan Terakhir",
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
                                                  "Laporan Bulan $selectedMonth",
                                                  maxLines: 2,
                                                  textAlign: TextAlign.left,
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
                                          selectedYear == null
                                              ? "Tiket diurutkan berdasarkan bulan terakhir"
                                              : "Tiket diurutkan berdasarkan bulan $selectedMonth di tahun $selectedYear",
                                          style: GoogleFonts.notoSansDisplay(
                                              fontSize: 12,
                                              color: captColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      // print(
                                      //     "INI YAAAAAAAAAAAAAAA ${eticketCon.b.toList().toString()}");
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(builder:
                                              (BuildContext context,
                                                  StateSetter setState) {
                                            return AlertDialog(
                                              title: Text(
                                                'Pilih bulan dan tahun untuk mendapatkan laporan yang diinginkan',
                                                style:
                                                    GoogleFonts.notoSansDisplay(
                                                        fontSize: 12,
                                                        color: titleColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              content: Container(
                                                height: 70,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                          child: Text(
                                                            'Bulan',
                                                            style: GoogleFonts
                                                                .notoSansDisplay(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        captColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                          child: DropdownButton<
                                                                  String>(
                                                              underline:
                                                                  const SizedBox(),
                                                              value:
                                                                  selectedMonth,
                                                              isExpanded: true,
                                                              isDense: true,
                                                              hint: Text(
                                                                selectedMonth !=
                                                                        null
                                                                    ? "${selectedMonth.toString()}"
                                                                    : 'Cari Bulan',
                                                                style: GoogleFonts.notoSansDisplay(
                                                                    fontSize:
                                                                        13,
                                                                    color:
                                                                        captColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              onChanged: (String?
                                                                  value) async {
                                                                setState(() {
                                                                  selectedMonth =
                                                                      value;
                                                                });
                                                              },
                                                              items:
                                                                  dropdownItems),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                        height: 15.0),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                          child: Text(
                                                            'Tahun',
                                                            style: GoogleFonts
                                                                .notoSansDisplay(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        captColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.3,
                                                            child:
                                                                DropdownButton<
                                                                    String>(
                                                              underline:
                                                                  const SizedBox(),
                                                              isDense: true,
                                                              isExpanded: true,
                                                              hint: Text(
                                                                selectedYear !=
                                                                        null
                                                                    ? selectedYear
                                                                        .toString()
                                                                    : "Cari Tahun",
                                                                style: GoogleFonts.notoSansDisplay(
                                                                    fontSize:
                                                                        13,
                                                                    color:
                                                                        captColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              value:
                                                                  selectedYear,
                                                              onChanged: (String?
                                                                  newValue) async {
                                                                setState(() {
                                                                  selectedYear =
                                                                      newValue;
                                                                });
                                                              },
                                                              items: dropDownYear
                                                                  .map((String
                                                                      year) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value: year,
                                                                  child: Text(
                                                                    year,
                                                                    style: GoogleFonts.notoSansDisplay(
                                                                        fontSize:
                                                                            14,
                                                                        color:
                                                                            titleColor,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 28.0,
                                                          right: 28),
                                                  child: Center(
                                                    child: ElevatedButton(
                                                      // style: B,
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    labelColor), // Mengubah warna latar belakang
                                                        foregroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(Colors
                                                                    .white), // Mengubah warna teks
                                                        padding: MaterialStateProperty
                                                            .all<EdgeInsets>(
                                                                const EdgeInsets
                                                                        .all(
                                                                    10)), // Mengubah padding
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8), // Mengubah bentuk border
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        isLoading = true;
                                                        if (selectedMonth ==
                                                                null ||
                                                            selectedYear ==
                                                                null) {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Bulan atau tahun tidak boleh kosong",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  Colors
                                                                      .red[300],
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0);
                                                          return;
                                                        } else {
                                                          print(
                                                              "data ditekan $selectedMonth and $selectedYear");
                                                          Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          1))
                                                              .then(
                                                                  (value) async {
                                                            try {
                                                              await getChartDestinasi();
                                                            } catch (e) {
                                                              e;
                                                            } finally {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              setState(() {
                                                                isLoading =
                                                                    false;
                                                              });
                                                            }
                                                          });
                                                        }
                                                      },
                                                      child: Text(
                                                        'Pilih',
                                                        style: GoogleFonts
                                                            .openSans(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                        },
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Color.fromARGB(136, 36, 78, 79),
                                        size: 20,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            eticketCon.eticketDataOwnerByMonth != null
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
                                                        "Rp ${eticketCon.totalIncomeTicketByMonth.toString()}",
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
                                                          "${eticketCon.eticketDataOwnerByMonth!.length.toString()} Tiket",
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
                                : eticketCon.eticketDataOwnerByMonth != null
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
                                                      .listTicketSoldIdDestinasiMonth
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
                                                          .listTicketSoldIdDestinasiMonth[
                                                      index]),
                                                  title: eticketCon
                                                      .listTicketSoldIdDestinasiMonth
                                                      .toList()[index]
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
                            eticketCon.eticketDataOwnerByMonth != null
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
                            eticketCon.eticketDataOwnerByMonth != null
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
                                              .uniqueNameDestinationsMonth
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
                                                              .uniqueNameDestinationsMonth
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
                                                      eticketCon.listTicketSoldIdDestinasiMonth[
                                                                      index]
                                                                  .toString() ==
                                                              null
                                                          ? "-"
                                                          : "${eticketCon.listTicketSoldIdDestinasiMonth[index].toString()} Tiket",
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
                                  "Bulan Terakhir",
                                  style: GoogleFonts.notoSansDisplay(
                                      fontSize: 10,
                                      color: captColor,
                                      fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  "Bulan $selectedMonth, tahun $selectedYear",
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
                    eticketCon.eticketDataOwnerByMonth != null
                        ? SizedBox(
                            // width: MediaQuery.of(context),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  eticketCon.eticketDataOwnerByMonth!.length,
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
                                                        .eticketDataOwnerByMonth![
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
                                                        .eticketDataOwnerByMonth![
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
                                                          "+ Rp${eticketCon.eticketDataOwnerByMonth![index].price.toString()}",
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
                                                              .eticketDataOwnerByMonth![
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
