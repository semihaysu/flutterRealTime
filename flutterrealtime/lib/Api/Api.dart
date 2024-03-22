import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterrealtime/Constant/Constant.dart';
import 'package:flutterrealtime/Models/AdisyonListesi.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../Models/Bayi.dart';
import '../Models/GetirTotalCiro.dart';

class Api {
  Future<List<Bayi>> getiriliskiliBayiListesi(
      String userdealer, String isletme, String uname) async {
    var response = await http.post(
      Uri.parse(
          '$isletme/Yonetim/GetiliskilisubeListesiApp?dealer=$userdealer&username=$uname'),
      headers: <String, String>{
        'authorization': Constant().getbase64Authentication()
      },
    );
    print(
        "$isletme/Yonetim/GetiliskilisubeListesiApp?dealer=$userdealer&username=$uname");

    if (response.statusCode == 200) {
      List<dynamic> dinamik = jsonDecode(response.body);

      // Veri alındıysa ve dizi boş değilse
      if (dinamik.isNotEmpty) {
        List<Bayi> bayi = dinamik.map((json) => Bayi.fromJson(json)).toList();
        return bayi;
      } else {
        // Dizi boşsa, boş bir liste döndür
        return [];
      }
    } else {
      throw Exception('Hata!');
    }
  }

  Future<List<Adisyon>> getirAdisyonListesi(
      String raporrealtimebayisec,
      String bastar,
      String bittar,
      String kaynak,
      String durum,
      String isletme) async {
    var response = await http.post(
      Uri.parse(
          '$isletme/Yonetim/GetirAnalizRaporAdisyonListesi?raporrealtimebayisec=$raporrealtimebayisec&bastar=$bastar&bittar=$bittar&kaynak=$kaynak&durum=$durum'),
      headers: <String, String>{
        'authorization': Constant().getbase64Authentication()
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> dinamik = jsonDecode(response.body);

      // Veri alındıysa ve dizi boş değilse
      if (dinamik.isNotEmpty) {
        List<Adisyon> adisyon =
            dinamik.map((json) => Adisyon.fromJson(json)).toList();
        return adisyon;
      } else {
        // Dizi boşsa, boş bir liste döndür
        return [];
      }
    } else {
      throw Exception('Hata!');
    }
  }

  Future<List<GetirTotalCiro>> getirTotalCiro(
      String userdealer,
      String username,
      String raporrealtimebayisec,
      String siparisrapordetaytarih,
      String isletme) async {
    var response = await http.post(
        Uri.parse(
            '$isletme/Yonetim/GetirTotalCiroApp?userdealer=sbm000&username=$username&raporrealtimebayisec=$raporrealtimebayisec&siparisrapordetaytarih=$siparisrapordetaytarih'),
        headers: <String, String>{
          'authorization': Constant().getbase64Authentication()
        });
    //var response = await http.get(  "http://sb.saloonburger.com.tr/v1/",headers: <String, String>{'authorization': basicAuth},
    print(
        "$isletme/Yonetim/GetirTotalCiroApp?userdealer=sbm000&username=$username&raporrealtimebayisec=$raporrealtimebayisec&siparisrapordetaytarih=$siparisrapordetaytarih");
    if (response.statusCode == 200) {
      List<dynamic> dinamik = jsonDecode(response.body);
      List<GetirTotalCiro> totalciro =
          dinamik.map((json) => GetirTotalCiro.fromJson(json)).toList();

      return totalciro;
    } else {
      // Dizi boşsa, boş bir liste döndür
      return [];
    }
  }

  Future<String> fetchloginkontrol(
      String email, String password, String? isletme) async {
    var response = await http.get(
        Uri.parse('$isletme/v1/UserKontrol?uname=$email&upass=$password'),
        //http://sb.saloonburger.com.tr

        headers: <String, String>{
          'authorization': Constant().getbase64Authentication()
        });
    //var response = await http.get(  "http://sb.saloonburger.com.tr/v1/",headers: <String, String>{'authorization': basicAuth},

    if (response.statusCode == 200 && response.body.contains("true")) {
      // JSON verisini müzik nesnesine dönüştür

      String gelenbody = response.body; //true,Saloon Burger .Merkez,sbm000

      gelenbody = gelenbody.replaceAll("true,", "");

      return gelenbody;
    } else {
      throw "Kullanıcı Bulunamadı";
    }
  }

  Future<List<int>> GetirSiparisGrafikSiparis(String raporrealtimebayisec,
      String siparisrapordetaytarih, String isletme) async {
    var response = await http.post(
        Uri.parse(
            '$isletme/v1/Yonetim/GetirSiparisGrafikSiparis?raporrealtimebayisec=$raporrealtimebayisec&siparisrapordetaytarih=$siparisrapordetaytarih'),
        //http://sb.saloonburger.com.tr
        headers: <String, String>{
          'authorization': Constant().getbase64Authentication()
        });
    if (response.statusCode == 200) {
      // JSON verisini müzik nesnesine dönüştür
      String gelenbody = response.body; //true,Saloon Burger .Merkez,sbm000

      List<String> gelen = gelenbody.split('+');
      List<int> intList = [];

      for (String part in gelen) {
        int? value = int.tryParse(
            part.trim()); // Tamsayıya dönüştür, trim ile boşlukları kaldır
        if (value != null) {
          intList.add(value);
        }
      }
      return intList;
    } else {
      throw "Veri Bulunamadı";
    }
  }

  Future<List<Bayi>> bayigetir(String isletme, String dealer) async {
    var response = await http.get(
        Uri.parse(
            '$isletme/Yonetim/GetiliskilisubeListesi?headersubeselect=$dealer'),
        headers: <String, String>{
          'authorization': Constant().getbase64Authentication()
        });
    print(response.statusCode);

    if (response.statusCode == 200 && response.body.contains("true")) {
      List<dynamic> bayi = jsonDecode(response.body);
      List<Bayi> bayiler = bayi.map((json) => Bayi.fromJson(json)).toList();

      return bayiler;
    } else {
      throw "Bayi Bulunamadı";
    }
  }
}
