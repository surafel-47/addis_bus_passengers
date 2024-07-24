// ignore_for_file: use_key_in_widget_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_declarations, prefer_const_constructors_in_immutables, must_be_immutable, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Repositories/Localizations.dart';
import '../../Repositories/ScreenColors.dart';
import 'BookTicket.dart';
import 'Drawar/Drawer.dart';
import 'ViewActiveTickets.dart';

class CustomerMainScreen extends StatefulWidget {
  @override
  State<CustomerMainScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CustomerMainScreen> {
  int selIndex = 0;
  @override
  Widget build(BuildContext context) {
    final locMgrProv = Provider.of<LocalizationManager>(context, listen: true);

    List<Widget> items = [
      BookTicketScreen(),
      ViewActiveTickets(),
    ];
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.dehaze_sharp,
                color: MyColors.lightBlueText,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          title: Text(
            locMgrProv.getText('addis_bus_passengers'),
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
        drawer: MyDrawer(),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/bg2.png',
              ),
            ),
          ),
          child: Stack(
            children: [
              IndexedStack(
                index: selIndex,
                children: items,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 25,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color.fromARGB(35, 0, 0, 0), const Color.fromARGB(39, 255, 255, 255)],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: MyColors.btnBgColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Color.fromARGB(255, 226, 218, 218),
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            FocusScope.of(context).unfocus();
            selIndex = value;
            setState(() {});
          },
          currentIndex: selIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.file_copy_rounded, color: Colors.white),
              label: locMgrProv.getText('book_ticket'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined, color: Colors.white),
              label: locMgrProv.getText('view_tickets'),
            ),
          ],
        ),
      ),
    );
  }
}
