// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, must_be_immutable, use_key_in_widget_constructors

import 'package:addis_bus_mgt_passenger/Repositories/CustomerRepo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Repositories/Localizations.dart';
import '../../../Repositories/myUtiils.dart';
import '../../Repositories/ScreenColors.dart';
import '../CustomWidgets/CustomeWidgets.dart';

class MyAccountScreen extends StatelessWidget {
  TextEditingController fullnameCtr = TextEditingController();
  TextEditingController custIdCtr = TextEditingController();
  TextEditingController phoneNoCtr = TextEditingController();
  TextEditingController accounBalanceCtr = TextEditingController();
  TextEditingController pinCodeCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locMgrProv = Provider.of<LocalizationManager>(context, listen: true);
    fullnameCtr.text = CustomerRepo.customerModel.name;
    custIdCtr.text = CustomerRepo.customerModel.custId;
    accounBalanceCtr.text = CustomerRepo.customerModel.accountBalance.toString();
    phoneNoCtr.text = CustomerRepo.customerModel.phoneNo;
    pinCodeCtr.text = CustomerRepo.customerModel.pin;

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
              Icons.arrow_back_ios_new,
              color: MyColors.lightBlueText,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            locMgrProv.getText('account_details'),
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
                  SizedBox(height: 50),
                  Text(
                    locMgrProv.getText('my_account'),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  MyCustomTextField(
                    backgroundColor: Color.fromARGB(255, 101, 100, 200),
                    txtBoxEnabled: false,
                    txtColor: const Color.fromARGB(255, 255, 255, 255),
                    txtController: fullnameCtr,
                    // hintText: locMgrProv.getText('full_name_text'),
                    leadingIcon: Icons.person,
                  ),
                  SizedBox(height: 10),
                  MyCustomTextField(
                    backgroundColor: Color.fromARGB(255, 101, 100, 200),
                    txtBoxEnabled: false,
                    txtColor: const Color.fromARGB(255, 255, 255, 255),
                    txtController: custIdCtr,
                    // hintText: locMgrProv.getText('customer_id'),
                    leadingIcon: Icons.file_copy_rounded,
                  ),
                  SizedBox(height: 10),
                  MyCustomTextField(
                    backgroundColor: Color.fromARGB(255, 101, 100, 200),
                    txtBoxEnabled: false,
                    txtColor: const Color.fromARGB(255, 255, 255, 255),
                    txtController: phoneNoCtr,
                    // hintText: locMgrProv.getText('phone_number_text'),
                    leadingIcon: Icons.phone,
                  ),
                  SizedBox(height: 10),
                  // MyCustomTextField(
                  //   backgroundColor: Color.fromARGB(255, 101, 100, 200),
                  //   txtBoxEnabled: false,
                  //   txtColor: const Color.fromARGB(255, 255, 255, 255),
                  //   txtController: pinCodeCtr,
                  //   // hintText: locMgrProv.getText('pin_code'),
                  //   leadingIcon: Icons.key,
                  // ),
                  SizedBox(height: 20),
                  Expanded(child: SizedBox()),
                  MyCustomAsyncButton(
                      btnWidth: cardW * 0.9,
                      btnText: locMgrProv.getText('change_pin'),
                      btnOnTap: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context2) {
                            TextEditingController newPinCtr = TextEditingController();
                            return AlertDialog(
                              icon: Icon(Icons.warning_amber_rounded),
                              title: Text(locMgrProv.getText('confirm_action')),
                              content: MyCustomTextField(
                                fieldWidth: 200,
                                textInputType: TextInputType.number,
                                txtColor: Colors.black,
                                txtController: newPinCtr,
                                hintText: locMgrProv.getText('new_pin_code'),
                                leadingIcon: Icons.key,
                              ),
                              actions: <Widget>[
                                MyCustomAsyncButton(
                                    btnText: locMgrProv.getText('confirm'),
                                    btnOnTap: () async {
                                      try {
                                        FocusScope.of(context2).unfocus();

                                        String newPin = newPinCtr.text.trim();

                                        MyUtils.validatePin(newPin);

                                        await CustomerRepo.changePassengerPin(newPin);

                                        CustomerRepo.customerModel.pin = newPin;

                                        MyCustomSnackBar(
                                                context: context, message: "Pin Changed", leadingIcon: Icons.check_box, bgColor: Colors.green, leadingIconColor: Colors.white)
                                            .show();
                                      } catch (err) {
                                        MyCustomSnackBar(context: context, message: err.toString(), leadingIcon: Icons.close_rounded).show();
                                      }
                                      Navigator.pop(context2);
                                    })
                              ],
                            );
                          },
                        );
                      }),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
