// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_declarations, prefer_const_constructors_in_immutables, must_be_immutable, use_build_context_synchronously, file_names, use_key_in_widget_constructors

import 'package:addis_bus_mgt_passenger/Models/CustomerModel.dart';
import 'package:addis_bus_mgt_passenger/Repositories/CustomerRepo.dart';
import 'package:addis_bus_mgt_passenger/Widgets/CustomerScreen/CustomerMainScreen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../Repositories/Localizations.dart';
import '../../Repositories/LoginRepo.dart';
import '../../Repositories/ScreenColors.dart';
import '../../Repositories/myUtiils.dart';
import '../CustomWidgets/CustomeWidgets.dart';
import 'CreateAccountScreen.dart';

class LoginInScreen extends StatelessWidget {
  double scrH = 0, scrW = 0;

  TextEditingController phoneTxtCtr = TextEditingController();
  TextEditingController pinTxtCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locMgrProv = Provider.of<LocalizationManager>(context, listen: true);

    scrH = MediaQuery.of(context).size.height;
    scrW = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Container(
          height: scrH,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/bg.png',
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    SizedBox(
                      height: scrH * 0.25,
                      child: Stack(
                        children: [
                          Align(
                            child: Container(
                              height: 250,
                              width: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(130),
                                  bottomLeft: Radius.circular(130),
                                  topRight: Radius.circular(200), // Adjust this value to make it pointy
                                  bottomRight: Radius.circular(100), // Adjust this value to make it pointy
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment(0, -1),
                                  end: Alignment(0, 1),
                                  colors: [Color.fromARGB(255, 79, 33, 243), Color.fromARGB(211, 79, 33, 243)],
                                  stops: const <double>[0, 0.703],
                                ),
                              ),
                              child: Image.asset('assets/logo.png', fit: BoxFit.contain),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20, right: 10),
                              child: Container(
                                alignment: Alignment.center,
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromARGB(52, 0, 0, 0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    if (locMgrProv.currentLanguage == 'en') {
                                      locMgrProv.changeLanguage('am');
                                    } else {
                                      locMgrProv.changeLanguage('en');
                                    }
                                  },
                                  child: Text(
                                    locMgrProv.currentLanguage == 'en' ? 'en' : 'አማ',
                                    style: TextStyle(fontFamily: 'NotoSansEthiopic', color: MyColors.whiteText, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: scrH * 0.1,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          locMgrProv.getText('welcome_back_message'),
                          style: TextStyle(fontSize: scrW * 0.065, color: MyColors.whiteText, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: scrH * 0.07,
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            locMgrProv.getText('login_in_page_bottom_text_passenger'),
                            style: TextStyle(fontSize: 15, color: MyColors.lightBlueText, fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(height: 10),
                    MyCustomTextField(
                      txtController: phoneTxtCtr,
                      hintText: locMgrProv.getText('phone_number_text'),
                      leadingIcon: Icons.phone,
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            locMgrProv.getText('pin_code'),
                            style: TextStyle(fontSize: 15, color: MyColors.lightBlueText, fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      child: PinCodeTextField(
                        controller: pinTxtCtr,
                        textStyle: TextStyle(color: MyColors.whiteText),
                        mainAxisAlignment: MainAxisAlignment.center,
                        appContext: context,
                        length: 4,
                        pinTheme: PinTheme(
                          fieldOuterPadding: EdgeInsets.only(left: 10, right: 10),
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(6),
                          activeColor: Colors.white,
                          inactiveColor: MyColors.lightBlueText,
                          selectedColor: MyColors.whiteText,
                          activeFillColor: MyColors.whiteText,
                          selectedFillColor: MyColors.whiteText,
                          inactiveFillColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    MyCustomAsyncButton(
                      backgroundColor: MyColors.lightBlueText,
                      txtColor: MyColors.btnBgColor,
                      btnText: locMgrProv.getText('login_btn'),
                      btnHeight: scrH * 0.07,
                      btnOnTap: () async {
                        try {
                          FocusScope.of(context).unfocus();

                          if (phoneTxtCtr.text.isEmpty) {
                            throw "Phone Number Empty";
                          }

                          if (pinTxtCtr.text.isEmpty) {
                            throw "Pin Number Is Empty";
                          }

                          MyUtils.validatePin(pinTxtCtr.text);

                          var jsonResult = await LoginRepo.login(phoneTxtCtr.text, pinTxtCtr.text);

                          CustomerModel customerModel = CustomerModel.fromJson(jsonResult['person']);
                          CustomerRepo.customerModel = customerModel;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MaterialApp(
                                  debugShowCheckedModeBanner: false,
                                  home: CustomerMainScreen(),
                                );
                              },
                            ),
                            (route) => false,
                          );
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
                      },
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            locMgrProv.getText('forgot_your_pincode'),
                            style: TextStyle(color: MyColors.lightBlueText, fontSize: 17),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return MyCustomAlertDialog(
                                    title: locMgrProv.getText('forgot_your_pincode'),
                                    message: locMgrProv.getText('forgot_password_instructions'),
                                    onOkayPressed: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => CreateAccoutScreen()),
                              // );
                            },
                            child: Text(
                              locMgrProv.getText('click_here'),
                              style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.whiteText, fontSize: 17),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            locMgrProv.getText('new_here'),
                            style: TextStyle(color: MyColors.lightBlueText, fontSize: 17),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CreateAccoutScreen()),
                              );
                            },
                            child: Text(
                              locMgrProv.getText('create_account'),
                              style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.whiteText, fontSize: 17),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
