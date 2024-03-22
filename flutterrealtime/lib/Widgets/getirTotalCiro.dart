import 'package:flutter/material.dart';
import '../Models/GetirTotalCiro.dart';

class MyTableWidget extends StatelessWidget {
  final List<GetirTotalCiro> totalCiroList;
  late List<bool> selected;

  MyTableWidget({required this.totalCiroList});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: DataTable(
      columnSpacing: 5,
      headingTextStyle: TextStyle(
          color: const Color.fromARGB(
              255, 0, 0, 0)), // Başlık metin rengi beyaz olarak ayarlanır
      columns: [
        DataColumn(label: Text('Ciro')),
        DataColumn(label: Text('C/F')),
        DataColumn(label: Text('Fis')),
        DataColumn(label: Text('Adı')),
        DataColumn(label: Text('Sep.Ort.')),
      ],
      rows: totalCiroList
          .map(
            (ciro) => DataRow(
                cells: [
                  DataCell(
                    Text(
                      ciro.adCiro.toStringAsFixed(2),
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0,
                              0)), // Metin rengi beyaz olarak ayarlanır
                    ),
                  ),
                  DataCell(
                    Text(
                      ciro.adsubeTip == 'Corporate'
                          ? 'C'
                          : (ciro.adsubeTip == 'Franchise' ? 'F' : ''),
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0,
                              0)), // Metin rengi beyaz olarak ayarlanır
                    ),
                  ),
                  DataCell(
                    Text(
                      ciro.adFis.toString(),
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0,
                              0)), // Metin rengi beyaz olarak ayarlanır
                    ),
                  ),
                  DataCell(
                    Text(
                      ciro.adsubeName.replaceFirst('SB-', ''),
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0,
                              0)), // Metin rengi beyaz olarak ayarlanır
                    ),
                  ),
                  DataCell(
                    Text(
                      ciro.adSepetOrt.toStringAsFixed(2),
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0,
                              0)), // Metin rengi beyaz olarak ayarlanır
                    ),
                  ),
                ],
                selected: selected[index],
                onSelectChanged: (bool? value) {
                  setState(() {
                    selected[index] = value!;
                  });
                }),
          )
          .toList(),
    ));
  }
}
