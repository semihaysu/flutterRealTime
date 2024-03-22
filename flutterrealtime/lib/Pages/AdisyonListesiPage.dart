import 'package:flutter/material.dart';
import 'package:flutterrealtime/Models/AdisyonListesi.dart';
import 'package:flutterrealtime/Pages/HomePage.dart';
import 'package:flutterrealtime/Widgets/AdisyonListesiTable.dart';
import 'package:provider/provider.dart';
import '../Api/Api.dart';

import '../Constant/ShareFunctions.dart';
import '../Models/Bayi.dart';
import '../Models/GetirTotalCiro.dart';
import '../Providers/Providers/UserProvider.dart';
import '../Widgets/Datetime.dart';
import '../Widgets/getirTotalCiro.dart';

class AdisyonListesiPage extends StatefulWidget {
  const AdisyonListesiPage({Key? key}) : super(key: key);

  @override
  _AdisyonListesiPageState createState() => _AdisyonListesiPageState();
}

class _AdisyonListesiPageState extends State<AdisyonListesiPage> {
  late String email;

  late String userdealer;
  List<Bayi> _bayiListesi = [];

  String? _selectedValueKaynak = "4";
  String? _selectedValueDurum = "-6";

  Bayi? _selectedBayi = Bayi(
    usubelistid: 0,
    usubelistuserid: 0,
    usubelistuname: "",
    usubelistudealer: "",
    usubelistsubedealer: "sbm000",
    usubelistsubename: "Tümü Seç",
  );
  late String isletme;
  bool getirButon = false;

  //String dateString = '2024-03-03';

  @override
  void initState() {
    super.initState();

    fetchSiparisandCiroPie();
    _bayiListesiYukle();
  }

  Future<List<Adisyon>> getirAdisyonListesi() async {
    List<Adisyon> getirTotalCiro = await Api().getirAdisyonListesi(
        Provider.of<UserProvider>(context).selectedBayi.usubelistsubedealer,
        Provider.of<UserProvider>(context).dateString,
        Provider.of<UserProvider>(context).dateString,
        _selectedValueKaynak!,
        _selectedValueDurum!,
        isletme);
    return getirTotalCiro;
  }

  void fetchSiparisandCiroPie() async {
    isletme = Provider.of<UserProvider>(context, listen: false).isletme;
    email = Provider.of<UserProvider>(context, listen: false).email;
    userdealer = Provider.of<UserProvider>(context, listen: false).userDealer;
    dateString = Provider.of<UserProvider>(context, listen: false).dateString;
  }

  Future<void> _bayiListesiYukle() async {
    try {
      List<Bayi> bayiListesi =
          await Api().getiriliskiliBayiListesi(userdealer, isletme, email);
      setState(() {
        _bayiListesi = bayiListesi;
        _selectedBayi = _bayiListesi.isNotEmpty ? _bayiListesi.first : null;
      });
    } catch (e) {
      print("Hata: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: size.height * 0.05),
                Container(
                  width: size.width * 0.4,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Durum Seçin',
                    ),
                    value: _selectedValueDurum, // Seçilen değer
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValueDurum = newValue; // Yeni değeri ayarla
                      });
                    },

                    items: const [
                      DropdownMenuItem(
                        value: '-6', // İlk değer
                        child: Text('Tümü'),
                      ),
                      DropdownMenuItem(
                        value: '-3', // İkinci değer
                        child: Text('İptal Olanlar'),
                      ),
                      DropdownMenuItem(
                        value: '0,1,-1,-5,-4', // İkinci değer
                        child: Text('Açık Siparişler'),
                      ),
                      DropdownMenuItem(
                        value: '1', // İkinci değer
                        child: Text('Hazırlanıyor'),
                      ),
                      DropdownMenuItem(
                        value: '-1', // İkinci değer
                        child: Text('Kuryede'),
                      ),
                      DropdownMenuItem(
                        value: '-4', // İkinci değer
                        child: Text('Fırında'),
                      ),
                      DropdownMenuItem(
                        value: '-5', // İkinci değer
                        child: Text('Teslime Hazır'),
                      ),
                      DropdownMenuItem(
                        value: '-7', // İkinci değer
                        child: Text('Teslim Edildi'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  width: size.width * 0.4,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Kaynak Seçin',
                    ),
                    value: _selectedValueKaynak, // Seçilen değer
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValueKaynak = newValue; // Yeni değeri ayarla
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: '1',
                        child: Text('Masa'),
                      ),
                      DropdownMenuItem(
                        value: '4',
                        child: Text('Gel-Al'),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text('Paket'),
                      ),
                      DropdownMenuItem(
                        value: '9',
                        child: Text('Çağrı Merkezi'),
                      ),
                      DropdownMenuItem(
                        value: '3',
                        child: Text('YS'),
                      ),
                      DropdownMenuItem(
                        value: '10',
                        child: Text('YS-Joker'),
                      ),
                      DropdownMenuItem(
                        value: '15',
                        child: Text('YS-Vale'),
                      ),
                      DropdownMenuItem(
                        value: '155',
                        child: Text('YS-Gel-Al'),
                      ),
                      DropdownMenuItem(
                        value: '18',
                        child: Text('YS-Manuel'),
                      ),
                      DropdownMenuItem(
                        value: '7',
                        child: Text('Web'),
                      ),
                      DropdownMenuItem(
                        value: '12',
                        child: Text('Getir RG'),
                      ),
                      DropdownMenuItem(
                        value: '8',
                        child: Text('Getir GG'),
                      ),
                      DropdownMenuItem(
                        value: '11',
                        child: Text('Trendyol-Go'),
                      ),
                      DropdownMenuItem(
                        value: '16',
                        child: Text('Trendyol-M1'),
                      ),
                      DropdownMenuItem(
                        value: '17',
                        child: Text('Migros Yemek'),
                      ),
                      DropdownMenuItem(
                        value: '14',
                        child: Text('Gofody'),
                      ),
                      DropdownMenuItem(
                        value: '5',
                        child: Text('Personel'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.05),
              ],
            ),
            SizedBox(height: size.height * 0.04),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  getirButon = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange.shade500,
              ),
              child: Text(
                "Getir",
                style: TextStyle(color: Colors.white),
              ),
            ),
            /*DropdownButtonFormField<Bayi>(
              value: _selectedBayi, // Seçilen bayi
              onChanged: (newValue) {
                setState(() {
                  _selectedBayi = newValue; // Seçilen bayiyi güncelle
                });
              },
              items: _bayiListesi.map((bayi) {
                return DropdownMenuItem<Bayi>(
                  value: bayi,
                  child: Text(bayi.usubelistsubename),
                );
              }).toList(),

              decoration: InputDecoration(
                labelText: 'Bayi Seçin',
                border: OutlineInputBorder(),
              ),
            ),*/
            SizedBox(height: size.height * 0.04),
            //Text(dateString),

            /* ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 255, 255, 255),
                child: DateSelector(
                  onDateSelected: (selectedDate) {
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
            ),*/
            SizedBox(
              height: size.height * 0.04,
            ),
            FutureBuilder(
              future: getirAdisyonListesi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData && getirButon == true) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        AdisyonListesiTable(adisyonListesi: snapshot.data!)
                      ],
                    ),
                  );
                } else {
                  return const Center();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
