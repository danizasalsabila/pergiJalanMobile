import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/destinasi_controller.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/home.dart';
import 'package:provider/provider.dart';

import '../../../controllers/user_controller.dart';

class CreateDestinationTourist extends StatefulWidget {
  const CreateDestinationTourist({super.key});

  @override
  State<CreateDestinationTourist> createState() =>
      _CreateDestinationTouristState();
}

class _CreateDestinationTouristState extends State<CreateDestinationTourist> {
  bool isSelected = false;
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController openHourController = TextEditingController();
  TextEditingController closedHourController = TextEditingController();
  TextEditingController minutesSpendController = TextEditingController();
  TextEditingController urlMapController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  TextEditingController fasilitiesController = TextEditingController();
  TextEditingController ticketStockController = TextEditingController();
  TextEditingController ticketPriceController = TextEditingController();
  List<bool> _isSecurityAvail = [true, false];
  int securityAvail = 0;
  // double latitudeValue= 0;
  // double longitudeValue=0;
  // int openHourValue=0;
  // int closedHourValue=0;

  final List<String> _listCategory = [
    "Cagar Alam",
    "Budaya",
    "Taman Hiburan",
    "Bahari",
    "Taman Ibadah",
  ];
  String? finalSelectedCategory;
  int? _selectedListCategory;
  _onSelectedListCategory(int i) {
    setState(() {
      _selectedListCategory = i;
    });
  }

  final List<String> _listWeather = [
    "Cerah",
    "Berawan",
    "Hujan",
    "Kabut",
  ];
  int? _selectedListWeather;
  String? finalSelectedWeather;
  _onSelectedListWeather(int i) {
    setState(() {
      _selectedListWeather = i;
      _listWeather[i];
      finalSelectedWeather = _listWeather[i];
    });
  }

  final List<String> _listHobby = [
    "Olahraga",
    "Seni",
    "Petualangan",
    "Fotografi",
    "Sejarah",
    "Alam",
  ];
  int? _selectedListHobby;
  _onSelectedListHobby(int i) {
    setState(() {
      _selectedListHobby = i;
    });
  }

  String? finalSelectedHobby;

