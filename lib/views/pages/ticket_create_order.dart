import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/eticket_controller.dart';
import 'package:pergijalan_mobile/models/ticket.dart';
import 'package:pergijalan_mobile/views/pages/ticket_order_statuspayment_ticket.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/ticket_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/destinasi.dart';

class CreateOrderDetail extends StatefulWidget {
  final Destinasi idDestinasi;
  final Ticket idTicket;

  CreateOrderDetail({
    super.key,
    required this.idDestinasi,
    required this.idTicket,
  });

  @override
  State<CreateOrderDetail> createState() => _CreateOrderDetailState();
}

class _CreateOrderDetailState extends State<CreateOrderDetail> {
  bool isLoading = false;
  String? emailUser;
  DateTime selectedDate = DateTime.now();
  TextEditingController nameVisitor = TextEditingController();
  TextEditingController contactVisitor = TextEditingController();
  // TextEditingController dateVisit = TextEditingController();
  int? totalPrice;
  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO LIST TIKET-----------");
    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        final userCon = Provider.of<UserController>(context, listen: false);

        print("id ticket: ${widget.idTicket.id}");
        print("id owner: ${widget.idDestinasi.idOwner}");
        print("id destinasi: ${widget.idDestinasi.id}");
        print("id user: ${userCon.idUserLogin}");
        emailUser = userCon.emailLogin;

