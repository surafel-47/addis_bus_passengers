// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_build_context_synchronously

import 'package:addis_bus_mgt_passenger/Repositories/CustomerRepo.dart';
import 'package:addis_bus_mgt_passenger/Widgets/CustomerScreen/StationPicker.dart';
import 'package:addis_bus_mgt_passenger/Widgets/CustomerScreen/ViewTicketDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../Repositories/Localizations.dart';
import '../../Repositories/ScreenColors.dart';
import '../../Repositories/myUtiils.dart';
import '../CustomWidgets/CustomeWidgets.dart';

class BookTicketScreen extends StatefulWidget {
  @override
  State<BookTicketScreen> createState() => _BookTicketScreenState();
}

class _BookTicketScreenState extends State<BookTicketScreen> {
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
          padding: EdgeInsets.all(20),
          width: cardW,
          height: cardH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  locMgrProv.getText('book_ticket'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: ListTile(
                  title: Text(
                    locMgrProv.getText('start_station'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(CustomerRepo.customerModel.startStation),
                  leading: Icon(Icons.bus_alert),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.btnBgColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        dynamic jsonResult = await CustomerRepo.getStationsList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StationPicker(
                              jsonResult: jsonResult,
                              pickFirstStation: true,
                              refereshState: () {
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      } catch (err) {
                        MyCustomSnackBar(context: context, message: err.toString(), leadingIcon: Icons.close_rounded, leadingIconColor: Colors.white, bgColor: Colors.red).show();
                      }
                    },
                    child: Text(
                      locMgrProv.getText('select'),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Card(
                elevation: 10,
                child: ListTile(
                  title: Text(
                    locMgrProv.getText('final_station'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(CustomerRepo.customerModel.endStation),
                  leading: Icon(Icons.bus_alert),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.btnBgColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        dynamic jsonResult = await CustomerRepo.getStationsList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StationPicker(
                              jsonResult: jsonResult,
                              pickFirstStation: false,
                              refereshState: () {
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      } catch (err) {
                        MyCustomSnackBar(context: context, message: err.toString(), leadingIcon: Icons.close_rounded, leadingIconColor: Colors.white, bgColor: Colors.red).show();
                      }
                    },
                    child: Text(
                      locMgrProv.getText('select'),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              MyCustomAsyncButton(
                  btnWidth: cardW * 0.9,
                  btnText: locMgrProv.getText('book_ticket'),
                  btnOnTap: () async {
                    try {
                      if (CustomerRepo.customerModel.startStation == "") {
                        throw 'Pick Starting Station';
                      }

                      if (CustomerRepo.customerModel.endStation == "") {
                        throw 'Pick Final Station';
                      }

                      if (CustomerRepo.customerModel.startStation == CustomerRepo.customerModel.endStation) {
                        throw 'Start Station Can not be same as Final Station';
                      }

                      var jsonResult = await CustomerRepo.bookTicket(CustomerRepo.customerModel.startStation, CustomerRepo.customerModel.endStation);

                      CustomerRepo.customerModel.startStation = "";
                      CustomerRepo.customerModel.endStation = "";

                      setState(() {});
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ViewTicketDetails(cardData: jsonResult['ticket']);
                        },
                      ));
                    } catch (err) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return MyCustomAlertDialog(
                            title: 'Error',
                            message: err.toString(),
                            onOkayPressed: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    }
                  }),
              SizedBox(height: 20),
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
                  "${cardData['price'].toString()} Birr",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                trailing: Icon(Icons.document_scanner),
              ),
            ),
            SizedBox(
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
          ],
        ),
      ),
    );
  }
}