  List<String> listProvince = [
    "Aceh",
    "Sumatera Utara",
    "Sumatera Selatan",
    "Sumatera Barat",
    "Bengkulu",
    "Riau",
    "Kepulauan Riau",
    "Jambi",
    "Lampung",
    "Bangka Belitung",
    "Kalimantan Barat",
    "Kalimantan Timur",
    "Kalimantan Tengah",
    "Kalimantan Selatan",
    "Kalimantan Utara",
    "Banten",
    "DKI Jakarta",
    "Jawa Barat",
    "Jawa Timur",
    "Jawa Tengah",
    "DI Yogyakarta",
    "Bali",
    "Nusa Tenggara Timur",
    "Nusa Tenggara Barat",
    "Gorontalo",
    "Sulawesi Barat",
    "Sulawesi Tengah",
    "Sulawesi Utara",
    "Sulawesi Selatan",
    "Sulawesi Tenggara",
    "Maluku Utara",
    "Maluku",
    "Papua Barat",
    "Papua Tengah",
    "Papua Selatan",
    "Papua",
    "Papua Pegunungan",
    "Papua Barat Daya",
  ];
  var seen = Set<String>();
  // List<String> uniquelist = listProvince.where((province) => seen.add(province)).toList();
  String? finalSelectedProvince;
  // int? _selectedListProvince;
  // _onSelectedListProvince(int i) {
  //   setState(() {
  //     _selectedListProvince = i;
  //   });
  // }

  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO CREATE NEW DESTINATION PAGE-----------");
    _isSecurityAvail = [true, false];
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    openHourController.dispose();
    closedHourController.dispose();
    minutesSpendController.dispose();
    urlMapController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    fasilitiesController.dispose();
    ticketStockController.dispose();
    ticketPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          "Tambahkan Wisata Baru",
          style: GoogleFonts.openSans(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail Tempat Wisata",
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0, bottom: 6),
                      child: Text(
                        "Nama",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey.shade200,
                          )),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: TextField(
                          controller: nameController,
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: titleColor,
                              fontWeight: FontWeight.w600),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Masukkan Nama Tempat Wisata Anda',
                            // labelStyle: TextStyle(fontWeight: FontWeight.w300),
                            hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 6),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0, bottom: 6),
                      child: Text(
                        "Nomor Telepon",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey.shade200,
                          )),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: TextField(
                          controller: phoneNumberController,
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: titleColor,
                              fontWeight: FontWeight.w600),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Masukkan Kontak Tempat Wisata Anda',
                            // labelStyle: TextStyle(fontWeight: FontWeight.w300),
                            hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 6),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0, bottom: 6),
                      child: Text(
                        "Foto",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(5),
                          dashPattern: const [6, 3, 6, 3],
                          color: Colors.grey.shade200,
                          strokeWidth: 2,
                          child: Center(
                            child: RichText(
                              text: TextSpan(text: '', children: [
                                TextSpan(
                                  text: 'Tambahkan ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                  text: 'Foto Tempat Wisata  ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                  text: 'Anda ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 15, 16, 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text("Detail Tempat Wisata"),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 5),
                      child: Text(
                        "Deskripsi",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey.shade200,
                          )),
                      width: MediaQuery.of(context).size.width,
                      height: 110,
                      child: TextField(
                        maxLines: 5,
                        controller: descriptionController,
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: titleColor,
                            fontWeight: FontWeight.w600),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          // hintText: 'Masukkan Deskripsi Tempat Wisata',
                          // // hintTextDirection: TextDirection.rtl,
                          // hintStyle: TextStyle(color: Colors.grey.shade400,),

                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 6, top: 6),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Kategori",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 42,
                      child: ListView.builder(
                        shrinkWrap: true,
                        // physics: Bounc,
                        scrollDirection: Axis.horizontal,
                        itemCount: _listCategory.length,
                        itemBuilder: (context, index) => SizedBox(
                          // height: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: _selectedListCategory != null &&
                                        _selectedListCategory == index
                                    ? const Color.fromARGB(255, 223, 245, 214)
                                    : Colors.grey.shade300,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 13,
                                  right: 13,
                                ),
                                child: SizedBox(
                                  child: InkWell(
                                    onTap: () {
                                      _onSelectedListCategory(index);
                                      finalSelectedCategory =
                                          _listCategory[index];
                                    },
                                    child: Center(
                                      child: Text(
                                        _listCategory[index],
                                        style: GoogleFonts.openSans(
                                            fontSize: 13,
                                            color: titleColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 6),
                      child: Text(
                        "Alamat Lengkap",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey.shade200,
                          )),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: addressController,
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: titleColor,
                            fontWeight: FontWeight.w600),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          //   hintText: 'Nomor Handphone',
                          //   hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 6),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade200, width: 2),
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(148, 1, 141, 159)),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.solidLightbulb,
                                    size: 15,
                                    color: primaryColor,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    "Tips: Beri alamat lengkap agar wisatamu mudah ditemukan",
                                    style: GoogleFonts.inter(
                                        fontSize: 10,
                                        color: titleColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0, bottom: 6),
                      child: Text(
                        "Provinsi",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 50,
                      // width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.grey.shade200, width: 2)),
                      child: Container(
                        child: DropdownButton(
                          isExpanded: true,
                          menuMaxHeight: 300,
                          underline: const SizedBox(),
                          elevation: 0,
                          value: finalSelectedProvince,
                          icon: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 2,
                                color: Colors.grey.shade200,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  size: 28,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Pilih provinsi tempat wisata Anda',
                              style: GoogleFonts.openSans(
                                  fontSize: 11,
                                  color: descColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          items: [
                            'Aceh',
                            'Sumatera Utara',
                            'Sumatera Selatan',
                            'Sumatera Barat',
                            'Bengkulu',
                            'Riau',
                            'Kepulauan Riau',
                            'Jambi',
                            'Lampung',
                            'Bangka Belitung',
                            'Kalimantan Barat',
                            'Kalimantan Timur',
                            'Kalimantan Tengah',
                            'Kalimantan Selatan',
                            'Kalimantan Utara',
                            'Banten',
                            'DKI Jakarta',
                            'Jawa Barat',
                            'Jawa Timur',
                            'Jawa Tengah',
                            'DI Yogyakarta',
                            'Bali',
                            'Nusa Tenggara Timur',
                            'Nusa Tenggara Barat',
                            'Gorontalo',
                            'Sulawesi Barat',
                            'Sulawesi Tengah',
                            'Sulawesi Utara',
                            'Sulawesi Selatan',
                            'Sulawesi Tenggara',
                            'Maluku Utara',
                            'Maluku',
                            'Papua Barat',
                            'Papua Tengah',
                            'Papua Selatan',
                            'Papua',
                            'Papua Pegunungan',
                            'Papua Barat Daya',
                          ].map<DropdownMenuItem>((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  value,
                                  style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      color: titleColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            );
                          }).toList(),
                          dropdownColor: Colors.grey.shade100,
                          onChanged: (newValue) {
                            setState(() {
                              finalSelectedProvince = newValue.toString();
                              // print("final: $finalSelectedProvince");
                            });
                          },
                        ),
                      ),
                    ),
                    // Container(
                    //   height: 50,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(5),
                    //       border: Border.all(
                    //         width: 2,
                    //         color: Colors.grey.shade200,
                    //       )),
                    //   width: MediaQuery.of(context).size.width,
                    //   child: TextField(
                    //     style: GoogleFonts.openSans(
                    //         fontSize: 14,
                    //         color: titleColor,
                    //         fontWeight: FontWeight.w600),
                    //     keyboardType: TextInputType.text,
                    //     textInputAction: TextInputAction.next,
                    //     decoration: InputDecoration(
                    //       //   hintText: 'Nomor Handphone',
                    //       //   hintStyle: TextStyle(color: Colors.grey.shade500),

                    //       border: InputBorder.none,
                    //       contentPadding: EdgeInsets.only(left: 6),
                    //     ),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 14.0, bottom: 6),
                              child: Text(
                                "Jam Buka",
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey.shade200,
                                  )),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                controller: openHourController,
                                style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: titleColor,
                                    fontWeight: FontWeight.w600),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  //   hintText: 'Nomor Handphone',
                                  //   hintStyle: TextStyle(color: Colors.grey.shade500),

                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 6),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 14.0, bottom: 6),
                              child: Text(
                                "Jam Tutup",
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey.shade200,
                                  )),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                controller: closedHourController,
                                style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: titleColor,
                                    fontWeight: FontWeight.w600),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  //   hintText: 'Nomor Handphone',
                                  //   hintStyle: TextStyle(color: Colors.grey.shade500),

                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                      child: Text(
                        "Berikan Rekomendasi",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      "Sediakan pilihan rekomendasi berbagai kenyamanan bagi wisatawan yang cocok sesuai dengan preferensi tempat wisatamu",
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400),
                      maxLines: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0, bottom: 6),
                      child: Text(
                        "Cuaca",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _onSelectedListWeather(0);
                          },
                          child: Container(
                            height: 90,
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                              color: _selectedListWeather != null &&
                                      _selectedListWeather == 0
                                  ? Color.fromARGB(255, 223, 245, 214)
                                  : Colors.white,
                              border: Border.all(
                                  color: _selectedListWeather != null &&
                                          _selectedListWeather == 0
                                      ? labelColorBack
                                      : Colors.grey.shade200,
                                  width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.cloudSun,
                                  size: 30,
                                  color: _selectedListWeather != null &&
                                          _selectedListWeather == 0
                                      ? Colors.amber
                                      : Color.fromARGB(255, 182, 166, 118),
                                ),
                                Text(
                                  _listWeather[0],
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _onSelectedListWeather(1);
                          },
                          child: Container(
                            height: 90,
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                              color: _selectedListWeather != null &&
                                      _selectedListWeather == 1
                                  ? Color.fromARGB(255, 223, 245, 214)
                                  : Colors.white,
                              border: Border.all(
                                  color: _selectedListWeather != null &&
                                          _selectedListWeather == 1
                                      ? labelColorBack
                                      : Colors.grey.shade200,
                                  width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.cloud,
                                  color: _selectedListWeather != null &&
                                          _selectedListWeather == 1
                                      ? Color.fromARGB(255, 70, 151, 192)
                                      : Color.fromARGB(255, 137, 171, 189),
                                  size: 30,
                                ),
                                Text(
                                  _listWeather[1],
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _onSelectedListWeather(2);
                          },
                          child: Container(
                            height: 90,
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                              color: _selectedListWeather != null &&
                                      _selectedListWeather == 2
                                  ? Color.fromARGB(255, 223, 245, 214)
                                  : Colors.white,
                              border: Border.all(
                                  color: _selectedListWeather != null &&
                                          _selectedListWeather == 2
                                      ? labelColorBack
                                      : Colors.grey.shade200,
                                  width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FaIcon(FontAwesomeIcons.cloudShowersHeavy,
                                    size: 30,
                                    color: _selectedListWeather != null &&
                                            _selectedListWeather == 2
                                        ? Color.fromARGB(255, 0, 232, 248)
                                        : Color.fromARGB(255, 155, 217, 236)),
                                Text(
                                  _listWeather[2],
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _onSelectedListWeather(3);
                          },
                          child: Container(
                            height: 90,
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                              color: _selectedListWeather != null &&
                                      _selectedListWeather == 3
                                  ? Color.fromARGB(255, 223, 245, 214)
                                  : Colors.white,
                              border: Border.all(
                                  color: _selectedListWeather != null &&
                                          _selectedListWeather == 3
                                      ? labelColorBack
                                      : Colors.grey.shade200,
                                  width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.smog,
                                  size: 30,
                                  color: _selectedListWeather != null &&
                                          _selectedListWeather == 3
                                      ? Colors.blueGrey
                                      : Colors.grey,
                                ),
                                Text(
                                  _listWeather[3],
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0, bottom: 6),
                      child: Text(
                        "Durasi Waktu",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey.shade200,
                          )),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: minutesSpendController,
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: titleColor,
                            fontWeight: FontWeight.w600),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          //   hintText: 'Nomor Handphone',
                          //   hintStyle: TextStyle(color: Colors.grey.shade500),

                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 6),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0, bottom: 6),
                      child: Text(
                        "Hobi",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                _onSelectedListHobby(0);
                                setState(() {
                                  finalSelectedHobby = _listHobby[0];
                                });
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        child: FaIcon(
                                          FontAwesomeIcons.volleyball,
                                          size: 17,
                                          color: _selectedListHobby != null &&
                                                  _selectedListHobby == 0
                                              ? labelColorBack
                                              : Colors.grey.shade400,
                                        )),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: _selectedListHobby != null &&
                                                _selectedListHobby == 0
                                            ? Color.fromARGB(255, 223, 245, 214)
                                            : Colors.grey.shade300,
                                      ),
                                      child: Center(
                                          child: Text(
                                        _listHobby[0],
                                        style: GoogleFonts.openSans(
                                            fontSize: 13,
                                            color: titleColor,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _onSelectedListHobby(1);

                                setState(() {
                                  finalSelectedHobby = _listHobby[1];
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 6.0, bottom: 6.0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.07,
                                          child: FaIcon(
                                              FontAwesomeIcons.paintBrush,
                                              size: 17,
                                              color: _selectedListHobby !=
                                                          null &&
                                                      _selectedListHobby == 1
                                                  ? labelColorBack
                                                  : Colors.grey.shade400)),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: _selectedListHobby != null &&
                                                  _selectedListHobby == 1
                                              ? Color.fromARGB(
                                                  255, 223, 245, 214)
                                              : Colors.grey.shade300,
                                        ),
                                        child: Center(
                                            child: Text(
                                          _listHobby[1],
                                          style: GoogleFonts.openSans(
                                              fontSize: 13,
                                              color: titleColor,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _onSelectedListHobby(2);

                                setState(() {
                                  finalSelectedHobby = _listHobby[2];
                                });
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        child: FaIcon(
                                            FontAwesomeIcons.personHiking,
                                            size: 17,
                                            color: _selectedListHobby != null &&
                                                    _selectedListHobby == 2
                                                ? labelColorBack
                                                : Colors.grey.shade400)),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: _selectedListHobby != null &&
                                                _selectedListHobby == 2
                                            ? Color.fromARGB(255, 223, 245, 214)
                                            : Colors.grey.shade300,
                                      ),
                                      child: Center(
                                          child: Text(
                                        _listHobby[2],
                                        style: GoogleFonts.openSans(
                                            fontSize: 13,
                                            color: titleColor,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                _onSelectedListHobby(3);

                                setState(() {
                                  finalSelectedHobby = _listHobby[3];
                                });
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        child: FaIcon(
                                            FontAwesomeIcons.cameraRetro,
                                            size: 17,
                                            color: _selectedListHobby != null &&
                                                    _selectedListHobby == 3
                                                ? labelColorBack
                                                : Colors.grey.shade400)),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: _selectedListHobby != null &&
                                                _selectedListHobby == 3
                                            ? Color.fromARGB(255, 223, 245, 214)
                                            : Colors.grey.shade300,
                                      ),
                                      child: Center(
                                          child: Text(
                                        _listHobby[3],
                                        style: GoogleFonts.openSans(
                                            fontSize: 13,
                                            color: titleColor,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _onSelectedListHobby(4);

                                setState(() {
                                  finalSelectedHobby = _listHobby[4];
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 6.0, bottom: 6.0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.07,
                                          child: FaIcon(
                                              FontAwesomeIcons.landmark,
                                              size: 17,
                                              color: _selectedListHobby !=
                                                          null &&
                                                      _selectedListHobby == 4
                                                  ? labelColorBack
                                                  : Colors.grey.shade400)),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: _selectedListHobby != null &&
                                                  _selectedListHobby == 4
                                              ? Color.fromARGB(
                                                  255, 223, 245, 214)
                                              : Colors.grey.shade300,
                                        ),
                                        child: Center(
                                            child: Text(
                                          _listHobby[4],
                                          style: GoogleFonts.openSans(
                                              fontSize: 13,
                                              color: titleColor,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _onSelectedListHobby(5);

                                setState(() {
                                  finalSelectedHobby = _listHobby[5];
                                });
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        child: FaIcon(FontAwesomeIcons.tree,
                                            size: 17,
                                            color: _selectedListHobby != null &&
                                                    _selectedListHobby == 5
                                                ? labelColorBack
                                                : Colors.grey.shade400)),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: _selectedListHobby != null &&
                                                _selectedListHobby == 5
                                            ? Color.fromARGB(255, 223, 245, 214)
                                            : Colors.grey.shade300,
                                      ),
                                      child: Center(
                                          child: Text(
                                        _listHobby[5],

                                        // onChanged: ((value) {"Alam"; print(value);}),
                                        style: GoogleFonts.openSans(
                                            fontSize: 13,
                                            color: titleColor,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                      child: Text(
                        "Google Map",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        "Jika tersedia berikan linke google map tempat wisata anda",
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w400),
                        maxLines: 5,
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey.shade200,
                          )),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: urlMapController,
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: titleColor,
                            fontWeight: FontWeight.w600),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          //   hintText: 'Nomor Handphone',
                          //   hintStyle: TextStyle(color: Colors.grey.shade500),

                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 6),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 14.0, bottom: 6),
                              child: Text(
                                "Latitude",
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey.shade200,
                                  )),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                controller: latitudeController,
                                style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: titleColor,
                                    fontWeight: FontWeight.w600),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: '-6.1750',
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color: descColor,
                                      fontWeight: FontWeight.w500),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 6),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 14.0, bottom: 6),
                              child: Text(
                                "Longitude",
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey.shade200,
                                  )),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                controller: longitudeController,
                                style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: titleColor,
                                    fontWeight: FontWeight.w600),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: '106.8283',
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color: descColor,
                                      fontWeight: FontWeight.w500),
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.only(left: 6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                      child: Text(
                        "Fasilitas",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey.shade200,
                          )),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: fasilitiesController,
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: titleColor,
                            fontWeight: FontWeight.w600),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          //   hintText: 'Nomor Handphone',
                          //   hintStyle: TextStyle(color: Colors.grey.shade500),

                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 6),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                              child: FaIcon(
                                FontAwesomeIcons.starOfLife,
                                color: primaryColor,
                                size: 10,
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                                "Isi beberapa fasilitas umum yang tersedia di lokasi tempat wisatamu dan pisahkan dengan koma ','",
                                style: GoogleFonts.openSans(
                                    fontSize: 11,
                                    color: titleColor,
                                    fontWeight: FontWeight.w400),
                                maxLines: 3),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade200, width: 2),
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: ToggleButtons(
                                borderRadius: BorderRadius.circular(40),
                                isSelected: _isSecurityAvail,
                                fillColor: labelColorBack,
                                selectedColor: Colors.grey.shade800,
                                borderColor: Colors.white,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Center(
                                          child: Text(
                                        'Tidak Tersedia\nPetugas Keamanan',
                                        style: GoogleFonts.inter(
                                            fontSize: 10,
                                            // color: titleColor,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Center(
                                          child: Text(
                                        'Tersedia\nPetugas Keamanan',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                            fontSize: 10,
                                            // color: titleColor,
                                            fontWeight: FontWeight.w500),
                                      )),
                                    ),
                                  ),
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    for (int i = 0;
                                        i < _isSecurityAvail.length;
                                        i++) {
                                      _isSecurityAvail[i] = i == index;
                                    }
                                    if (index == 0) {
                                      securityAvail = 0;
                                    } else if (index == 1) {
                                      securityAvail = 1;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                      child: Text(
                        "Tambahkan Ketersediaan Tiket",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 2,
                                color: Colors.grey.shade200,
                              )),
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextField(
                            controller: ticketStockController,
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: titleColor,
                                fontWeight: FontWeight.w600),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Stok',
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 6, bottom: 6),
                            ),
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
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextField(
                            controller: ticketPriceController,
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: titleColor,
                                fontWeight: FontWeight.w600),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Harga',
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.only(left: 6, bottom: 6),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const HomePageOwner()),
                    //     (route) => false);
                  },
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Center(
                          child: Text(
                        "Batal",
                        style: GoogleFonts.openSans(
                            fontSize: 13,
                            color: titleColor,
                            fontWeight: FontWeight.w700),
                      ))),
                ),
                InkWell(
                  onTap: () async {
                    final destCon = Provider.of<DestinasiController>(context,
                        listen: false);

                    if (nameController.text.isEmpty &&
                        descriptionController.text.isEmpty &&
                        addressController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Data tidak boleh kosong",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red[300],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    // else if(finalSelectedProvince == '' && finalSelectedHobby == ''){
                    //      Fluttertoast.showToast(
                    //       msg: "Provinsi tempat wisata",
                    //       toastLength: Toast.LENGTH_SHORT,
                    //       gravity: ToastGravity.BOTTOM,
                    //       timeInSecForIosWeb: 1,
                    //       backgroundColor: Colors.red[300],
                    //       textColor: Colors.white,
                    //       fontSize: 16.0);
                    //   return;

                    // }

                    else if (nameController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Nama tempat wisata belum diisi",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red[300],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    } else if (descriptionController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Deskripsi tempat wisata belum diisi",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red[300],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    } else if (addressController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Alamat tempat wisata belum diisi",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red[300],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    } else if (finalSelectedCategory == null) {
                      Fluttertoast.showToast(
                          msg: "Kategori tempat wisata belum diisi",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red[300],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    } else if (finalSelectedProvince == null) {
                      Fluttertoast.showToast(
                          msg: "Provinsi tempat wisata belum diisi",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red[300],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    setState(() {
                      isLoading = true;
                    });

                    double? latitudeValue = latitudeController.text.isNotEmpty
                        ? double.parse(latitudeController.text)
                        : null;

                    double? longitudeValue = longitudeController.text.isNotEmpty
                        ? double.parse(longitudeController.text)
                        : null;

                    // int openHourValue;
                    // if (openHourController.text.isNotEmpty) {
                    //   openHourValue = int.parse(openHourController.text);
                    // } else {
                    //   openHourValue = 0;
                    // }

                    // int closedHourValue;
                    // if (closedHourController.text.isNotEmpty) {
                    //   closedHourValue = int.parse(closedHourController.text);
                    // } else {
                    //   closedHourValue = 0;
                    // }
                    try {
                      await destCon.postDestinasi(
                          nameDestinasi: nameController.text,
                          description: descriptionController.text,
                          address: addressController.text,
                          city: finalSelectedProvince.toString(),
                          category: finalSelectedCategory.toString(),
                          contact: phoneNumberController.text,
                          hobby: finalSelectedHobby,
                          minutesSpend: minutesSpendController.text,
                          latitude: latitudeValue,
                          longitude: longitudeValue,
                          // latitude: -6.0000,
                          // longitude: 104.2020,
                          urlMap: urlMapController.text,
                          recWeather: finalSelectedWeather,
                          // openHour: 1,
                          // closedHour: 1,
                          openHour: openHourController.text,
                          closedHour: closedHourController.text,
                          fasility: fasilitiesController.text,
                          security: securityAvail
                          // image:
                          // openHour: openHourController.text
                          // closedHour: closedHourController.text
                          );
                      if (destCon.statusCodeAddDestinasi == 200) {
                        setState(() {
                          isLoading = false;
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePageOwner()),
                            (route) => false);
                        Fluttertoast.showToast(
                            msg: "Tempat wisatamu telah ditambahkan!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: primaryColor.withOpacity(0.6),
                            textColor: Colors.white,
                            fontSize: 13);
                      } else if (destCon.statusCodeAddDestinasi == 404) {
                        setState(() {
                          isLoading = false;
                        });
                        Fluttertoast.showToast(
                            msg: destCon.messageAddDestinasi.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red[300],
                            textColor: Colors.white,
                            fontSize: 16.0);
                        return;
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        Fluttertoast.showToast(
                            msg: "Terjadi Error\nSilahkan Coba Lagi Nanti",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red[300],
                            textColor: Colors.white,
                            fontSize: 16.0);
                        return;
                      }
                    } catch (e) {
                      e;
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        "Simpan Tempat Wisata",
                        style: GoogleFonts.openSans(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ))),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
