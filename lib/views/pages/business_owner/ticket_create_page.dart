import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/destinasi_controller.dart';
import 'package:pergijalan_mobile/controllers/ticket_controller.dart';
import 'package:provider/provider.dart';

import '../../../controllers/owner_business_controller.dart';
import '../../../models/destinasi.dart';
import 'home.dart';

class CreateTicketPage extends StatefulWidget {
  final int idDestinasi;
  // final Destinasi destinasi;
  CreateTicketPage({
    super.key,
    required this.idDestinasi,
  });

  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  bool isLoading = false;
  bool isUploading = false;

  TextEditingController nameTicketController = TextEditingController();
  TextEditingController stockTicketController = TextEditingController();
  TextEditingController priceTicketController = TextEditingController();

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO LIST TIKET-----------");

    final destCon = Provider.of<DestinasiController>(context, listen: false);
    isLoading = true;
    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        await destCon.getDestinasiById(widget.idDestinasi);
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
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePageOwner()),
                (route) => false);
          },
          child: const Icon(
            Icons.chevron_left,
            color: Color.fromARGB(255, 41, 41, 41),
          ),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SingleChildScrollView(
              child: Consumer<DestinasiController>(
                  builder: (context, destCon, child) {
                return Padding(
                  padding: const EdgeInsets.only(left: 22.0, right: 22),
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Tambah tiket wisata",
                        style: GoogleFonts.openSans(
                            fontSize: 17,
                            color: const Color.fromARGB(255, 41, 41, 41),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Detail Tempat Wisata",
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color:
                                        const Color.fromARGB(255, 41, 41, 41),
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, bottom: 10.0),
                                child: Text(
                                  "Berikut adalah informasi yang akan ditampilkan pada e-ticket wisatawan",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w400),
                                  maxLines: 5,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(6)),
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          destCon.destinasiDataId!.nameDestinasi
                                              .toString(),
                                          style: GoogleFonts.inter(
                                              fontSize: 11,
                                              color: titleColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: FaIcon(
                                            FontAwesomeIcons.placeOfWorship,
                                            size: 15,
                                            color:
                                                Color.fromARGB(193, 36, 78, 79),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      width: MediaQuery.of(context).size.width *
                                          0.375,
                                      height: 45,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                destCon.destinasiDataId!
                                                            .openHour !=
                                                        null
                                                    ? destCon.destinasiDataId!
                                                        .openHour
                                                        .toString()
                                                    : "-",
                                                style: GoogleFonts.inter(
                                                    fontSize: 11,
                                                    color: titleColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 2),
                                                child: FaIcon(
                                                  FontAwesomeIcons.doorOpen,
                                                  size: 15,
                                                  color: Color.fromARGB(
                                                      193, 36, 78, 79),
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      width: MediaQuery.of(context).size.width *
                                          0.375,
                                      height: 45,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                destCon.destinasiDataId!
                                                            .closedHour !=
                                                        null
                                                    ? destCon.destinasiDataId!
                                                        .closedHour
                                                        .toString()
                                                    : "-",
                                                style: GoogleFonts.inter(
                                                    fontSize: 11,
                                                    color: titleColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 2),
                                                child: FaIcon(
                                                  FontAwesomeIcons.doorClosed,
                                                  size: 15,
                                                  color: Color.fromARGB(
                                                      193, 36, 78, 79),
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(6)),
                                  width: MediaQuery.of(context).size.width,
                                  // height: 45,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 8,
                                        top: 15,
                                        bottom: 15),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Text(
                                              destCon.destinasiDataId!.address
                                                  .toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.inter(
                                                  fontSize: 11,
                                                  color: titleColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: FaIcon(
                                              FontAwesomeIcons.locationDot,
                                              size: 15,
                                              color: Color.fromARGB(
                                                  193, 36, 78, 79),
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Masukkan Informasi Tiket",
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color:
                                        const Color.fromARGB(255, 41, 41, 41),
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 4.0,
                                ),
                                child: Text(
                                  "Pastikan untuk memberikan informasi yang akurat dan jelas agar pengunjung dapat mengetahui dengan jelas apa yang ditawarkan oleh tiket wisata",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w400),
                                  maxLines: 5,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, bottom: 6),
                                child: Text(
                                  "Nama Tiket",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color:
                                          const Color.fromARGB(255, 41, 41, 41),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.grey.shade200,
                                    )),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: TextField(
                                    controller: nameTicketController,
                                    style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        color: titleColor,
                                        fontWeight: FontWeight.w600),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.only(left: 6),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, bottom: 6),
                                child: Text(
                                  "Harga Tiket",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color:
                                          const Color.fromARGB(255, 41, 41, 41),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.grey.shade200,
                                    )),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: TextField(
                                    controller: priceTicketController,
                                    style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        color: titleColor,
                                        fontWeight: FontWeight.w600),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 6),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, bottom: 6),
                                child: Text(
                                  "Stok Tersedia",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color:
                                          const Color.fromARGB(255, 41, 41, 41),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.grey.shade200,
                                    )),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: TextField(
                                    controller: stockTicketController,
                                    style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        color: titleColor,
                                        fontWeight: FontWeight.w600),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 6),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              InkWell(
                                onTap: () async {
                                  final ticketCon =
                                      Provider.of<TicketController>(context,
                                          listen: false);
                                  if (nameTicketController.text.isEmpty ||
                                      priceTicketController.text.isEmpty ||
                                      stockTicketController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Data tidak boleh kosong",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red[300],
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    return;
                                  } else {
                                    // setState(() {
                                      isLoading = true;
                                    // });
                                    try {
                                      await ticketCon.addTicketByIdDestinasi(
                                          idDestinasi: widget.idDestinasi,
                                          price: int.parse(
                                              priceTicketController.text),
                                          stock: int.parse(
                                              stockTicketController.text));
                                      if (ticketCon.statusCodeAddTicket ==
                                          200) {
                                        print("post tiket sukses");
                                        setState(() {
                                          isLoading = false;
                                        });
                                         // ignore: use_build_context_synchronously
                                         Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePageOwner()));

                                        Fluttertoast.showToast(
                                            msg:
                                                "Tiket tempat wisatamu telah ditambahkan!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                primaryColor.withOpacity(0.6),
                                            textColor: Colors.white,
                                            fontSize: 13);
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Fluttertoast.showToast(
                                            msg:
                                                "Tiket gagal ditambahkan\nMohon coba lagi nanti",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red[300],
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        return;
                                      }
                                    } catch (e) {
                                      print("error masuk catch");
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Fluttertoast.showToast(
                                          msg: "Terjadi error",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red[300],
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      return;
                                    }
                                  }

                                },
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: thirdColor),
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text(
                                    "Tambah",
                                    style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25),
                      child: Center(
                        child: Text(
                          "Terima kasih atas kerjasamanya dalam memberikan informasi yang diperlukan untuk menciptakan pengalaman wisata yang luar biasa bagi para pengunjung",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 9,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w400),
                          maxLines: 5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ]),
                );
              }),
            ),
    );
  }
}
