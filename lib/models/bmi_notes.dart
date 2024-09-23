import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BmiNote {
  final String _id = UniqueKey().toString();
  final DateTime _date;
  final double _bmiValue;

  BmiNote(this._date, this._bmiValue);

  String get id => _id;

  String get date => DateFormat('dd/MM/yyyy').format(_date);

  double get bmiValue => _bmiValue;
}
