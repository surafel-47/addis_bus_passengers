// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, use_key_in_widget_constructors, must_be_immutable

import 'dart:async';

import 'package:addis_bus_mgt_passenger/Repositories/CustomerRepo.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../Repositories/Localizations.dart';
import '../../Repositories/ScreenColors.dart';
import 'ViewActiveTickets.dart';

class ViewTicketDetails extends StatefulWidget {
  Map<String, dynamic> cardData;
  ViewTicketDetails({required this.cardData});

  @override
  State<ViewTicketDetails> createState() => _ViewTicketDetailsState();
}

class _ViewTicketDetailsState extends State<ViewTicketDetails> {
  late Timer timer;
  bool ticketScanned = false;

  void startRepeatedMethod() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      try {
        print("Runningg");
        var jsonResult = await CustomerRepo.getSingleTicket(widget.cardData['ticket_id']);

        if (jsonResult['single_ticket']['status'] == "confirmed") {
          setState(() {
            ticketScanned = true;
          });
          stopRepeatedMethod(); // Exit the loop
        }
      } catch (err) {
        // setState(() {
        //   ticketScanned = true;
        // });
        // print("Errorrrrrrrrrr ${err.toString()}");
        // stopRepeatedMethod(); // Exit the loop
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startRepeatedMethod();
  }

  @override
  void dispose() {
    stopRepeatedMethod(); // Stop the timer when the widget is disposed
    super.dispose();
  }

  void stopRepeatedMethod() {
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final locMgrProv = Provider.of<LocalizationManager>(context, listen: true);

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
            locMgrProv.getText('view_tickets'),
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
              padding: EdgeInsets.symmetric(horizontal: cardW * 0.07),
              width: cardW,
              height: cardH,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TicketCard(cardData: widget.cardData, hideViewMore: true),
                  SizedBox(height: 30),
                  ticketScanned
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: cardH * 0.3,
                                width: cardH * 0.3,
                                child: Lottie.asset(
                                  './assets/play.json',
                                ),
                              ),
                              Text(
                                "Ticket Scanned!",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: cardH * 0.3),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Card(
                              elevation: 10,
                              child: QrImageView(
                                data: widget.cardData['ticket_id'].toString(),
                                version: QrVersions.auto,
                                size: cardH * 0.4,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  child: Text(
                                    locMgrProv.getText('scan_me'),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                CircularProgressIndicator(),
                              ],
                            ),
                          ],
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
