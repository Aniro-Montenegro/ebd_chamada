
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles{

  static getTitleData()=> FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      margin: 15,
      interval: 1.0,
      getTitles: (value){
        return "Aulas";
      },

      reservedSize: 35,
    ),
    topTitles: SideTitles(
      showTitles: false,
    ),
    leftTitles: SideTitles(
      showTitles: false,
      reservedSize: 35,
      margin: 12
    ),
  );

}