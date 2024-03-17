//Tablo
import 'package:flutter/material.dart';
import '../Constant/ShareFunctions.dart';
import '../Models/AdisyonListesi.dart';

class AdisyonListesiTable extends StatelessWidget {
  final List<Adisyon> adisyonListesi;

  AdisyonListesiTable({required this.adisyonListesi});



  @override
  Widget build(BuildContext context) {

    return DataTable(
      columnSpacing: 10,
      headingTextStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Başlık metin rengi beyaz olarak ayarlanır
      columns: const [
      DataColumn(label: Text('Numara')),
      DataColumn(label: Text('Durum')),
       DataColumn(label: Text('Kaynak')),
      DataColumn(label: Text('Müsteri')),
        
      ],
      rows: adisyonListesi
          .map(
            (adisyon) => DataRow(cells: [
              DataCell(
                Text(
                   adisyon.adisyonid.toString(),
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Metin rengi beyaz olarak ayarlanır
                ),
              ),
              DataCell(
                Text(
                  shareFunction().siparisDurumuCek(adisyon.adisyonstatu),
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Metin rengi beyaz olarak ayarlanır
                ),
              ),
              DataCell(
                Text(
                  shareFunction().kaynakTipiCikar(adisyon.adisyonmustel, adisyon.adisyonmasaid, adisyon.adisyonmusid, adisyon.adisyonaktarim),
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Metin rengi beyaz olarak ayarlanır
                ),
              ),
              DataCell(
                Text(
                  adisyon.adisyonmusteri,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Metin rengi beyaz olarak ayarlanır
                ),
              ),
             
            ]),
          )
          .toList(),
    );
  }
}
