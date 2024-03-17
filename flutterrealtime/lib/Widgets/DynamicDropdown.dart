
import 'package:flutter/material.dart';
import 'package:flutterrealtime/Api/Api.dart';
import 'package:flutterrealtime/Models/Bayi.dart';
import 'package:provider/provider.dart';

import '../Providers/Providers/UserProvider.dart';


typedef DropdownCallback = void Function(String? selectedValue);

class DropdownItemDynamic extends StatefulWidget {
  final DropdownCallback? onChanged;
  final String? isletme;
  final String? dealer;

  const DropdownItemDynamic(
      {Key? key, this.onChanged, this.isletme, this.dealer})
      : super(key: key);
  @override
  _DropdownItemDynamicState createState() => _DropdownItemDynamicState();
}

class _DropdownItemDynamicState extends State<DropdownItemDynamic> {
  late String isletme;
  late String email;
  
  late String userdealer;
  String dealerList = "0";
  String dateString = '2024-03-03';
  final _dropdownFormKey = GlobalKey<FormState>();

  String? seciliDeger;
  List<Bayi> _bayiler = [];

  Bayi yeniBayi = Bayi(
    usubelistid: 2,
    usubelistuserid: 700,
    usubelistuname: "sistem",
    usubelistudealer: "sbm000",
    usubelistsubedealer: "0",
    usubelistsubename: "Tümü",
  );

  @override
  void initState() {
    super.initState();

    _verileriGetir();
  }

  Future<void> _verileriGetir() async {
    try {
      List<Bayi> bayiListesi =
          await  Api().getiriliskiliBayiListesi(userdealer, isletme, email);

      setState(() {
        _bayiler.add(yeniBayi);
        _bayiler = bayiListesi;
      });
    } catch (e) {
      print("Hata: $e");
    }
  }
  void fetchSiparisandCiroPie() async {
    isletme = Provider.of<UserProvider>(context, listen: false).isletme;
    email = Provider.of<UserProvider>(context, listen: false).email;
    userdealer= Provider.of<UserProvider>(context, listen: false).userDealer;
   

   
       
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _dropdownFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButtonFormField(
            onChanged: (String? newValue) {
              setState(() {
                seciliDeger = newValue;
                widget.onChanged?.call(newValue);
              });
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 235, 223, 223),
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            items: _bayiler.map((bayi) {
              return DropdownMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.store),
                    SizedBox(width: 8),
                    Text(bayi.usubelistsubename),
                  ],
                ),
                value: bayi.usubelistsubedealer,
              );
            }).toList(),
            hint: const Center(child: Text("Bayi Seçiniz")),
          ),
        ],
      ),
    );
  }
}
