// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, must_be_immutable, unused_local_variable, prefer_const_literals_to_create_immutables, file_names, sized_box_for_whitespace

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Repositories/Localizations.dart';
import '../../Repositories/ScreenColors.dart';
import '../CustomWidgets/CustomeWidgets.dart';
import 'LoginScreen.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageViewCtr = PageController();
  int currentPageIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locMgrProv = Provider.of<LocalizationManager>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/bg.png',
              ),
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double scrW = constraints.maxWidth;
              double scrH = constraints.maxHeight;
              return Column(
                children: [
                  SizedBox(
                    height: scrH * 0.07,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20, top: 20),
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
                    ),
                  ),
                  SizedBox(
                    height: scrH * 0.70,
                    child: PageView(
                      controller: _pageViewCtr,
                      children: [
                        SlideOnBoarding(slideNumber: 1),
                        SlideOnBoarding(slideNumber: 2),
                        SlideOnBoarding(slideNumber: 3),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: scrH * 0.03,
                    child: SmoothPageIndicator(
                      controller: _pageViewCtr,
                      count: 3,
                      effect: ExpandingDotsEffect(activeDotColor: Colors.white, dotColor: Color.fromARGB(255, 190, 187, 187), dotHeight: 7, dotWidth: 7),
                    ),
                  ),
                  SizedBox(
                    height: scrH * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            text: locMgrProv.getText('onBoarding_bottom_text'),
                            style: TextStyle(fontFamily: 'NotoSansEthiopic', color: MyColors.lightBlueText, fontSize: scrH * 0.02, fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              TextSpan(
                                text: locMgrProv.getText('onBoarding_bottom_text_site_link'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.backgroundColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    try {} catch (exception) {
                                      // print(exception);
                                    }
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyCustomButton(
                      backgroundColor: MyColors.lightBlueText,
                      txtColor: MyColors.primaryColor,
                      btnText: locMgrProv.getText('login_btn'),
                      btnHeight: scrH * 0.07,
                      btnOnTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginInScreen()),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class SlideOnBoarding extends StatelessWidget {
  int slideNumber;

  SlideOnBoarding({required this.slideNumber});
  @override
  Widget build(BuildContext context) {
    final locMgrProv = Provider.of<LocalizationManager>(context, listen: true);
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraint) {
          double cardW = constraint.maxWidth;
          double cardH = constraint.maxHeight;
          return Column(
            children: [
              Container(
                height: cardH * 0.6,
                child: Stack(
                  children: [
                    Align(
                      child: SizedBox(
                        width: cardH * 0.45,
                        height: cardH * 0.45,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment(0, -1),
                              end: Alignment(0, 1),
                              colors: [Color.fromARGB(255, 79, 33, 243), Color.fromARGB(211, 79, 33, 243)],
                              stops: const <double>[0, 0.703],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      child: SizedBox(
                        width: 220,
                        height: 220,
                        child: Image.asset("assets/loginSlide$slideNumber.png"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    locMgrProv.getText('onBoarding_slide_${slideNumber}_top'),
                    style: TextStyle(fontFamily: 'NotoSansEthiopic', color: MyColors.whiteText, fontSize: cardW * 0.065, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(height: cardH * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    locMgrProv.getText('onBoarding_slide_${slideNumber}_bottom'),
                    style: TextStyle(
                      fontFamily: 'NotoSansEthiopic',
                      color: Color.fromARGB(255, 226, 216, 251),
                      fontSize: cardH * 0.028,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
