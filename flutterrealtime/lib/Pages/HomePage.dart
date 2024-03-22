import 'package:flutter/material.dart';
import 'package:flutterrealtime/Constant/ShareFunctions.dart';
import 'package:flutterrealtime/Models/Bayi.dart';
import 'package:flutterrealtime/Pages/AdisyonListesiPage.dart';
import 'package:flutterrealtime/Pages/LoginPage.dart';
import 'package:flutterrealtime/Pages/SiparisDagilimPage.dart';
import 'package:flutterrealtime/Widgets/Datetime.dart';
import 'package:provider/provider.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import '../Api/Api.dart';
import '../Providers/Providers/UserProvider.dart';
import 'CiroDagilimPage.dart';
import 'TotalCiroPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.isletmeadi}) : super(key: key);
  final String isletmeadi;
  @override
  _HomePageState createState() => _HomePageState();
}

String dateString = '2024-03-11';

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    CiroDagilimPage(),
    SiparisDagilimPage(),
    TotalCiroPage(),
    AdisyonListesiPage(),
  ];

  late String isletme;
  late String email;

  late String userdealer;

  List<Bayi> _bayiListesi = [];

  Bayi bayi1 = Bayi(
    usubelistid: 0,
    usubelistuserid: 0,
    usubelistuname: "",
    usubelistudealer: "",
    usubelistsubedealer: "0",
    usubelistsubename: "Tümü Seç",
  );
  Bayi? selectedBayi = Bayi(
    usubelistid: 0,
    usubelistuserid: 0,
    usubelistuname: "",
    usubelistudealer: "",
    usubelistsubedealer: "0",
    usubelistsubename: "Tümü Seç",
  );

  @override
  void initState() {
    super.initState();
    selectedBayi = bayi1;
    _bayiListesiYukle();
    fetchSiparisandCiroPie();
  }

  Future<void> _bayiListesiYukle() async {
    try {
      List<Bayi> bayiListesi =
          await Api().getiriliskiliBayiListesi(userdealer, isletme, email);
      setState(() {
        _bayiListesi = bayiListesi;
        selectedBayi = _bayiListesi.isNotEmpty ? _bayiListesi.first : null;
      });
    } catch (e) {
      print("Hata: $e");
    }
  }

  void fetchSiparisandCiroPie() async {
    DateTime date = DateTime.parse(dateString);
    dateString = Provider.of<UserProvider>(context, listen: false).dateString;
    isletme = Provider.of<UserProvider>(context, listen: false).isletme;
    email = Provider.of<UserProvider>(context, listen: false).email;
    userdealer = Provider.of<UserProvider>(context, listen: false).userDealer;
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.deepOrange,
        title: Center(
          child: Container(
            child: ClipRRect(
              child: DropdownButtonFormField<Bayi>(
                value: selectedBayi, // Seçilen bayi
                onChanged: (newValue) {
                  setState(() {
                    selectedBayi = newValue; // Seçilen bayiyi güncelle
                  });
                  Provider.of<UserProvider>(context, listen: false)
                      .setBayi(selectedBayi!);
                  print(selectedBayi!.usubelistsubedealer.toString());
                },
                items: [
                  DropdownMenuItem(
                    value: bayi1,
                    child: Text("Tümü Seç"),
                  ),
                  ..._bayiListesi.map((bayi) {
                    return DropdownMenuItem<Bayi>(
                      value: bayi,
                      child: Text(bayi.usubelistsubename),
                    );
                  }).toList(),
                ],
                decoration: const InputDecoration(
                  labelText: 'Bayi Seçin',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
        actions: [
          Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,

                //color: Color.fromARGB(255, 255, 255, 255),
                child: DateSelector(
                  onDateSelected: (selectedDate) {
                    Provider.of<UserProvider>(context, listen: false)
                        .setDate(dateString);
                    setState(() {
                      DateTime today = DateTime.now();

                      if (selectedDate.isAfter(today)) {
                        shareFunction().showAlertSimple(context, "Uyarı",
                            "Bugünden Büyük Bir Tarih Seçtiniz", "Tamam");
                        return;
                      }

                      setState(() {
                        dateString =
                            '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
                      });
                    });
                  },
                ),
              ),
            ),
          ]),
        ],
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