        totalPrice = widget.idTicket.price! + 1500;
      } catch (e) {
        print(e);
      }

      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

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
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEEE, d MMMM yyyy').format(selectedDate);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 250, 250, 250),
        title: Text(
          "Detail Pemesanan",
          style: GoogleFonts.openSans(
              fontSize: 17,
              color: Color.fromARGB(255, 49, 49, 49),
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left,
            color: Color.fromARGB(255, 49, 49, 49),
            size: 25,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 199, 199, 199)
                                  .withOpacity(0.8),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 20, 16, 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          widget.idDestinasi.nameDestinasi
                                              .toString(),
                                          maxLines: 4,
                                          style: GoogleFonts.openSans(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 49, 49, 49),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, bottom: 10),
                                      child: Container(
                                        height: 0.7,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        color: captColor,
                                      ),
                                    ),
                                    Text(
                                      "LOKASI",
                                      style: GoogleFonts.openSans(
                                          fontSize: 11,
                                          color: captColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text(
                                        widget.idDestinasi.address.toString(),
                                        style: GoogleFonts.openSans(
                                            fontSize: 13,
                                            color:
                                                Color.fromARGB(255, 49, 49, 49),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10),
                                      child: Container(
                                          child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "JAM BUKA",
                                                style: GoogleFonts.openSans(
                                                    fontSize: 11,
                                                    color: captColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                child: Text(
                                                  widget.idDestinasi.openHour ==
                                                          null
                                                      ? "-"
                                                      : widget
                                                          .idDestinasi.openHour
                                                          .toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 13,
                                                      color: Color.fromARGB(
                                                          255, 49, 49, 49),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Container(
                                              width: 1,
                                              height: 22,
                                              color: captColor,
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "JAM TUTUP",
                                                style: GoogleFonts.openSans(
                                                    fontSize: 11,
                                                    color: captColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                child: Text(
                                                  widget.idDestinasi
                                                              .closedHour ==
                                                          null
                                                      ? "-"
                                                      : widget.idDestinasi
                                                          .closedHour
                                                          .toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 13,
                                                      color: Color.fromARGB(
                                                          255, 49, 49, 49),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            height: 65,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.27,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: widget.idDestinasi
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
                                                      imageUrl: widget
                                                          .idDestinasi
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
                                          Container(
                                            height: 65,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.27,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Color.fromARGB(
                                                    88, 255, 255, 255)),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "KONTAK",
                                          style: GoogleFonts.openSans(
                                              fontSize: 11,
                                              color: captColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.27,
                                        child: Text(
                                          widget.idDestinasi.contact.toString(),
                                          maxLines: 2,
                                          style: GoogleFonts.openSans(
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 49, 49, 49),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 6.0, bottom: 10),
                              child: Container(
                                height: 0.7,
                                width: MediaQuery.of(context).size.width,
                                color: captColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "JENIS TIKET",
                                  style: GoogleFonts.openSans(
                                      fontSize: 11,
                                      color: captColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: Text(
                                    widget.idTicket.nameTicket == null
                                        ? ""
                                        : widget.idTicket.nameTicket.toString(),
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 49, 49, 49),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  "Rp ${widget.idTicket.price.toString()}",
                                  style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      color: Color.fromARGB(255, 49, 49, 49),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "1 Tiket",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                      fontSize: 11,
                                      color: captColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Harga tidak termaksud pajak",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                      fontSize: 11,
                                      color: captColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.textSlash,
                                        size: 10,
                                        color: captColor,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Text(
                                          "Tidak bisa ubah data pengunjung",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.openSans(
                                              fontSize: 11,
                                              color: captColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.cancel,
                                        size: 10,
                                        color: captColor,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          "Tidak bisa dibatalkan",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.openSans(
                                              fontSize: 11,
                                              color: captColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 28,
                          ),
                          Text(
                            "Detail Pengunjung",
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Color.fromARGB(255, 61, 61, 61),
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 9),
                            child: Text(
                              "Nama Pengunjung",
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 61, 61, 61),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: captColor,
                                )),
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              style: GoogleFonts.openSans(
                                  fontSize: 13,
                                  color: titleColor,
                                  fontWeight: FontWeight.w600),
                              controller: nameVisitor,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: primaryColor,
                                    )),
                                hintText: 'Nama Lengkap',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 17.0, bottom: 9),
                            child: Text(
                              "Nomor Handphone",
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 61, 61, 61),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: captColor,
                                )),
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              style: GoogleFonts.openSans(
                                  fontSize: 13,
                                  color: titleColor,
                                  fontWeight: FontWeight.w600),
                              controller: contactVisitor,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: primaryColor,
                                    )),
                                hintText: 'Nomor Aktif',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 17.0, bottom: 9),
                            child: Text(
                              "Tanggal Kunjungan",
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 61, 61, 61),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(244, 61, 61, 61)),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.calendar,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        (formattedDate).toString(),
                                        style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, bottom: 10),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.addressCard,
                                  size: 15,
                                  color: captColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    emailUser.toString(),
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: captColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 17.0, bottom: 7),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: captColor,
                                  )),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 17.0, bottom: 14, left: 16),
                                    child: Text(
                                      "Metode Pembayaran",
                                      style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color:
                                              Color.fromARGB(255, 61, 61, 61),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.11,
                                              child: Image.asset(
                                                "assets/logo/mandiri_logo.jpg",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: Text(
                                                "Mandiri Virtual Akun",
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: Color.fromARGB(
                                                        255, 61, 61, 61),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: FaIcon(
                                            FontAwesomeIcons.dotCircle,
                                            size: 15,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            // width: MediaQuery.of(context).size.width*1,
                            // height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    "Pembayaran hanya dapat dilakukan melalui transfer Bank Mandiri",
                                    // maxLines: 4,
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: descColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: backgroundColor,
                                            content: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "Metode Pembayaran",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.inter(
                                                          fontSize: 18,
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "Kami hanya mendukung metode pembayaran melalui transfer BANK MANDIRI untuk memudahkan Anda dalam bertransaksi. Silakan pastikan untuk memiliki rekening Bank Mandiri sebelum melakukan pembayaran.",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 14,
                                                        color: titleColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  RichText(
                                                      textAlign:
                                                          TextAlign.center,
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                          text:
                                                              "Jika Anda memiliki pertanyaan atau memerlukan bantuan, jangan ragu untuk menghubungi tim ",
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  color:
                                                                      titleColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                      ])),
                                                  Center(
                                                    child: InkWell(
                                                      onTap: () async {
                                                        String email =
                                                            Uri.encodeComponent(
                                                                "danizasalsabila12@gmail.com");
                                                        String subject =
                                                            Uri.encodeComponent(
                                                                "Tentang Metode Pembayaran");
                                                        String body =
                                                            Uri.encodeComponent(
                                                                "Halo tim PergiJalan, saya $emailUser ingin menanyakan \n");
                                                        print(
                                                            subject); //output: Hello%20Flutter
                                                        Uri mail = Uri.parse(
                                                            "mailto:$email?subject=$subject&body=$body");
                                                        if (await launchUrl(
                                                            mail)) {
                                                        } else {}
                                                      },
                                                      child: Text(
                                                        "Developer kami",
                                                        textAlign:
                                                            TextAlign.center,

                                                        // textAlign: TextAlign.justify,
                                                        style: GoogleFonts.inter(
                                                            fontSize: 14,
                                                            color:
                                                                secondaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "Terima kasih atas dukungan Anda",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.inter(
                                                          fontSize: 14,
                                                          color: titleColor,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                    child: FaIcon(
                                      FontAwesomeIcons.circleQuestion,
                                      size: 18,
                                      color: secondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: List.generate(
                                  150 ~/ 3,
                                  (index) => Expanded(
                                        child: Container(
                                          color: index % 2 == 0
                                              ? Colors.grey.shade300
                                              : Colors.transparent,
                                          height: 1,
                                        ),
                                      )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Harga Tiket",
                                      style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: descColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Rp ${widget.idTicket.price.toString()}",
                                      style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Biaya Admin",
                                      style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: descColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Rp 1500",
                                      style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: List.generate(
                                        150 ~/ 3,
                                        (index) => Expanded(
                                              child: Container(
                                                color: index % 2 == 0
                                                    ? Colors.grey.shade300
                                                    : Colors.transparent,
                                                height: 1,
                                              ),
                                            )),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          )
                          //  Center(
                          //    child: Padding(
                          //      padding: const EdgeInsets.only(top: 17.0),
                          //      child: Container(
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(10),
                          //             color: Color.fromARGB(244, 226, 226, 226)),
                          //         width: MediaQuery.of(context).size.width,
                          //         height: 50,
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(left:16.0),
                          //           child: Padding(
                          //             padding: const EdgeInsets.only(left: 10.0),
                          //             child: Text(
                          //             emailUser.toString(),
                          //             style: GoogleFonts.inter(
                          //                 fontSize: 13,
                          //                 color: Color.fromARGB(255, 255, 255, 255),
                          //                 fontWeight: FontWeight.w500),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //    ),
                          //  ),
                          // Container(
                          //   child: Column(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: <Widget>[
                          //       Text(
                          //         "${(formattedDate).toString()}",
                          //         style: GoogleFonts.inter(
                          //             fontSize: 13,
                          //             color: Color.fromARGB(255, 61, 61, 61),
                          //             fontWeight: FontWeight.w500),
                          //       ),
                          //       const SizedBox(
                          //         height: 20.0,
                          //       ),
                          //       ElevatedButton(
                          //         onPressed: () => _selectDate(context),
                          //         child: const Text('Select date'),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ]),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: isLoading
          ? const SizedBox()
          : Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color.fromARGB(255, 192, 192, 192),
                    blurRadius: 10,
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10.0, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Harga",
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                color: captColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Rp $totalPrice",
                            style: GoogleFonts.inter(
                                fontSize: 19,
                                color: secondaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7, bottom: 7),
                      child: InkWell(
                        onTap: () async {
                          print("a");
                          isLoading = true;

                          final eticketCon = Provider.of<ETicketController>(
                              context,
                              listen: false);
                          final userCon = Provider.of<UserController>(context,
                              listen: false);
                          // Provider.of(context, listen: false);
                          if (nameVisitor.text.isEmpty ||
                              contactVisitor.text.isEmpty ||
                              formattedDate.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Data pengunjung boleh kosong",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red[300],
                                textColor: Colors.white,
                                fontSize: 16.0);

                            setState(() {
                              isLoading = false;
                            });
                            return;
                          }
                          try {
                            await eticketCon.postEticket(
                                idUser: userCon.idUserLogin,
                                idTicket: widget.idTicket.id,
                                idDestinasi: widget.idDestinasi.id,
                                idOwner: widget.idDestinasi.idOwner,
                                nameVisitor: nameVisitor.text,
                                contactVisitor: contactVisitor.text,
                                dateVisit: formattedDate.toString());

                            if (eticketCon.statusCodeAddEticket == 200) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StatusOrderPayment(
                                            id: eticketCon.idAddETicket!,
                                            // idDestinasi: widget.idDestinasi,
                                          )),
                                  (route) => false);
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              Fluttertoast.showToast(
                                  msg: eticketCon.messageAddEticket.toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red[300],
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              return;
                            }
                          } catch (error) {
                            error;
                            setState(() {
                              isLoading = false;
                            });
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: secondaryColor),
                          width: MediaQuery.of(context).size.width * 0.36,

                          // height: 50,
                          child: Center(
                            child: Text(
                              "Bayar",
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
