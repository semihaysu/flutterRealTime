import 'package:flutter/material.dart';

typedef DropdownCallback = void Function(String? selectedValue);

class DropdownItem extends StatefulWidget {
  final DropdownCallback? onChanged;

  const DropdownItem({Key? key, this.onChanged}) : super(key: key);
  @override
  _DropdownItemState createState() => _DropdownItemState();
}

class _DropdownItemState extends State<DropdownItem> {
  final _dropdownFormKey = GlobalKey<FormState>();

  String? seciliDeger;

  List<DropdownMenuItem<String>> get dropdownOgeleri {
    return [
      DropdownMenuItem(
        child: Row(
          children: [
            Icon(Icons.fastfood),
            SizedBox(width: 8),
            Text("Saloon Burger"),
          ],
        ),
        value: "http://sb.saloonburger.com.tr",
      ),
      DropdownMenuItem(
        child: Row(
          children: [
            Icon(Icons.local_pizza),
            SizedBox(width: 8),
            Text("Pizza Lazza"),
          ],
        ),
        value: "Pizza Lazza",
      ),
      DropdownMenuItem(
        child: Row(
          children: [
            Icon(Icons.local_pizza),
            SizedBox(width: 8),
            Text("Pizza V"),
          ],
        ),
        //http://195.87.222.67:8080/easycoProPizzaV-0.0.1
        //http://172.16.127.123:8080/easycoProPizzaV/
        value: "http://195.87.222.67:8080/easycoProPizzaV-0.0.1",
      ),
    ];
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
                  color: Color.fromARGB(255, 0, 0, 0),
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            items: dropdownOgeleri,
            hint: const Center(child: Text("İşletmeyi Seçiniz")),
          ),
        ],
      ),
    );
  }
}
