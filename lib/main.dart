// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Repositories/Localizations.dart';
import 'Repositories/LoginRepo.dart';
import 'Repositories/myUtiils.dart';
import 'Widgets/CustomWidgets/CustomeWidgets.dart';
import 'Widgets/OnBoarding/OnBoarding.dart';

void main() {
  // Apply the custom HttpOverrides globally before the app starts
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalizationManager>(
          create: (context) => LocalizationManager(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: AppScrollBehavior(),
        home: GetBaseUrlScreen(),
      ),
    );
  }
}

class GetBaseUrlScreen extends StatelessWidget {
  TextEditingController baseUrlTxtCtr = TextEditingController();

  GetBaseUrlScreen() {
    baseUrlTxtCtr.text = MyUtils.BASE_URL;
  }

  @override
  Widget build(BuildContext context) {
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
          leading: SizedBox(),
          title: Text(
            "Addis Bus To Server IP",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/bg2.png',
                  ),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  MyCustomTextField(txtController: baseUrlTxtCtr, leadingIcon: Icons.link, txtColor: Colors.black),
                  SizedBox(height: 20),
                  MyCustomAsyncButton(
                    btnText: "Connect",
                    btnOnTap: () async {
                      MyUtils.BASE_URL = baseUrlTxtCtr.text;

                      try {
                        await LoginRepo.ping();
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return OnBoardingScreen();
                            },
                          ),
                        );
                      } catch (err) {
                        MyCustomSnackBar(
                                duration: Duration(milliseconds: 700),
                                // ignore: use_build_context_synchronously
                                context: context,
                                bgColor: const Color.fromARGB(255, 189, 20, 7),
                                leadingIcon: Icons.error,
                                leadingIconColor: Colors.white,
                                message: err.toString())
                            .show();
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
