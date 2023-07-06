import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';
import 'package:pergijalan_mobile/views/widgets/bar_mainnavigation.dart';

class TipsAndTrick extends StatefulWidget {
  const TipsAndTrick({super.key});

  @override
  State<TipsAndTrick> createState() => _TipsAndTrickState();
}

class _TipsAndTrickState extends State<TipsAndTrick> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: backgroundColor,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text(
      //     "Tips & Trik",
      //     style: GoogleFonts.inter(
      //         fontSize: 20, color: primaryColor, fontWeight: FontWeight.w700),
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Trip Tips & Trik",
                style: GoogleFonts.kanit(
                    fontSize: 25,
                    color: primaryColor,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Beberapa tips dan trik untuk anda melakukan perjalanan ke tempat wisata Indonesia",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    fontSize: 13,
                    color: titleColor,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainNavigation(indexNav: 1)));
                                  },
                                  child: Text(
                                    "Pilih tujuan wisata dengan cermat: ",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  "Teliti dan pilihlah tujuan wisata dalam negeri yang sesuai dengan minat dan preferensi Anda. Pertimbangkan faktor seperti cuaca, kategori, waktu yang tersedia, dan ketersediaan fasilitas",
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: titleColor,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainNavigation(indexNav: 0)));
                                  },
                                  child: Text(
                                    "Cari informasi tentang tempat wisata: ",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  "Lakukan riset tentang tempat wisata yang akan Anda kunjungi. Pelajari tentang atraksi utama, objek wisata, aktivitas yang tersedia, dan aturan atau kebijakan khusus yang mungkin berlaku di tempat tersebut.",
                                  // maxLines: 5,
                                  // overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: titleColor,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: "Rencanakan jadwal perjalanan: ",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text:
                                        'Buatlah rencana perjalanan yang matang, termasuk durasi, tanggal keberangkatan dan kepulangan, serta jadwal aktivitas yang ingin Anda lakukan di tempat wisata tersebut.',
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: titleColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ])),
                                SizedBox(
                                  height: 15,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text:
                                        "Persiapkan perlengkapan perjalanan: ",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text:
                                        'Siapkan perlengkapan yang diperlukan seperti pakaian yang sesuai dengan cuaca, obat-obatan pribadi, alat komunikasi, dan peralatan lain yang dibutuhkan sesuai dengan jenis perjalanan yang Anda rencanakan.',
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: titleColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ])),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/images/to_location.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(27, 255, 255, 255)),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: SizedBox(
                              height: 100,
                              child: Text(
                                "Persiapan sebelum\nperjalanan",
                                style: GoogleFonts.kanit(
                                    shadows: <Shadow>[
                                      const Shadow(
                                        offset: Offset(2, 2.0),
                                        blurRadius: 5.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ],
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Patuhi aturan dan peraturan: ",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Selalu patuhi aturan dan peraturan yang berlaku di tempat wisata. Hormati budaya dan adat istiadat setempat, serta jaga kebersihan dan kelestarian lingkungan.",
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: titleColor,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Perhatikan keamanan pribadi: ",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Jaga barang-barang berharga Anda dan perhatikan keamanan pribadi Anda. Gunakan pengamanan tambahan seperti dompet anti-pencurian atau sabuk pengaman untuk tas Anda.",
                                  // maxLines: 5,
                                  // overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: titleColor,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text:
                                        "Berkomunikasi dengan penduduk lokal: ",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text:
                                        'Cobalah berinteraksi dengan penduduk lokal dan bertanya tentang tempat-tempat menarik atau rekomendasi kuliner. Ini dapat memberikan pengalaman yang lebih dalam dan unik selama perjalanan Anda.',
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: titleColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ])),
                                SizedBox(
                                  height: 15,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: "Jaga kebersihan dan lingkungan: ",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text:
                                        'Selalu jaga kebersihan dan tinggalkan tempat wisata dalam keadaan seperti semula. Hindari membuang sampah sembarangan dan ikuti petunjuk pengelola tempat wisata dalam menjaga kelestarian lingkungan.',
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: titleColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ])),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/images/in_location.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(43, 255, 255, 255)),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: SizedBox(
                              height: 100,
                              child: Text(
                                "Persiapan selama\nperjalanan",
                                style: GoogleFonts.kanit(
                                    shadows: <Shadow>[
                                      const Shadow(
                                        offset: Offset(2, 2.0),
                                        blurRadius: 5.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ],
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class BeforeTrips extends StatefulWidget {
  const BeforeTrips({super.key});

  @override
  State<BeforeTrips> createState() => _BeforeTripsState();
}

class _BeforeTripsState extends State<BeforeTrips> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
