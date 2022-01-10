

import 'package:flutter/material.dart';

class Calendario{

  DateTime selectedDate = DateTime.now();

  Future<DateTime?> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 12),
        lastDate: DateTime(2101));

        return picked;

  }
}