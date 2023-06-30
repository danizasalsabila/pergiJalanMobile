// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/controllers/destinasi_controller.dart';
import 'package:pergijalan_mobile/views/pages/business_owner/home.dart';
import 'package:provider/provider.dart';

import '../../../controllers/ticket_controller.dart';
import '../../../models/destinasi.dart';

class EditDestinationOwnerPage extends StatefulWidget {
  final Destinasi id;

  const EditDestinationOwnerPage({super.key, required this.id});

  @override
  State<EditDestinationOwnerPage> createState() =>
      _EditDestinationOwnerPageState();
}

class _EditDestinationOwnerPageState extends State<EditDestinationOwnerPage> {
  // bool isSelected = false;
  bool isLoading = false;
  bool isLoading2 = false;
  bool isEdited = false;
  // bool isTicketEdited = false;
  bool isUpdating = false;
  int? stockValue;
  int? priceValue;
  TextEditingController? nameController;
  TextEditingController? phoneNumberController;
  TextEditingController? descriptionController;
  TextEditingController? addressController;
  TextEditingController? openHourController;
  TextEditingController? closedHourController;
  TextEditingController? minutesSpendController;
  TextEditingController? urlMapController;
  // TextEditingController? latitudeController;
  // TextEditingController? longitudeController;
  TextEditingController? fasilitiesController;
  // TextEditingController? ticketStockController;
  // TextEditingController? ticketPriceController;
  // int? _isSecurityAvail;
  int? securityAvail;
  _onSelectedListSecurity(value) {
    setState(() {
      securityAvail = value;
      if (widget.id.security != null) {
        isEdited = (value != widget.id.security) ? true : false;
      }
    });
  }

