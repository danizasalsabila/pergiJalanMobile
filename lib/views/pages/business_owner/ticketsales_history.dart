import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pergijalan_mobile/controllers/eticket_controller.dart';
import 'package:provider/provider.dart';

import '../../../controllers/destinasi_controller.dart';
import '../../../controllers/owner_business_controller.dart';

class TicketSalesHistory extends StatefulWidget {
  const TicketSalesHistory({super.key});

  @override
  State<TicketSalesHistory> createState() => _TicketSalesHistoryState();
}

class _TicketSalesHistoryState extends State<TicketSalesHistory> {
  bool isLoading =false;
  
  @override
  void initState() {
    print(" ");
    print("-------------DIRECT TO LIST DATA BY CATEGORY-----------");
    final historyList = Provider.of<ETicketController>(context, listen: false);
    final ownerCon =
        Provider.of<OwnerBusinessController>(context, listen: false);

    isLoading = true;

    Future.delayed(Duration(seconds: 1)).then((value) async {
      try {
        await historyList.allEticketByOwner(ownerCon.idOBLogin);
      } catch (e) {
        e;
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
      
    );

  }
}