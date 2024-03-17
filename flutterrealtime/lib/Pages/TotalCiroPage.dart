import 'package:flutter/material.dart';
import 'package:flutterrealtime/Models/Bayi.dart';
import 'package:provider/provider.dart';
import '../Api/Api.dart';

import '../Constant/ShareFunctions.dart';
import '../Models/GetirTotalCiro.dart';
import '../Providers/Providers/UserProvider.dart';
import '../Widgets/Datetime.dart';

import '../Widgets/getirTotalCiro.dart';

class TotalCiroPage extends StatefulWidget {
  const TotalCiroPage({Key? key}) : super(key: key);

  @override
  _TotalCiroPageState createState() => _TotalCiroPageState();
}

class _TotalCiroPageState extends State<TotalCiroPage> {
  late String isletme;
  late String email;
  
  late String userdealer;
  
  String dateString = '2024-03-03';
  List<Bayi> _bayiListesi = [];
  
  Bayi bayi1 = Bayi(
                    usubelistid: 0,
                    usubelistuserid: 0,
                    usubelistuname: "",
                    usubelistudealer: "",
                    usubelistsubedealer: "0",
                    usubelistsubename: "Tümü Seç",
                  );
 
  
  Bayi? _selectedBayi=Bayi(
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
    fetchSiparisandCiroPie();
    _bayiListesiYukle();
  }

  Future<List<GetirTotalCiro>> getirTotalCiro() async {
    List<GetirTotalCiro> getirTotalCiro = await Api().getirTotalCiro(userdealer,
        email, _selectedBayi!.usubelistsubedealer, dateString, isletme);
    return getirTotalCiro;
  }

   Future<void> _bayiListesiYukle() async {
    try {
      List<Bayi> bayiListesi = await Api().getiriliskiliBayiListesi(userdealer, isletme, email);
      setState(() {
        _bayiListesi = bayiListesi;
        _selectedBayi = _bayiListesi.isNotEmpty ? _bayiListesi.first : null;
      });
    } catch (e) {
      print("Hata: $e");
    }
  }
 

  void fetchSiparisandCiroPie() async {
    isletme = Provider.of<UserProvider>(context, listen: false).isletme;
    email = Provider.of<UserProvider>(context, listen: false).email;
    userdealer = Provider.of<UserProvider>(context, listen: false).userDealer;
    
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            
           DropdownButtonFormField<Bayi>(
              value: _selectedBayi, // Seçilen bayi
              onChanged: (newValue) {
                setState(() {
                  _selectedBayi = newValue; // Seçilen bayiyi güncelle
                });
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
                border: OutlineInputBorder(),
              ),
            ),
         
            SizedBox(height: size.height * 0.04),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 255, 255, 255),
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
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            FutureBuilder(
              future: getirTotalCiro(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [MyTableWidget(totalCiroList: snapshot.data!)],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
