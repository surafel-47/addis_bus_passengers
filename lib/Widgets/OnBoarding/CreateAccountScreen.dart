// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_declarations, prefer_const_constructors_in_immutables, must_be_immutable, use_build_context_synchronously, file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../Models/CustomerModel.dart';
import '../../Repositories/CustomerRepo.dart';
import '../../Repositories/Localizations.dart';
import '../../Repositories/LoginRepo.dart';
import '../../Repositories/ScreenColors.dart';
import '../../Repositories/myUtiils.dart';
import '../CustomWidgets/CustomeWidgets.dart';
import '../CustomerScreen/CustomerMainScreen.dart';
import 'LoginScreen.dart';

class CreateAccoutScreen extends StatelessWidget {
  double scrH = 0, scrW = 0;

  TextEditingController fullNameTxtCtr = TextEditingController();
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
              image: AssetImage('assets/bg.png'), // Path to your image
              fit: BoxFit.cover, // Cover the entire app bar
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
                    SizedBox(
                      height: scrH * 0.25,
                      child: Stack(children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset('assets/logo.png', height: scrH * 0.15),
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
                      ]),
                    ),
                    SizedBox(
                      height: scrH * 0.1,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          locMgrProv.getText('welcome_sign_up_text'),
                          style: TextStyle(fontFamily: 'NotoSansEthiopic', fontSize: scrW * 0.065, color: MyColors.whiteText, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: scrH * 0.07,
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            locMgrProv.getText('create_account_text'),
                            style: TextStyle(fontFamily: 'NotoSansEthiopic', fontSize: 15, color: MyColors.lightBlueText, fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(height: 10),
                    MyCustomTextField(
                      txtController: fullNameTxtCtr,
                      hintText: locMgrProv.getText('full_name_text'),
                      leadingIcon: Icons.person,
                    ),
                    SizedBox(height: 20),
                    MyCustomTextField(
                      textInputType: TextInputType.phone,
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
                        obscureText: true,
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
                      btnText: locMgrProv.getText('create_account'),
                      btnHeight: scrH * 0.07,
                      btnOnTap: () async {
                        try {
                          FocusScope.of(context).unfocus();

                          String fullName = fullNameTxtCtr.text.trim();
                          String phoneNo = phoneTxtCtr.text.trim();

                          if (fullName.isEmpty) {
                            throw "Full Number Empty";
                          }

                          if (!MyUtils.isValidName(fullName)) {
                            throw 'Invalid Full Name';
                          }

                          if (fullName.length < 5) {
                            throw "Full Name Too Short";
                          }

                          if (phoneNo.isEmpty) {
                            throw "Phone Number Empty";
                          }

                          if (!MyUtils.isValidInteger(phoneNo)) {
                            throw "Phone Number Empty";
                          }

                          if (phoneNo.length != 10) {
                            throw "Phone Number isn't Ten Digits";
                          }

                          if (pinTxtCtr.text.isEmpty) {
                            throw "Pin Number Empty";
                          }

                          MyUtils.validatePin(pinTxtCtr.text);

                          var jsonResult = await LoginRepo.createAccount(phoneTxtCtr.text, pinTxtCtr.text, fullNameTxtCtr.text);

                          CustomerModel customerModel = CustomerModel.fromJson(jsonResult['customer']);
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
                            locMgrProv.getText('already_have_account_text'),
                            style: TextStyle(fontFamily: 'NotoSansEthiopic', color: MyColors.lightBlueText, fontSize: 17),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginInScreen()),
                              );
                            },
                            child: Text(
                              locMgrProv.getText('login_btn'),
                              style: TextStyle(fontFamily: 'NotoSansEthiopic', fontWeight: FontWeight.bold, color: MyColors.whiteText, fontSize: 17),
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
