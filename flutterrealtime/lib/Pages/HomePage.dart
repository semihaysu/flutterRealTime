import 'package:flutter/material.dart';
import 'package:flutterrealtime/Pages/AdisyonListesiPage.dart';
import 'package:flutterrealtime/Pages/LoginPage.dart';
import 'package:flutterrealtime/Pages/SiparisDagilimPage.dart';
import 'package:provider/provider.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import '../Api/Api.dart';
import '../Providers/Providers/UserProvider.dart';
import 'CiroDagilimPage.dart';
import 'TotalCiroPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    CiroDagilimPage(),
    SiparisDagilimPage(),
    TotalCiroPage(),
    AdisyonListesiPage(),
  ];

  late String isletme;

  String dateString = '2024-03-03';

  @override
  void initState() {
    super.initState();
    fetchSiparisandCiroPie();
  }

  void fetchSiparisandCiroPie() async {
    isletme = Provider.of<UserProvider>(context, listen: false).isletme;
    DateTime date = DateTime.parse(dateString);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading : true,
        backgroundColor: Colors.deepOrange,
        title: Center(
          child: Text(
            "Real Time",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: size.height * 0.09,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        color: Colors.deepOrange,
        animationDuration: const Duration(milliseconds: 400),
        index: currentIndex,
        items: [
          CurvedNavigationBarItem(
            child: Icon(
              Icons.price_check,
              color: const Color.fromARGB(255, 255, 255, 255),
              size: 20,
            ),
            label: 'Ciro',
            labelStyle: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontSize: 13),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.shop_2_outlined,
                color: const Color.fromARGB(255, 255, 255, 255), size: 20),
            label: 'Sipariş',
            labelStyle: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontSize: 13),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.attach_money,
                color: const Color.fromARGB(255, 255, 255, 255), size: 20),
            label: 'Total Ciro',
            labelStyle: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontSize: 13),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.edit_note_rounded,
                color: const Color.fromARGB(255, 255, 255, 255), size: 20),
            label: 'Adisyon',
            labelStyle: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontSize: 13),
          ),
        ],
        onTap: (index) => setState(() => currentIndex = index),
      ),
      body: screens[currentIndex],
    );
  }
}
