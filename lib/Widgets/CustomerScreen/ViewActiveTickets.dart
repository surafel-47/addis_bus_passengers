// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:addis_bus_mgt_passenger/Models/CustomerModel.dart';
import 'package:addis_bus_mgt_passenger/Repositories/CustomerRepo.dart';
import 'package:addis_bus_mgt_passenger/Widgets/CustomerScreen/ViewTicketDetails.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../Repositories/Localizations.dart';
import '../../Repositories/ScreenColors.dart';
import '../../Repositories/myUtiils.dart';

class ViewActiveTickets extends StatefulWidget {
  @override
  State<ViewActiveTickets> createState() => _ViewActiveTicketsState();
}

class _ViewActiveTicketsState extends State<ViewActiveTickets> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locMgrProv = Provider.of<LocalizationManager>(context, listen: true);

    return LayoutBuilder(
      builder: (context, constraints) {
        double cardW = constraints.maxWidth;
        double cardH = constraints.maxHeight;
        return Container(
          width: cardW,
          height: cardH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  locMgrProv.getText('active_tickets'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder(
                future: CustomerRepo.getPendingTickets(),
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
                    if (snapshot.data!.isEmpty || snapshot.data!['pending_tickets'].length == 0) {
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
                              "No Active Tickets",
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
                      var jsonResult = snapshot.data!['pending_tickets'];
                      return Expanded(
                        child: ListView.builder(
                          itemCount: jsonResult.length,
                          itemBuilder: (context, index) {
                            return TicketCard(cardData: jsonResult[index]);
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
    );
  }
}

class TicketCard extends StatelessWidget {
  Map<String, dynamic> cardData;
  bool hideViewMore;
  TicketCard({required this.cardData, this.hideViewMore = false});

  @override
  Widget build(BuildContext context) {
    final locMgrProv = Provider.of<LocalizationManager>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        elevation: 6,
        child: Column(
          children: [
            Container(
              child: ListTile(
                leading: Icon(Icons.bus_alert_outlined),
                title: Text(
                  "${cardData['start_station']} -> ${cardData['end_station']}",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${cardData['price'].toString()} ${locMgrProv.getText('birr')}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                trailing: Icon(Icons.document_scanner),
              ),
            ),
            Container(
              child: ListTile(
                leading: Icon(Icons.timelapse_outlined),
                title: Text(
                  locMgrProv.getText('booked_time'),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  MyUtils.formateDateTime(cardData['date_issued']),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                trailing: hideViewMore
                    ? SizedBox()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.btnBgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewTicketDetails(cardData: cardData),
                            ),
                          );
                        },
                        child: Text(
                          locMgrProv.getText('view'),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
            ),
            Container(
              child: ListTile(
                leading: Icon(Icons.bus_alert_outlined),
                title: Text(
                  "${locMgrProv.getText('bus_num')} : ${cardData['route_id']}",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${cardData['route_name']}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
