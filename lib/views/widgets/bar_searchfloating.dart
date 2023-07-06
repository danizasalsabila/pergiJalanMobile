import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/controllers/destinasi_controller.dart';
import 'package:provider/provider.dart';

import '../../config/theme_color.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({super.key});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  String queries = '';
  // bool isLoading = false;
  final TextEditingController queryController = TextEditingController();
  // final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    queryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DestinasiController>(builder: (context, searchCon, child) {
      return SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  "Inspirasi Wisata Terbaik",
                  style: GoogleFonts.kanit(
                      fontSize: 24,
                      color: primaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  "Temukan destinasi impianmu berdasarkan\nnama, kota dan kategori wisata",
                  style: GoogleFonts.openSans(
                      fontSize: 13,
                      color: descColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextField(
                  onChanged: (String query) async {
                    // isLoading = true;
                    // debugPrint('data: $query');
                    if (query.isNotEmpty) {
                      print("not empty");

                      queryController.clear();
                      setState(() {
                        queries = query;
                        print(queries);
                      });
                      try {
                        await searchCon.searchDestinasi(query);
                      } catch (e) {
                        e;
                      }

                      queryController.clear();
                      // setState(() {
                      //   isLoading = false;
                      // });
                    } else if (query.isEmpty) {
                      print("empty");
                      searchCon.clearData();
                      queryController.clear();
                      print("data query: ${searchCon.destinasiQueryData}");
                    }
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: secondaryColor, width: 2)),
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 22.0, right: 18),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      hintText: "Cari Tempat Wisata"),
                ),
              )
            ]),
      );
    });
  }
}
