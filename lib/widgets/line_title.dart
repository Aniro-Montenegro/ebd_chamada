
import 'package:ebd_chamada/config/padrao-cores.dart';
import 'package:ebd_chamada/modelos/aula.dart';
import 'package:ebd_chamada/modelos/boxes-aulas.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LineTitles{

  List<Aula> aulas=[];




  static getTitleData(List<String> lista)=> FlTitlesData(
    show: true,

    bottomTitles: SideTitles(
      showTitles: true,
      margin: 15,
      interval: 1.0,

        getTextStyles: (context, value) {
          return TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: PadraoCores.texto_1
          );
        },


      getTitles: (value) {
        switch (value.toInt()){
          case 0:
            return lista[0];
          case 1:
            return lista[1];
          case 2:
            return lista [2];
          case 3:
            return lista[3];
          default:
            return "Data";
        }
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

    rightTitles: SideTitles(
      showTitles: true,
        reservedSize: 35,
        margin: 12,
      getTextStyles: (context, value) {
        return TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: PadraoCores.texto_1
        );
      },

    )
  );

}