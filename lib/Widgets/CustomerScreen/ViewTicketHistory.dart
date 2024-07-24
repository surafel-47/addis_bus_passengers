// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, use_key_in_widget_constructors

import 'package:addis_bus_mgt_passenger/Repositories/CustomerRepo.dart';
import 'package:addis_bus_mgt_passenger/Widgets/CustomerScreen/BookTicket.dart';
import 'package:addis_bus_mgt_passenger/Widgets/PaymentPage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../Repositories/Localizations.dart';
import '../../Repositories/ScreenColors.dart';
import '../CustomWidgets/CustomeWidgets.dart';
import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewTicketHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locMgrProv = Provider.of<LocalizationManager>(context, listen: true);
    TextEditingController balanceTxtCtr = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'), // Path to your image
                fit: BoxFit.cover, // Cover the entire app bar
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: MyColors.lightBlueText,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            locMgrProv.getText('history'),
            style: TextStyle(color: MyColors.lightBlueText),
          ),
          actions: [
            CircleAvatar(
              minRadius: 50,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('./assets/logo.png'),
            ),
            SizedBox(width: 20),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double cardW = constraints.maxWidth;
            double cardH = constraints.maxHeight;
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/bg2.png',
                  ),
                ),
              ),
              width: cardW,
              height: cardH,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  FutureBuilder(
                    future: CustomerRepo.getConfirmedTickets(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Expanded(child: Center(child: CircularProgressIndicator()));
                      } else if (snapshot.hasError) {
                        return Container(
                          width: cardW,
                          child: Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: cardH * 0.3,
                                  width: cardH * 0.3,
                                  child: Icon(
                                    Icons.error_outline_outlined,
                                    size: cardH * 0.25,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'Error: Unable To Fetch Data',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        if (snapshot.data!.isEmpty || snapshot.data!['confirmed_tickets'].length == 0) {
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: cardH * 0.3,
                                  width: cardH * 0.3,
                                  child: Lottie.asset(
                                    './assets/empty.json',
                                  ),
                                ),
                                Text(
                                  "No Travel History",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: cardH * 0.3),
                              ],
                            ),
                          );
                        } else {
                          var jsonResult = snapshot.data!['confirmed_tickets'];
                          return Expanded(
                            child: ListView.builder(
                              itemCount: jsonResult.length,
                              itemBuilder: (context, index) {
                                return TicketCard(
                                  cardData: jsonResult[index],
                                  hideViewMore: true,
                                );
                              },
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
