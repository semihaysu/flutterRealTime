import 'package:flutter/material.dart';
import 'package:flutterrealtime/Pages/HomePage.dart';
import 'package:flutterrealtime/Providers/Providers/UserProvider.dart';
import 'package:provider/provider.dart';

class DateSelector extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  DateSelector({required this.onDateSelected});

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late DateTime selectedDate; // Change here

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _selectDate(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      widget.onDateSelected(selectedDate);
    }
    Provider.of<UserProvider>(context, listen: false)
        .setDate("${selectedDate.toLocal()}".split(' ')[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextButton.icon(
          onPressed: () {
            _selectDate(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.white, // Siyah buton rengi
          ),
          label: Text("${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(color: Colors.deepOrange)),
          icon: Icon(Icons.date_range),
        ),
      ],
    );
  }
}
