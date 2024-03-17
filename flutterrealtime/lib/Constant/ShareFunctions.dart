import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

class shareFunction extends StatefulWidget {
  @override
  void showAlertSimple(
      BuildContext contextB, String title, String info, String buttonText) {
    SimpleAlertBox(
        context: contextB,
        title: title,
        infoMessage: info,
        buttonText: buttonText);
  }
   
  void showMessage(BuildContext context, Widget child, {Color backgroundColor = const Color.fromRGBO(0,0,0,1)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Center(child: child,),
      ),
    );
  }

  Widget showTextApi(String title) {
    return Text(title);
  }

  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }

//constant



  String kaynakTipiCikar(String mustel, int adisyonmasaid, int adisyonmusid, int adisyonaktarim) {

  if (adisyonmasaid > 0) {

    return "Masa";

  }



  if (adisyonmasaid == 0 && adisyonmusid > 0 && adisyonaktarim == 0) {

    return "Paket";

  }



  if (adisyonmasaid == 0 && adisyonmusid > 0 && adisyonaktarim == 2) {

    return "YS";

  }



  if (adisyonaktarim == 5 && adisyonmusid > 0) {

    return "Getir RG";

  }



  if (adisyonaktarim == 5 && adisyonmusid == -2) {

    return "Getir GG";

  }



  if (adisyonaktarim == 6) {

    return "Trendyol Go";

  }



  if (adisyonaktarim == 3) {

    if (mustel.contains("VALE")) {

      return "YS-Vale";

    } else {

      return "YS-GelAl";

    }

  }



  if (adisyonaktarim == 96) {

    return "Trendyol-M1";

  }



  if (adisyonaktarim == 37) {

    return "Migros Yemek";

  }



  if (adisyonaktarim == 8) {

    return "Gofody";

  }



  if (adisyonaktarim == -9) {

    return "Cagri Merkezi";

  }



  if (adisyonmasaid == 0 && adisyonaktarim == -3) {

    return "Web";

  }



  if (adisyonmusid == -2 && adisyonaktarim == 0) {

    return "Gel-Al";

  }



  if (adisyonmusid > 0 && adisyonmasaid == -1) {

    return "Personel";

  }

 

  return "";

}





String siparisDurumuCek(int gelenstatu) {

  if (gelenstatu == -3) {

    return "Iptal";

  }



  if (gelenstatu == 0) {

    return "Yeni Giris";

  }



  if (gelenstatu == 1) {

    return "Bekliyor/hazirlaniyor";

  }



  if (gelenstatu == -1) {

    return "Kuryede";

  }



  if (gelenstatu == -4) {

    return "Firinda";

  }



  if (gelenstatu == -5) {

    return "Siparis Teslime Hazir";

  }



  if (gelenstatu == 2) {

    return "Hesap Kapandi";

  }



  if (gelenstatu == -7) {

    return "Teslim Edildi";

  }



  return "";

}





}
