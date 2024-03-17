//model

class Adisyon {
  final int adisyonid;
  final String adisyondealer;
  final int adisyonyil;
  final int adisyonay;
  final int adisyonmasaid;
  final int adisyongun;
  final int adisyonno;
  final int adisyongenelno;
  final String adisyonuname;
  final int adisyontarihnew;
  final AdisyonTarih adisyontarih;
  final int adisyonstatu;
  final bool adisyoniptalmi;
  final String adisyoniptaluser;
  final dynamic adisyoniptaltarihi;
  final double adisyontoplamvergioncesi;
  final double adisyontoplamvergi;
  final double adisyontoplam;
  final String adisyonmusteri;
  final int adisyonmusid;
  final String adisyonmustel;
  final int adisyonmusterisayisi;
  final int adisyonaktarim;

  Adisyon({
    required this.adisyonid,
    required this.adisyondealer,
    required this.adisyonyil,
    required this.adisyonay,
    required this.adisyonmasaid,
    required this.adisyongun,
    required this.adisyonno,
    required this.adisyongenelno,
    required this.adisyonuname,
    required this.adisyontarihnew,
    required this.adisyontarih,
    required this.adisyonstatu,
    required this.adisyoniptalmi,
    required this.adisyoniptaluser,
    required this.adisyoniptaltarihi,
    required this.adisyontoplamvergioncesi,
    required this.adisyontoplamvergi,
    required this.adisyontoplam,
    required this.adisyonmusteri,
    required this.adisyonmusid,
    required this.adisyonmustel,
    required this.adisyonmusterisayisi,
    required this.adisyonaktarim,
  });

  factory Adisyon.fromJson(Map<String, dynamic> json) {
    return Adisyon(
      adisyonid: json['adisyonid'],
      adisyondealer: json['adisyondealer'],
      adisyonyil: json['adisyonyil'],
      adisyonay: json['adisyonay'],
      adisyonmasaid: json['adisyonmasaid'],
      adisyongun: json['adisyongun'],
      adisyonno: json['adisyonno'],
      adisyongenelno: json['adisyongenelno'],
      adisyonuname: json['adisyonuname'],
      adisyontarihnew: json['adisyontarihnew'],
      adisyontarih: AdisyonTarih.fromJson(json['adisyontarih']),
      adisyonstatu: json['adisyonstatu'],
      adisyoniptalmi: json['adisyoniptalmi'],
      adisyoniptaluser: json['adisyoniptaluser'],
      adisyoniptaltarihi: json['adisyoniptaltarihi'],
      adisyontoplamvergioncesi: json['adisyontoplamvergioncesi'],
      adisyontoplamvergi: json['adisyontoplamvergi'],
      adisyontoplam: json['adisyontoplam'],
      adisyonmusteri: json['adisyonmusteri'],
      adisyonmusid: json['adisyonmusid'],
      adisyonmustel: json['adisyonmustel'],
      adisyonmusterisayisi: json['adisyonmusterisayisi'],
      adisyonaktarim: json['adisyonaktarim'],
    );
  }
  
  
}


class AdisyonTarih {
  final int dayOfMonth;
  final int hour;
  final int minute;
  final String month;
  final int monthValue;

  AdisyonTarih({
    required this.dayOfMonth,
    required this.hour,
    required this.minute,
    required this.month,
    required this.monthValue,
  });

  factory AdisyonTarih.fromJson(Map<String, dynamic> json) {
    return AdisyonTarih(
      dayOfMonth: json['dayOfMonth'],
      hour: json['hour'],
      minute: json['minute'],
      month: json['month'],
      monthValue: json['monthValue'],
    );
  }

  
}
