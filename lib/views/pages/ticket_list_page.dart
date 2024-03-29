import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/ticket_controller.dart';
import 'package:pergijalan_mobile/models/destinasi.dart';
import 'package:provider/provider.dart';

import 'ticket_create_order.dart';

class ListTicketDestination extends StatefulWidget {
  final Destinasi id;
  ListTicketDestination({super.key, required this.id});

  @override
  State<ListTicketDestination> createState() => _ListTicketDestinationState();
}

class _ListTicketDestinationState extends State<ListTicketDestination> {
  bool isLoading = false;
  TextEditingController addToCart = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  var now = new DateTime.now();
  bool addQuantity = false;
  int quantity = 1;

  void _incrementQuantity() {
    setState(() {
      quantity++;
      addToCart.text = quantity.toString();
    });
  }

  void _updateInt(String value) {
    print("update addtocart into integer quantity");
    setState(() {
      quantity = int.tryParse(value) ?? 1;
      if (quantity < 1) {
        // quantity = 1;
        print("falseeeeeeeeeeeeeeeeeeeeee $quantity");
        Fluttertoast.showToast(
            msg:
                "Anda hanya dapat memesan minimal 1 pembelian tiket dalam 1 kali transaksi",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: primaryColor.withOpacity(0.5),
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (quantity > 5) {
        // quantity = 5;

        print("falseeeeeeeeeeeeeeeeeeeeee $quantity");
        Fluttertoast.showToast(
            msg:
                "Anda hanya dapat memesan maksimal 5 tiket dalam 1 kali transaksi",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: primaryColor.withOpacity(0.5),
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (quantity == null) {
        print("TRUE masukkan angka jumlah pesan");
      } else {
        quantity = int.tryParse(value) ?? 1;
        print("trueeeeeeeeeeeeee $quantity");
      }
    });
  }

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO LIST TIKET-----------");
    final ticketCon = Provider.of<TicketController>(context, listen: false);
    // print(widget.id.id);

    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        print(widget.id.id);
        await ticketCon.getTicketbyIdDestination(widget.id.id);

        // _updateInt();
      } catch (e) {
        print(e);
      }

      setState(() {
        isLoading = false;
      });
    });
    super.initState();
    // addToCart =
    addToCart.text = quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMMM yyyy').format(now);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Consumer<TicketController>(
                    builder: (context, ticketCon, child) {
                  return Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: widget.id.destinationPicture == null
                                  ? Image.asset(
                                      "assets/images/no_image2.jpg",
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      placeholder: (context, url) => Center(
                                          child:
                                              new CircularProgressIndicator()),
                                      imageUrl: widget.id.destinationPicture!,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        "assets/images/error_image.jpeg",
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                            ),
                            Container(
                              height: 170,
                              color: Color.fromARGB(214, 12, 69, 104),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const SizedBox(
                                  height: 50,
                                  child: Icon(
                                    Icons.chevron_left,
                                    color: Colors.white,
                                    size: 27,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 65,
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tiket Kunjungan",
                                      style: GoogleFonts.openSans(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      formattedDate,
                                      style: GoogleFonts.notoSans(
                                          fontSize: 13,
                                          color: descColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 85,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: FaIcon(
                                              FontAwesomeIcons.locationDot,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                          ),
                                          Text(
                                            "Lokasi Anda",
                                            style: GoogleFonts.notoSansDisplay(
                                                fontSize: 12,
                                                color: captColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6.0, right: 6),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
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
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: FaIcon(
                                              FontAwesomeIcons.mapLocation,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                          ),
                                          Text(
                                            widget.id.city.toString(),
                                            style: GoogleFonts.notoSansDisplay(
                                                fontSize: 12,
                                                color: captColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 130,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 250, 250, 250),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  ),
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Center(
                                          child: Container(
                                        height: 3,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: primaryColor),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Tiket Tersedia",
                                          style: GoogleFonts.notoSansDisplay(
                                              fontSize: 19,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Pilih tiket sesuai keterangan",
                                          style: GoogleFonts.notoSansDisplay(
                                              fontSize: 13,
                                              color: captColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      child: MediaQuery.removePadding(
                                        removeBottom: true,
                                        removeTop: true,
                                        context: context,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            controller: _scrollController,
                                            itemCount:
                                                ticketCon.ticketData?.length,
                                            itemBuilder: (context, index) {
                                              return ticketCon
                                                          .ticketData![index]
                                                          .stock !=
                                                      0
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          20, 0, 20, 15),
                                                      child: Container(
                                                        // height: 150,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            199,
                                                                            199,
                                                                            199)
                                                                    .withOpacity(
                                                                        0.8),
                                                                spreadRadius: 2,
                                                                blurRadius: 4,
                                                                offset: const Offset(
                                                                    0,
                                                                    2), // changes position of shadow
                                                              ),
                                                            ],
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  15,
                                                                  18.0,
                                                                  15,
                                                                  15),
                                                          child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      ticketCon
                                                                          .ticketData![
                                                                              index]
                                                                          .nameTicket
                                                                          .toString(),
                                                                      style: GoogleFonts.inter(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              secondaryColor,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    Text(
                                                                      "Harga Tiket",
                                                                      style: GoogleFonts.openSans(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              captColor,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 2,
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      widget.id.openHour !=
                                                                              null
                                                                          ? "${widget.id.openHour.toString()} - ${widget.id.closedHour.toString()}"
                                                                          : "",
                                                                      style: GoogleFonts.openSans(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              captColor,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Text(
                                                                          "Rp ${ticketCon.ticketData![index].price.toString()}",
                                                                          style: GoogleFonts.openSans(
                                                                              fontSize: 19,
                                                                              color: Colors.orange,
                                                                              fontWeight: FontWeight.w700),
                                                                        ),
                                                                        Text(
                                                                          "/pax",
                                                                          style: GoogleFonts.openSans(
                                                                              fontSize: 12,
                                                                              color: captColor,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    // DottedLine(
                                                                    //   direction: Axis.vertical,

                                                                    // )
                                                                    // Flex(
                                                                    //   direction: Axis.vertical,
                                                                    //   children:[
                                                                    //    const MySeparator(color: Colors.grey,)
                                                                    //   ] )
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 5.0),
                                                                  child: Row(
                                                                    children: List.generate(
                                                                        150 ~/ 3,
                                                                        (index) => Expanded(
                                                                              child: Container(
                                                                                color: index % 2 == 0 ? Colors.grey.shade300 : Colors.transparent,
                                                                                height: 1,
                                                                              ),
                                                                            )),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.orange[400],
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              20,
                                                                              2.0,
                                                                              20,
                                                                              2),
                                                                          child:
                                                                              Text(
                                                                            "Tiket ${index + 1}",
                                                                            style: GoogleFonts.openSans(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "${ticketCon.ticketData![index].ticketSold} Terjual",
                                                                        style: GoogleFonts.openSans(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                captColor,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                ticketCon.ticketData![index]
                                                                            .stock! <
                                                                        5
                                                                    ? Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                2.0,
                                                                            bottom:
                                                                                4),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.topRight,
                                                                          child:
                                                                              Text(
                                                                            "${ticketCon.ticketData![index].stock} Tiket tersisa!",
                                                                            style: GoogleFonts.inter(
                                                                                fontSize: 11,
                                                                                color: Color.fromARGB(255, 236, 85, 82),
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : SizedBox(),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.35,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              FaIcon(
                                                                                FontAwesomeIcons.textSlash,
                                                                                size: 10,
                                                                                color: captColor,
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 3.0),
                                                                                child: Text(
                                                                                  "Ubah pengunjung",
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: GoogleFonts.openSans(fontSize: 12, color: captColor, fontWeight: FontWeight.w500),
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
                                                                                padding: const EdgeInsets.only(left: 5.0),
                                                                                child: Text(
                                                                                  "Dibatalkan",
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: GoogleFonts.openSans(fontSize: 12, color: captColor, fontWeight: FontWeight.w500),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              FaIcon(
                                                                                FontAwesomeIcons.check,
                                                                                size: 10,
                                                                                color: captColor,
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 5.0),
                                                                                child: Text(
                                                                                  "Transfer Mandiri",
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: GoogleFonts.openSans(fontSize: 12, color: captColor, fontWeight: FontWeight.w500),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            // barrierDismissible:
                                                                            //     false,
                                                                            builder:
                                                                                (context) {
                                                                              return StatefulBuilder(builder: (context, StateSetter setState) {
                                                                                return AlertDialog(
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  backgroundColor: backgroundColor,
                                                                                  elevation: 5,
                                                                                  content: SizedBox(
                                                                                    height: 150,
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(left: 0),
                                                                                      child: Column(children: [
                                                                                        SizedBox(
                                                                                          height: 5,
                                                                                        ),
                                                                                        Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: Text(
                                                                                            "Jumlah Tiket",
                                                                                            textAlign: TextAlign.left,
                                                                                            style: GoogleFonts.openSans(fontSize: 18, color: Color.fromARGB(255, 5, 5, 5), fontWeight: FontWeight.w700),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 8,
                                                                                        ),
                                                                                        Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: Text(
                                                                                            "Pax",
                                                                                            textAlign: TextAlign.left,
                                                                                            style: GoogleFonts.openSans(fontSize: 16, color: Color.fromARGB(255, 5, 5, 5), fontWeight: FontWeight.w600),
                                                                                          ),
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Align(
                                                                                              alignment: Alignment.topLeft,
                                                                                              child: Text(
                                                                                                "Rp ${ticketCon.ticketData![index].price.toString()}",
                                                                                                textAlign: TextAlign.left,
                                                                                                style: GoogleFonts.openSans(fontSize: 14, color: Colors.orange, fontWeight: FontWeight.w700),
                                                                                              ),
                                                                                            ),
                                                                                            Row(
                                                                                              children: [
                                                                                                IconButton(
                                                                                                  // color: secondaryColor,
                                                                                                  icon: const Icon(
                                                                                                    Icons.remove,
                                                                                                    color: secondaryColor,
                                                                                                    size: 18,
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    addQuantity = true;
                                                                                                    setState(() {
                                                                                                      if (quantity <= 1) {
                                                                                                        Fluttertoast.showToast(msg: "Anda hanya dapat memesan minimal 1 pembelian tiket", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: primaryColor.withOpacity(0.5), textColor: Colors.white, fontSize: 16.0);
                                                                                                      } else if (quantity <= 5) {
                                                                                                        quantity--;
                                                                                                        addToCart.text = quantity.toString();
                                                                                                      } else {
                                                                                                        Fluttertoast.showToast(msg: "Anda hanya dapat memesan minimal 1 pembelian tiket", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: primaryColor.withOpacity(0.5), textColor: Colors.white, fontSize: 16.0);
                                                                                                      }
                                                                                                      print(quantity);
                                                                                                    });
                                                                                                  },
                                                                                                ),
                                                                                                Container(
                                                                                                  height: 45,
                                                                                                  width: 20,
                                                                                                  child: TextField(
                                                                                                    controller: addToCart,
                                                                                                    keyboardType: TextInputType.number,
                                                                                                    textInputAction: TextInputAction.next,
                                                                                                    onChanged: _updateInt,
                                                                                                    // onChanged: (value) {
                                                                                                    //   setState(() {
                                                                                                    //     // quantity = int.parse(addToCart);
                                                                                                    //     addQuantity = (value != quantity ? true : false);

                                                                                                    //     if (quantity <= 1 || quantity >= 5) {
                                                                                                    //       Fluttertoast.showToast(msg: "Anda hanya dapat memesan minimal 1 pembelian tiket serta maksimal 5 tiket", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: primaryColor.withOpacity(0.5), textColor: Colors.white, fontSize: 16.0);
                                                                                                    //     } else if (quantity >= 1 || quantity <= 5) {
                                                                                                    //       setState(() {
                                                                                                    //         quantity = int.parse(value);
                                                                                                    //         print(value);
                                                                                                    //       });
                                                                                                    //     } else {
                                                                                                    //       Fluttertoast.showToast(msg: "Mohon coba lagi nanti", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: primaryColor.withOpacity(0.5), textColor: Colors.white, fontSize: 16.0);
                                                                                                    //     }
                                                                                                    //   });
                                                                                                    //   // quantity = int.parse(addToCart.text);
                                                                                                    //   // value = addToCart.text;
                                                                                                    //   // quantity = int.tryParse(value) ?? 1;

                                                                                                    //   // if (addToCart == null) {
                                                                                                    //   //   print("a");
                                                                                                    //   //   setState((){
                                                                                                    //   //     addQuantity = (value != addToCart ? true:false);
                                                                                                    //   //   });
                                                                                                    //   // } else {
                                                                                                    //   //   print("b");

                                                                                                    //   //   setState(() {

                                                                                                    //   //   });
                                                                                                    //   // }
                                                                                                    //   // print("c");
                                                                                                    // },
                                                                                                  ),
                                                                                                ),
                                                                                                IconButton(
                                                                                                  icon: const Icon(Icons.add, color: secondaryColor, size: 18),
                                                                                                  onPressed: () {
                                                                                                    addQuantity = true;

                                                                                                    if (quantity >= 5) {
                                                                                                      Fluttertoast.showToast(msg: "Anda hanya dapat memesan maksimal 5 pembelian tiket", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: primaryColor.withOpacity(0.5), textColor: Colors.white, fontSize: 16.0);
                                                                                                    } else if (quantity <= 5) {
                                                                                                      setState(() {
                                                                                                        _incrementQuantity();
                                                                                                      });
                                                                                                    } else {
                                                                                                      Fluttertoast.showToast(msg: "Anda hanya dapat memesan maksimal 5 pembelian tiket", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: primaryColor.withOpacity(0.5), textColor: Colors.white, fontSize: 16.0);
                                                                                                    }
                                                                                                    print(quantity);
                                                                                                  },
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        InkWell(
                                                                                          onTap: () async {
                                                                                            if (quantity < 1 || quantity > 5) {
                                                                                              Fluttertoast.showToast(msg: "Masukkan jumlah tiket yang benar", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: primaryColor.withOpacity(0.5), textColor: Colors.white, fontSize: 16.0);
                                                                                            } else {
                                                                                              Navigator.push(
                                                                                                context,
                                                                                                MaterialPageRoute(
                                                                                                  builder: (context) => CreateOrderDetail(
                                                                                                    idDestinasi: widget.id,
                                                                                                    idTicket: ticketCon.ticketData![index],
                                                                                                    quantity: quantity,
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                              Fluttertoast.showToast(msg: "Pembayaran hanya melalui Transfer Bank Mandiri", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: primaryColor.withOpacity(0.5), textColor: Colors.white, fontSize: 16.0);
                                                                                            }
                                                                                          },
                                                                                          child: Container(
                                                                                            // width: MediaQuery.of(context).size.width * 0.35,
                                                                                            height: 33,
                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: secondaryColor),
                                                                                            child: Center(
                                                                                              child: Text(
                                                                                                "Pesan Tiket",
                                                                                                style: GoogleFonts.inter(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      ]),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              });
                                                                            });
                                                                        // Navigator
                                                                        //     .push(
                                                                        //   context,
                                                                        //   MaterialPageRoute(
                                                                        //     builder: (context) =>
                                                                        //         CreateOrderDetail(
                                                                        //       idDestinasi: widget.id,
                                                                        //       idTicket: ticketCon.ticketData![index],
                                                                        //     ),
                                                                        //   ),
                                                                        // );
                                                                        // Fluttertoast.showToast(
                                                                        //     msg:
                                                                        //         "Pembayaran hanya melalui Transfer Bank Mandiri",
                                                                        //     toastLength: Toast
                                                                        //         .LENGTH_SHORT,
                                                                        //     gravity: ToastGravity
                                                                        //         .BOTTOM,
                                                                        //     timeInSecForIosWeb:
                                                                        //         1,
                                                                        //     backgroundColor:
                                                                        //         primaryColor.withOpacity(0.5),
                                                                        //     textColor: Colors.white,
                                                                        //     fontSize: 16.0);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.35,
                                                                        height:
                                                                            33,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            color: secondaryColor),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "Pilih",
                                                                            style: GoogleFonts.inter(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox();
                                            }),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 36,
                                    ),
                                    //  Padding(
                                    //   padding: const EdgeInsets.fromLTRB(
                                    //       20, 10, 20, 0),
                                    //   child: Align(
                                    //     alignment: Alignment.topLeft,
                                    //     child: Text(
                                    //       "Telah Habis",
                                    //       style: GoogleFonts.notoSansDisplay(
                                    //           fontSize: 19,
                                    //           color: Color.fromARGB(255, 196, 88, 86),
                                    //           fontWeight: FontWeight.w600),
                                    //     ),
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 10, 0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Telah Habis",
                                                style:
                                                    GoogleFonts.notoSansDisplay(
                                                        fontSize: 12,
                                                        color: descColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Divider(
                                            thickness: 1,
                                            color: Colors.grey.shade200,
                                          )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      child: MediaQuery.removePadding(
                                        removeBottom: true,
                                        removeTop: true,
                                        context: context,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            controller: _scrollController,
                                            itemCount:
                                                ticketCon.ticketData?.length,
                                            itemBuilder: (context, index) {
                                              return ticketCon
                                                          .ticketData![index]
                                                          .stock ==
                                                      0
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          20, 0, 20, 15),
                                                      child: Container(
                                                        // height: 150,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            199,
                                                                            199,
                                                                            199)
                                                                    .withOpacity(
                                                                        0.8),
                                                                spreadRadius: 2,
                                                                blurRadius: 4,
                                                                offset: const Offset(
                                                                    0,
                                                                    2), // changes position of shadow
                                                              ),
                                                            ],
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  15,
                                                                  18.0,
                                                                  15,
                                                                  15),
                                                          child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      ticketCon
                                                                          .ticketData![
                                                                              index]
                                                                          .nameTicket
                                                                          .toString(),
                                                                      style: GoogleFonts.inter(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              captColor,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    Text(
                                                                      "Harga Tiket",
                                                                      style: GoogleFonts.openSans(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              captColor,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      widget.id.openHour !=
                                                                              null
                                                                          ? "${widget.id.openHour.toString()} - ${widget.id.closedHour.toString()}"
                                                                          : "",
                                                                      style: GoogleFonts.openSans(
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              captColor,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Text(
                                                                          "Rp ${ticketCon.ticketData![index].price.toString()}",
                                                                          style: GoogleFonts.openSans(
                                                                              fontSize: 19,
                                                                              color: Color.fromARGB(106, 255, 168, 38),
                                                                              fontWeight: FontWeight.w700),
                                                                        ),
                                                                        Text(
                                                                          "/pax",
                                                                          style: GoogleFonts.openSans(
                                                                              fontSize: 12,
                                                                              color: captColor,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    // DottedLine(
                                                                    //   direction: Axis.vertical,

                                                                    // )
                                                                    // Flex(
                                                                    //   direction: Axis.vertical,
                                                                    //   children:[
                                                                    //    const MySeparator(color: Colors.grey,)
                                                                    //   ] )
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 5.0),
                                                                  child: Row(
                                                                    children: List.generate(
                                                                        150 ~/ 3,
                                                                        (index) => Expanded(
                                                                              child: Container(
                                                                                color: index % 2 == 0 ? Colors.grey.shade300 : Colors.transparent,
                                                                                height: 1,
                                                                              ),
                                                                            )),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Color.fromARGB(
                                                                                106,
                                                                                255,
                                                                                168,
                                                                                38),
                                                                            borderRadius:
                                                                                BorderRadius.circular(10)),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              20,
                                                                              2.0,
                                                                              20,
                                                                              2),
                                                                          child:
                                                                              Text(
                                                                            "Tiket ${index + 1}",
                                                                            style: GoogleFonts.openSans(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "${ticketCon.ticketData![index].ticketSold} Terjual",
                                                                        style: GoogleFonts.openSans(
                                                                            fontSize:
                                                                                8,
                                                                            color:
                                                                                captColor,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                // ticketCon
                                                                //             .ticketData![
                                                                //                 index]
                                                                //             .stock! <
                                                                //         5
                                                                //     ? Padding(
                                                                //         padding:
                                                                //             const EdgeInsets
                                                                //                     .only(
                                                                //                 right:
                                                                //                     2.0,
                                                                //                 bottom:
                                                                //                     4),
                                                                //         child: Align(
                                                                //           alignment:
                                                                //               Alignment
                                                                //                   .topRight,
                                                                //           child: Text(
                                                                //             "${ticketCon.ticketData![index].stock} Tiket tersisa!",
                                                                //             style: GoogleFonts.inter(
                                                                //                 fontSize:
                                                                //                     10,
                                                                //                 color: Color.fromARGB(
                                                                //                     255,
                                                                //                     236,
                                                                //                     85,
                                                                //                     82),
                                                                //                 fontWeight:
                                                                //                     FontWeight
                                                                //                         .w600),
                                                                //           ),
                                                                //         ),
                                                                //       )
                                                                //     : SizedBox(),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.25,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              FaIcon(
                                                                                FontAwesomeIcons.textSlash,
                                                                                size: 10,
                                                                                color: captColor,
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 3.0),
                                                                                child: Text(
                                                                                  "Ubah pengunjung",
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: GoogleFonts.openSans(fontSize: 9, color: captColor, fontWeight: FontWeight.w500),
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
                                                                                padding: const EdgeInsets.only(left: 5.0),
                                                                                child: Text(
                                                                                  "Dibatalkan",
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: GoogleFonts.openSans(fontSize: 9, color: captColor, fontWeight: FontWeight.w500),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                "Mohon menunggu penyedia wisata menambahkan stok tiket",
                                                                            toastLength: Toast
                                                                                .LENGTH_SHORT,
                                                                            gravity: ToastGravity
                                                                                .BOTTOM,
                                                                            timeInSecForIosWeb:
                                                                                1,
                                                                            backgroundColor:
                                                                                Colors.red[300],
                                                                            textColor: Colors.white,
                                                                            fontSize: 16.0);
                                                                        //       Navigator.push(
                                                                        //   context,
                                                                        //   MaterialPageRoute(
                                                                        //     builder: (context) =>
                                                                        //          CreateOrderDetail(
                                                                        //           idDestinasi: widget.id,
                                                                        //           idTicket: ticketCon.ticketData![index],
                                                                        //           ),
                                                                        //   ),
                                                                        // );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.35,
                                                                        height:
                                                                            33,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            color: captColor),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "Pesan",
                                                                            style: GoogleFonts.inter(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox();
                                            }),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ]),
                                )
                              ],
                            )
                          ],
                        ),
                      ]);
                }),
              ),
            ),
    );
  }
}