  File? image;
  final ImagePicker _picker = ImagePicker();
  String? imagePrev;
  Future getImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      isEdited = true;
      image = File(pickedFile.path);
      imagePrev = null;
      setState(() {});
    } else {
      const snackbar = SnackBar(content: Text('No image selected'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }


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
      isEdited = (_listCategory[i] != widget.id.category) ? true : false;
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
      finalSelectedWeather = _listWeather[i];
      if (widget.id.recWeather != null) {
        setState(() {
          isEdited =
              (finalSelectedWeather != widget.id.recWeather) ? true : false;
        });
      } else {
        isEdited = (finalSelectedWeather?.trim() != widget.id.recWeather)
            ? true
            : false;
      }
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
      if (widget.id.hobby != null) {
        setState(() {
          isEdited = (_listCategory[i] != widget.id.hobby) ? true : false;
        });
      } else {
        isEdited = (_listCategory[i].trim() != widget.id.hobby) ? true : false;
      }
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
  String? finalSelectedProvince;
  void initState() {
    print(" ");
    print("-------------DIRECT TO EDIT DESTINATION PAGE-----------");

    final destCon = Provider.of<DestinasiController>(context, listen: false);
    final ticketCon = Provider.of<TicketController>(context, listen: false);

    isLoading2 = true;
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      try {
        await ticketCon.getTicketbyIdDestination(widget.id.id);
      } catch (e) {
        e;
      }
      setState(() {
        isLoading2 = false;
      });
    });
    super.initState();
    nameController = TextEditingController(text: widget.id.nameDestinasi);
    phoneNumberController = TextEditingController(text: widget.id.contact);
    descriptionController = TextEditingController(text: widget.id.description);
    addressController = TextEditingController(text: widget.id.address);
    openHourController = TextEditingController(text: widget.id.openHour);
    closedHourController = TextEditingController(text: widget.id.closedHour);
    minutesSpendController =
        TextEditingController(text: widget.id.minutesSpend);
    urlMapController = TextEditingController(text: widget.id.urlMap);
    imagePrev = widget.id.destinationPicture;
    fasilitiesController = TextEditingController(text: widget.id.fasility);
    finalSelectedCategory = widget.id.category;
    finalSelectedWeather = widget.id.recWeather;
    finalSelectedProvince = widget.id.city;
    finalSelectedHobby = widget.id.hobby;
    securityAvail = widget.id.security;
  }

  @override
  void dispose() {
    nameController!.dispose();
    phoneNumberController!.dispose();
    descriptionController!.dispose();
    addressController!.dispose();
    openHourController!.dispose();
    closedHourController!.dispose();
    minutesSpendController!.dispose();
    urlMapController!.dispose();
    // latitudeController!.dispose();
    // longitudeController!.dispose();
    fasilitiesController!.dispose();
    // ticketStockController!.dispose();
    // ticketPriceController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editCon = Provider.of<DestinasiController>(context, listen: false);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          "Edit Tempat Wisata",
          style: GoogleFonts.openSans(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        automaticallyImplyLeading: false,
      ),
      body: isLoading2
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
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
                            padding:
                                const EdgeInsets.only(top: 14.0, bottom: 6),
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
                                onChanged: (text) {
                                  if (widget.id.nameDestinasi != null) {
                                    setState(() {
                                      isEdited =
                                          (text != widget.id.nameDestinasi)
                                              ? true
                                              : false;
                                    });
                                  } else {
                                    isEdited =
                                        (text.trim() != widget.id.nameDestinasi)
                                            ? true
                                            : false;
                                  }
                                },
                                style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: titleColor,
                                    fontWeight: FontWeight.w600),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w400),
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.only(left: 6),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 14.0, bottom: 6),
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
                                onChanged: (text) {
                                  if (widget.id.contact != null) {
                                    setState(() {
                                      isEdited = (text != widget.id.contact)
                                          ? true
                                          : false;
                                    });
                                  } else {
                                    isEdited =
                                        (text.trim() != widget.id.contact)
                                            ? true
                                            : false;
                                  }
                                },
                                controller: phoneNumberController,
                                style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: titleColor,
                                    fontWeight: FontWeight.w600),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  // hintText: 'Masukkan Kontak Tempat Wisata Anda',
                                  // labelStyle: TextStyle(fontWeight: FontWeight.w300),
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w400),
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.only(left: 6),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 14.0, bottom: 6),
                            child: Text(
                              "Foto",
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),

                          imagePrev != null
                              ? SizedBox(
                                  height: 90,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    imagePrev!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : SizedBox(),
                          image == null
                              ? SizedBox()
                              : SizedBox(
                                  height: 90,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () async {
                                await getImage();
                              },
                              child: SizedBox(
                                  height: 40,
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
                                              text: 'Ubah ',
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
                                      )))),
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
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
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
                              onChanged: (text) {
                                if (widget.id.description != null) {
                                  setState(() {
                                    isEdited = (text != widget.id.description)
                                        ? true
                                        : false;
                                  });
                                } else {
                                  isEdited =
                                      (text.trim() != widget.id.description)
                                          ? true
                                          : false;
                                }
                              },
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
                                contentPadding:
                                    EdgeInsets.only(left: 6, top: 6),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Kategori",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "${finalSelectedCategory.toString()} *",
                                  style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: Colors.red.shade600,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
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
                                          ? const Color.fromARGB(
                                              255, 223, 245, 214)
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
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 6),
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
                              onChanged: (text) {
                                if (widget.id.address != null) {
                                  setState(() {
                                    isEdited = (text != widget.id.address)
                                        ? true
                                        : false;
                                  });
                                } else {
                                  isEdited = (text.trim() != widget.id.address)
                                      ? true
                                      : false;
                                }
                              },
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
                                  color:
                                      const Color.fromARGB(148, 1, 141, 159)),
                              child: Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                            padding:
                                const EdgeInsets.only(top: 14.0, bottom: 6),
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
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
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
                                    widget.id.city.toString(),
                                    // "Aceh",
                                    style: GoogleFonts.openSans(
                                        fontSize: 12,
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
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
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

                                    if (widget.id.city != null) {
                                      setState(() {
                                        isEdited = (finalSelectedProvince !=
                                                widget.id.city)
                                            ? true
                                            : false;
                                      });
                                    } else {
                                      isEdited =
                                          (finalSelectedProvince?.trim() !=
                                                  widget.id.city)
                                              ? true
                                              : false;
                                    }
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
                                    padding: const EdgeInsets.only(
                                        top: 14.0, bottom: 6),
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: TextField(
                                      onChanged: (text) {
                                        if (widget.id.openHour != null) {
                                          setState(() {
                                            isEdited =
                                                (text != widget.id.openHour)
                                                    ? true
                                                    : false;
                                          });
                                        } else {
                                          isEdited = (text.trim() !=
                                                  widget.id.openHour)
                                              ? true
                                              : false;
                                        }
                                      },
                                      controller: openHourController,
                                      style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          color: titleColor,
                                          fontWeight: FontWeight.w600),
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        // hintText: openHourController == null ? '' : '',
                                        // hintStyle: TextStyle(color: Colors.grey.shade500),

                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(left: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0, bottom: 6),
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: TextField(
                                      onChanged: (text) {
                                        if (widget.id.closedHour != null) {
                                          setState(() {
                                            isEdited =
                                                (text != widget.id.closedHour)
                                                    ? true
                                                    : false;
                                          });
                                        } else {
                                          isEdited = (text.trim() !=
                                                  widget.id.closedHour)
                                              ? true
                                              : false;
                                        }
                                      },
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
                                        contentPadding:
                                            EdgeInsets.only(left: 6),
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
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
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
                            padding:
                                const EdgeInsets.only(top: 14.0, bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Cuaca",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "${finalSelectedWeather.toString()} *",
                                  style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: Colors.red.shade600,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.cloudSun,
                                        size: 30,
                                        color: _selectedListWeather != null &&
                                                _selectedListWeather == 0
                                            ? Colors.amber
                                            : Color.fromARGB(
                                                255, 182, 166, 118),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.cloud,
                                        color: _selectedListWeather != null &&
                                                _selectedListWeather == 1
                                            ? Color.fromARGB(255, 70, 151, 192)
                                            : Color.fromARGB(
                                                255, 137, 171, 189),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FaIcon(FontAwesomeIcons.cloudShowersHeavy,
                                          size: 30,
                                          color: _selectedListWeather != null &&
                                                  _selectedListWeather == 2
                                              ? Color.fromARGB(255, 0, 232, 248)
                                              : Color.fromARGB(
                                                  255, 155, 217, 236)),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                            padding:
                                const EdgeInsets.only(top: 14.0, bottom: 6),
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
                              onChanged: (text) {
                                if (widget.id.minutesSpend != null) {
                                  setState(() {
                                    isEdited = (text != widget.id.minutesSpend)
                                        ? true
                                        : false;
                                  });
                                } else {
                                  isEdited =
                                      (text.trim() != widget.id.minutesSpend)
                                          ? true
                                          : false;
                                }
                              },
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
                            padding:
                                const EdgeInsets.only(top: 14.0, bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Hobi",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "${finalSelectedHobby.toString()} *",
                                  style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: Colors.red.shade600,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
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
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
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
                                                FontAwesomeIcons.volleyball,
                                                size: 17,
                                                color: _selectedListHobby !=
                                                            null &&
                                                        _selectedListHobby == 0
                                                    ? labelColorBack
                                                    : Colors.grey.shade400,
                                              )),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: _selectedListHobby !=
                                                          null &&
                                                      _selectedListHobby == 0
                                                  ? Color.fromARGB(
                                                      255, 223, 245, 214)
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
                                            MediaQuery.of(context).size.width *
                                                0.4,
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
                                                            _selectedListHobby ==
                                                                1
                                                        ? labelColorBack
                                                        : Colors
                                                            .grey.shade400)),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: _selectedListHobby !=
                                                            null &&
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
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
                                                  FontAwesomeIcons.personHiking,
                                                  size: 17,
                                                  color: _selectedListHobby !=
                                                              null &&
                                                          _selectedListHobby ==
                                                              2
                                                      ? labelColorBack
                                                      : Colors.grey.shade400)),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: _selectedListHobby !=
                                                          null &&
                                                      _selectedListHobby == 2
                                                  ? Color.fromARGB(
                                                      255, 223, 245, 214)
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
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
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
                                                  FontAwesomeIcons.cameraRetro,
                                                  size: 17,
                                                  color: _selectedListHobby !=
                                                              null &&
                                                          _selectedListHobby ==
                                                              3
                                                      ? labelColorBack
                                                      : Colors.grey.shade400)),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: _selectedListHobby !=
                                                          null &&
                                                      _selectedListHobby == 3
                                                  ? Color.fromARGB(
                                                      255, 223, 245, 214)
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
                                            MediaQuery.of(context).size.width *
                                                0.4,
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
                                                            _selectedListHobby ==
                                                                4
                                                        ? labelColorBack
                                                        : Colors
                                                            .grey.shade400)),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: _selectedListHobby !=
                                                            null &&
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
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
                                                  FontAwesomeIcons.tree,
                                                  size: 17,
                                                  color: _selectedListHobby !=
                                                              null &&
                                                          _selectedListHobby ==
                                                              5
                                                      ? labelColorBack
                                                      : Colors.grey.shade400)),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: _selectedListHobby !=
                                                          null &&
                                                      _selectedListHobby == 5
                                                  ? Color.fromARGB(
                                                      255, 223, 245, 214)
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
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
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
                              onChanged: (text) {
                                if (widget.id.urlMap != null) {
                                  setState(() {
                                    isEdited = (text != widget.id.urlMap)
                                        ? true
                                        : false;
                                  });
                                } else {
                                  isEdited = (text.trim() != widget.id.urlMap)
                                      ? true
                                      : false;
                                }
                              },
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
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.only(
                          //               top: 14.0, bottom: 6),
                          //           child: Text(
                          //             "Latitude",
                          //             style: GoogleFonts.inter(
                          //                 fontSize: 14,
                          //                 color: Colors.black,
                          //                 fontWeight: FontWeight.w600),
                          //           ),
                          //         ),
                          //         Container(
                          //           height: 50,
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(5),
                          //               border: Border.all(
                          //                 width: 2,
                          //                 color: Colors.grey.shade200,
                          //               )),
                          //           width:
                          //               MediaQuery.of(context).size.width * 0.4,
                          //           child: TextField(
                          //             onChanged: (text) {
                          //               if (widget.id.latitude != null) {
                          //                 setState(() {
                          //                   isEdited =
                          //                       (text != widget.id.latitude)
                          //                           ? true
                          //                           : false;
                          //                 });
                          //               } else {
                          //                 isEdited = (text.trim() !=
                          //                         widget.id.latitude)
                          //                     ? true
                          //                     : false;
                          //               }
                          //             },
                          //             controller: latitudeController,
                          //             style: GoogleFonts.openSans(
                          //                 fontSize: 14,
                          //                 color: titleColor,
                          //                 fontWeight: FontWeight.w600),
                          //             keyboardType: TextInputType.number,
                          //             textInputAction: TextInputAction.next,
                          //             decoration: InputDecoration(
                          //               hintText: '-6.1750',
                          //               hintStyle: GoogleFonts.openSans(
                          //                   fontSize: 12,
                          //                   color: descColor,
                          //                   fontWeight: FontWeight.w500),
                          //               border: InputBorder.none,
                          //               contentPadding:
                          //                   EdgeInsets.only(left: 6),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.only(
                          //               top: 14.0, bottom: 6),
                          //           child: Text(
                          //             "Longitude",
                          //             style: GoogleFonts.inter(
                          //                 fontSize: 14,
                          //                 color: Colors.black,
                          //                 fontWeight: FontWeight.w600),
                          //           ),
                          //         ),
                          //         Container(
                          //           height: 50,
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(5),
                          //               border: Border.all(
                          //                 width: 2,
                          //                 color: Colors.grey.shade200,
                          //               )),
                          //           width:
                          //               MediaQuery.of(context).size.width * 0.4,
                          //           child: TextField(
                          //             onChanged: (text) {
                          //               if (widget.id.longitude != null) {
                          //                 setState(() {
                          //                   isEdited =
                          //                       (text != widget.id.longitude)
                          //                           ? true
                          //                           : false;
                          //                 });
                          //               } else {
                          //                 isEdited = (text.trim() !=
                          //                         widget.id.longitude)
                          //                     ? true
                          //                     : false;
                          //               }
                          //             },
                          //             controller: longitudeController,
                          //             style: GoogleFonts.openSans(
                          //                 fontSize: 14,
                          //                 color: titleColor,
                          //                 fontWeight: FontWeight.w600),
                          //             keyboardType: TextInputType.number,
                          //             textInputAction: TextInputAction.next,
                          //             decoration: InputDecoration(
                          //               hintText: '106.8283',
                          //               hintStyle: GoogleFonts.openSans(
                          //                   fontSize: 12,
                          //                   color: descColor,
                          //                   fontWeight: FontWeight.w500),
                          //               border: InputBorder.none,
                          //               contentPadding:
                          //                   const EdgeInsets.only(left: 6),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
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
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
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
                              onChanged: (text) {
                                if (widget.id.fasility != null) {
                                  setState(() {
                                    isEdited = (text != widget.id.fasility)
                                        ? true
                                        : false;
                                  });
                                } else {
                                  isEdited = (text.trim() != widget.id.fasility)
                                      ? true
                                      : false;
                                }
                              },
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
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                    child: FaIcon(
                                      FontAwesomeIcons.starOfLife,
                                      color: primaryColor,
                                      size: 10,
                                    )),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // borderRadius: BorderRadius.circular(40),
                                      // isSelected: _isSecurityAvail,
                                      // fillColor: labelColorBack,
                                      // selectedColor: Colors.grey.shade800,
                                      // borderColor: Colors.white,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            _onSelectedListSecurity(0);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: securityAvail == 0
                                                    ? labelColorBack
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 8.0),
                                              child: Center(
                                                  child: Text(
                                                'Tidak Tersedia\nPetugas Keamanan',
                                                style: GoogleFonts.inter(
                                                    fontSize: 10,
                                                    // color: titleColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              )),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _onSelectedListSecurity(1);
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: securityAvail == 1
                                                  ? labelColorBack
                                                  : Colors.white,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 8.0),
                                              child: Center(
                                                  child: Text(
                                                'Tersedia\nPetugas Keamanan',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                    fontSize: 10,
                                                    // color: titleColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
                                      // onPressed: (int index) {
                                      //   setState(() {
                                      //     if (widget.id.security != null) {
                                      //       isEdited = (index != widget.id.security)
                                      //           ? true
                                      //           : false;

                                      //       for (int i = 0;
                                      //           i < _isSecurityAvail.length;
                                      //           i++) {
                                      //         _isSecurityAvail[i] = i == index;
                                      //       }
                                      //       if (index == 0) {
                                      //         securityAvail = 0;
                                      //       } else if (index == 1) {
                                      //         securityAvail = 1;
                                      //       }
                                      //     }
                                      //   });
                                      // },
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
                // Padding(
                //   padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(5),
                //         color: Colors.white),
                //     child: Padding(
                //       padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                //             child: Text(
                //               "Tambahkan Ketersediaan Tiket",
                //               style: GoogleFonts.inter(
                //                   fontSize: 14,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w600),
                //             ),
                //           ),
                //           // Row(
                //           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           //   children: [
                //           //     Container(
                //           //       height: 45,
                //           //       decoration: BoxDecoration(
                //           //           borderRadius: BorderRadius.circular(5),
                //           //           border: Border.all(
                //           //             width: 2,
                //           //             color: Colors.grey.shade200,
                //           //           )),
                //           //       width: MediaQuery.of(context).size.width * 0.4,
                //           //       child: TextField(
                //           //         onChanged: (text) {
                //           //           final destCon =
                //           //               Provider.of<DestinasiController>(
                //           //                   context,
                //           //                   listen: false);
                //           //           if (destCon.ticketDataDetail!.stock !=
                //           //               null) {
                //           //             setState(() {
                //           //               isTicketEdited = (text !=
                //           //                       destCon.ticketDataDetail!.stock)
                //           //                   ? true
                //           //                   : false;
                //           //             });
                //           //           } else {
                //           //             isTicketEdited = (text.trim() !=
                //           //                     destCon.ticketDataDetail!.stock)
                //           //                 ? true
                //           //                 : false;
                //           //           }
                //           //         },
                //           //         controller: ticketStockController,
                //           //         style: GoogleFonts.openSans(
                //           //             fontSize: 14,
                //           //             color: titleColor,
                //           //             fontWeight: FontWeight.w600),
                //           //         keyboardType: TextInputType.number,
                //           //         textInputAction: TextInputAction.next,
                //           //         decoration: InputDecoration(
                //           //           hintText: 'Stok',
                //           //           hintStyle:
                //           //               TextStyle(color: Colors.grey.shade500),
                //           //           border: InputBorder.none,
                //           //           contentPadding:
                //           //               EdgeInsets.only(left: 6, bottom: 6),
                //           //         ),
                //           //       ),
                //           //     ),
                //           //     Container(
                //           //       height: 45,
                //           //       decoration: BoxDecoration(
                //           //           borderRadius: BorderRadius.circular(5),
                //           //           border: Border.all(
                //           //             width: 2,
                //           //             color: Colors.grey.shade200,
                //           //           )),
                //           //       width: MediaQuery.of(context).size.width * 0.4,
                //           //       child: TextField(
                //           //         onChanged: (text) {
                //           //           final destCon =
                //           //               Provider.of<DestinasiController>(
                //           //                   context,
                //           //                   listen: false);
                //           //           if (destCon.ticketDataDetail!.price !=
                //           //               null) {
                //           //             setState(() {
                //           //               isTicketEdited = (text !=
                //           //                       destCon.ticketDataDetail!.price)
                //           //                   ? true
                //           //                   : false;
                //           //             });
                //           //           } else {
                //           //             isTicketEdited = (text.trim() !=
                //           //                     destCon.ticketDataDetail!.price)
                //           //                 ? true
                //           //                 : false;
                //           //           }
                //           //         },
                //           //         controller: ticketPriceController,
                //           //         style: GoogleFonts.openSans(
                //           //             fontSize: 14,
                //           //             color: titleColor,
                //           //             fontWeight: FontWeight.w600),
                //           //         keyboardType: TextInputType.number,
                //           //         textInputAction: TextInputAction.next,
                //           //         decoration: InputDecoration(
                //           //           hintText: 'Harga',
                //           //           hintStyle:
                //           //               TextStyle(color: Colors.grey.shade500),
                //           //           border: InputBorder.none,
                //           //           contentPadding: const EdgeInsets.only(
                //           //               left: 6, bottom: 6),
                //           //         ),
                //           //       ),
                //           //     ),
                //           //   ],
                //           // )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 20,
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
                      isUpdating
                          ? SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Center(
                                  child: const CircularProgressIndicator()),
                            )
                          : isEdited
                              ? InkWell(
                                  onTap: () async {
                                    setState(() {
                                      isUpdating = true;
                                    });
                                    final destCon =
                                        Provider.of<DestinasiController>(
                                            context,
                                            listen: false);

                                    // double? latitudeValue = latitudeController!
                                    //         .text.isNotEmpty
                                    //     ? double.parse(latitudeController!.text)
                                    //     : null;

                                    // double? longitudeValue =
                                    //     longitudeController!.text.isNotEmpty
                                    //         ? double.parse(
                                    //             longitudeController!.text)
                                    //         : null;

                                    // priceValue =
                                    //     ticketPriceController!.text.isNotEmpty
                                    //         ? int.tryParse(
                                    //             ticketPriceController!.text)
                                    //         : null;

                                    // stockValue =
                                    //     ticketStockController!.text.isNotEmpty
                                    //         ? int.tryParse(
                                    //             ticketStockController!.text)
                                    //         : null;
                                    //a
                                    if (isEdited == true) {
                                      await destCon.editDestinasi(
                                          id: widget.id.id,
                                          nameDestinasi: nameController?.text,
                                          description:
                                              descriptionController?.text,
                                          address: addressController?.text,
                                          city:
                                              finalSelectedProvince.toString(),
                                          category: finalSelectedCategory,
                                          contact: phoneNumberController?.text,
                                          hobby: finalSelectedHobby,
                                          minutesSpend:
                                              minutesSpendController?.text,
                                          // latitude: latitudeValue,
                                          // longitude: longitudeValue,
                                          urlMap: urlMapController?.text,
                                          recWeather: finalSelectedWeather,
                                          fasility: fasilitiesController?.text,
                                          security: securityAvail,
                                          image: image,
                                          // imagePrev: imagePrev,
                                          openHour: openHourController?.text,
                                          closedHour:
                                              closedHourController?.text);
                                      if (destCon.statusCodeEditDestinasi ==
                                          200) {
                                        // if (ticketPriceController != null &&
                                        //     ticketStockController != null) {
                                        //   await destCon.editTicketByIdDestinasi(
                                        //     idDestinasi: widget.id.id,
                                        //     price: priceValue,
                                        //     stock: stockValue,
                                        //   );
                                        //   print(destCon.statusCodeAddTicket);
                                        // }
                                        setState(() {
                                          isUpdating = false;
                                        });
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePageOwner()),
                                            (route) => false);
                                        Fluttertoast.showToast(
                                            msg:
                                                "Tempat wisatamu telah diubah!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                primaryColor.withOpacity(0.6),
                                            textColor: Colors.white,
                                            fontSize: 13);
                                      } else if (destCon
                                              .statusCodeEditDestinasi ==
                                          404) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Fluttertoast.showToast(
                                            msg: destCon.messageEditDestinasi
                                                .toString(),
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
                                            msg:
                                                "Terjadi Error\nSilahkan Coba Lagi Nanti",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red[300],
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        return;
                                      }
                                    }
                                    // else if (isEdited == true) {
                                    //   print("ONLY DESTINASI");

                                    //   await destCon.editDestinasi(
                                    //       id: widget.id.id,
                                    //       nameDestinasi: nameController?.text,
                                    //       description:
                                    //           descriptionController?.text,
                                    //       address: addressController?.text,
                                    //       city:
                                    //           finalSelectedProvince.toString(),
                                    //       category: finalSelectedCategory,
                                    //       contact: phoneNumberController?.text,
                                    //       hobby: finalSelectedHobby,
                                    //       minutesSpend:
                                    //           minutesSpendController?.text,
                                    //       // latitude: latitudeValue,
                                    //       // longitude: longitudeValue,
                                    //       urlMap: urlMapController?.text,
                                    //       recWeather: finalSelectedWeather,
                                    //       fasility: fasilitiesController?.text,
                                    //       security: securityAvail,
                                    //       // image:
                                    //       openHour: openHourController?.text,
                                    //       closedHour:
                                    //           closedHourController?.text);
                                    //   if (destCon.statusCodeEditDestinasi ==
                                    //       200) {
                                    //     // ignore: use_build_context_synchronously
                                    //     Navigator.pushAndRemoveUntil(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 const HomePageOwner()),
                                    //         (route) => false);
                                    //     Fluttertoast.showToast(
                                    //         msg:
                                    //             "Tempat wisatamu telah diubah!",
                                    //         toastLength: Toast.LENGTH_SHORT,
                                    //         gravity: ToastGravity.BOTTOM,
                                    //         timeInSecForIosWeb: 1,
                                    //         backgroundColor:
                                    //             primaryColor.withOpacity(0.6),
                                    //         textColor: Colors.white,
                                    //         fontSize: 13);
                                    //   } else if (destCon
                                    //           .statusCodeEditDestinasi ==
                                    //       404) {
                                    //     setState(() {
                                    //       isLoading = false;
                                    //     });
                                    //     Fluttertoast.showToast(
                                    //         msg: destCon.messageEditDestinasi
                                    //             .toString(),
                                    //         toastLength: Toast.LENGTH_SHORT,
                                    //         gravity: ToastGravity.BOTTOM,
                                    //         timeInSecForIosWeb: 1,
                                    //         backgroundColor: Colors.red[300],
                                    //         textColor: Colors.white,
                                    //         fontSize: 16.0);
                                    //     return;
                                    //   } else {
                                    //     setState(() {
                                    //       isLoading = false;
                                    //     });
                                    //     Fluttertoast.showToast(
                                    //         msg:
                                    //             "Terjadi Error\nSilahkan Coba Lagi Nanti",
                                    //         toastLength: Toast.LENGTH_SHORT,
                                    //         gravity: ToastGravity.BOTTOM,
                                    //         timeInSecForIosWeb: 1,
                                    //         backgroundColor: Colors.red[300],
                                    //         textColor: Colors.white,
                                    //         fontSize: 16.0);
                                    //     return;
                                    //   }
                                    // } else if (isTicketEdited == true) {
                                    //   print("ONLY TICKET");
                                    //   if (ticketPriceController != null &&
                                    //       ticketStockController != null) {
                                    //     await destCon.editTicketByIdDestinasi(
                                    //       idDestinasi: widget.id.id,
                                    //       price: priceValue,
                                    //       stock: stockValue,
                                    //     );
                                    //     Navigator.pushAndRemoveUntil(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 const HomePageOwner()),
                                    //         (route) => false);
                                    //   }
                                    //   setState(() {
                                    //     isUpdating = false;
                                    //   });
                                    // }
                                    //a
                                    // await destCon.editDestinasi(
                                    //     id: widget.id.id,
                                    //     nameDestinasi: nameController?.text,
                                    //     description:
                                    //         descriptionController?.text,
                                    //     address: addressController?.text,
                                    //     city: finalSelectedProvince.toString(),
                                    //     category: finalSelectedCategory,
                                    //     contact: phoneNumberController?.text,
                                    //     hobby: finalSelectedHobby,
                                    //     minutesSpend:
                                    //         minutesSpendController?.text,
                                    //     latitude: latitudeValue,
                                    //     longitude: longitudeValue,
                                    //     urlMap: urlMapController?.text,
                                    //     recWeather: finalSelectedWeather,
                                    //     fasility: fasilitiesController?.text,
                                    //     security: securityAvail,
                                    //     // image:
                                    //     openHour: openHourController?.text,
                                    //     closedHour: closedHourController?.text);
                                    // if (destCon.statusCodeEditDestinasi ==
                                    //     200) {
                                    //   if (ticketPriceController != null &&
                                    //       ticketStockController != null) {
                                    //     await destCon.editTicketByIdDestinasi(
                                    //       idDestinasi: widget.id.id,
                                    //       price: priceValue,
                                    //       stock: stockValue,
                                    //     );
                                    //     print(destCon.statusCodeAddTicket);
                                    //   }
                                    //   setState(() {
                                    //     isUpdating = false;
                                    //   });
                                    //   // ignore: use_build_context_synchronously
                                    //   Navigator.pushAndRemoveUntil(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               const HomePageOwner()),
                                    //       (route) => false);
                                    //   Fluttertoast.showToast(
                                    //       msg: "Tempat wisatamu telah diubah!",
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.BOTTOM,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor:
                                    //           primaryColor.withOpacity(0.6),
                                    //       textColor: Colors.white,
                                    //       fontSize: 13);
                                    // } else if (destCon
                                    //         .statusCodeEditDestinasi ==
                                    //     404) {
                                    //   setState(() {
                                    //     isLoading = false;
                                    //   });
                                    //   Fluttertoast.showToast(
                                    //       msg: destCon.messageEditDestinasi
                                    //           .toString(),
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.BOTTOM,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor: Colors.red[300],
                                    //       textColor: Colors.white,
                                    //       fontSize: 16.0);
                                    //   return;
                                    // } else {
                                    //   setState(() {
                                    //     isLoading = false;
                                    //   });
                                    //   Fluttertoast.showToast(
                                    //       msg:
                                    //           "Terjadi Error\nSilahkan Coba Lagi Nanti",
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.BOTTOM,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor: Colors.red[300],
                                    //       textColor: Colors.white,
                                    //       fontSize: 16.0);
                                    //   return;
                                    // }
                                  },
                                  child: Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        "Ubah Tempat Wisata",
                                        style: GoogleFonts.openSans(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ))),
                                )
                              : Container(
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    "Ubah Tempat Wisata",
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ))),
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
