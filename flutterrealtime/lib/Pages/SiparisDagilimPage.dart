
import 'package:flutter/material.dart';
import 'package:flutterrealtime/Constant/ShareFunctions.dart';
import 'package:flutterrealtime/Providers/Providers/UserProvider.dart';
import 'package:flutterrealtime/Widgets/Datetime.dart';
import 'package:flutterrealtime/Widgets/DynamicDropdown.dart';
import 'package:provider/provider.dart';
import '../Api/Api.dart';
import '../Models/Bayi.dart';
import '../Widgets/PieChart.dart';

class SiparisDagilimPage extends StatefulWidget {
  const SiparisDagilimPage({Key? key}) : super(key: key);

  @override
  _SiparisDagilimPageState createState() => _SiparisDagilimPageState();
}

class _SiparisDagilimPageState extends State<SiparisDagilimPage> {

  late String isletme;
  late String email;
   List<Bayi> _bayiListesi = [];
  late String userdealer;
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
                    usubelistsubedealer: "sb34006",
                    usubelistsubename: "Tümü Seç",
                  );
  String dateString = '2024-03-03';

  @override
  void initState() {
    super.initState();
    fetchSiparisandCiroPie();
    _bayiListesiYukle();
  }

 Future<List<int>> ciropie () async {
  List<int> siparisandciropie = await Api().GetirSiparisGrafikSiparis(_selectedBayi!.usubelistsubedealer,dateString, isletme);
  return siparisandciropie;
}

  void fetchSiparisandCiroPie() async {
    isletme = Provider.of<UserProvider>(context, listen: false).isletme;
    email = Provider.of<UserProvider>(context, listen: false).email;
    userdealer = Provider.of<UserProvider>(context, listen: false).userDealer;
    
   
  }
  Future<void> _bayiListesiYukle() async {
    try {
      List<Bayi> bayiListesi = await Api().getiriliskiliBayiListesi(userdealer, isletme, email);
      setState(() {
        _bayiListesi = bayiListesi;
        
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
        child: Center(
          child: FutureBuilder(
            future: ciropie(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Hata: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                List<int> data = snapshot.data as List<int>;
                Map<String, int> dataCiro = {
                  'Masa': data.length > 15 ? data[15] : 0,
                  'Gel-Al': data.length > 16 ? data[16] : 0,
                  'Paket': data.length > 17 ? data[17] : 0,
                  'Cagri-Merkezi Gel-Al': data.length > 18 ? data[18] : 0,
                  'Cagri-Merkezi Paket': data.length > 19 ? data[19] : 0,
                  'YS': data.length > 20 ? data[20] : 0,
                  'YS-Joker': data.length > 21 ? data[21] : 0,
                  'YS-Vale': data.length > 22 ? data[22] : 0,
                  'YS Gel-Al': data.length > 31 ? data[31] : 0,
                  'Web Gel-Al': data.length > 23 ? data[23] : 0,
                  'Web Paket': data.length > 24 ? data[24] : 0,
                  'Getir-GG': data.length > 25 ? data[25] : 0,
                  'Getir-RG': data.length > 26 ? data[26] : 0,
                  'Trendyol-Go': data.length > 27 ? data[27] : 0,
                  'Trendyol-M1': data.length > 28 ? data[28] : 0,
                  'Migros-Yemek': data.length > 29 ? data[29] : 0,
                  'GoFody-Yemek': data.length > 33 ? data[33] : 0,
                };

                Map<String, int> dataSiparis = {
                  'Masa': data.length > 0 ? data[0] : 0,
                  'Gel-Al': data.length > 1 ? data[1] : 0,
                  'Paket': data.length > 2 ? data[2] : 0,
                  'Cagri-Merkezi Gel-Al': data.length > 3 ? data[3] : 0,
                  'Cagri-Merkezi Paket': data.length > 4 ? data[4] : 0,
                  'YS': data.length > 5 ? data[5] : 0,
                  'YS-Joker': data.length > 6 ? data[6] : 0,
                  'YS-Vale': data.length > 7 ? data[7] : 0,
                  'YS Gel-Al': data.length > 30 ? data[30] : 0,
                  'Web Gel-Al': data.length > 8 ? data[8] : 0,
                  'Web Paket': data.length > 9 ? data[9] : 0,
                  'Getir-GG': data.length > 10 ? data[10] : 0,
                  'Getir-RG': data.length > 11 ? data[11] : 0,
                  'Trendyol-Go': data.length > 12 ? data[12] : 0,
                  'Trendyol-M1': data.length > 13 ? data[13] : 0,
                  'Migros-Yemek': data.length > 14 ? data[14] : 0,
                  'GoFody-Yemek': data.length > 32 ? data[32] : 0,
                  // Diğer değerleri ekleyebilirsiniz
                };
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
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
          shareFunction().showAlertSimple(context, "Uyarı", "Bugünden Büyük Bir Tarih Seçtiniz", "Tamam");
          return;
        }

        
        setState(() {
          dateString = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'; 
        }); 
                            });
                             

                          },
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Color.fromARGB(255, 255, 255, 255),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Sipariş Dağılımı",
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                            PieChartSample2(data: dataSiparis),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('Veri bulunamadı'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
