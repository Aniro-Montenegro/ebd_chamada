

import 'package:ebd_chamada/config/padrao-cores.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'line_title.dart';

class LineChartWidget extends StatelessWidget {


  final List<Color> gradientColor=[
    PadraoCores.gradiente1,
    PadraoCores.gradiente1_2
  ];

  @override
  Widget build(BuildContext context) => LineChart(
    LineChartData(

      minX: 0,
      maxX: 3,
      minY: 0,
      maxY: 200,

      titlesData: LineTitles.getTitleData(),
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value){
       return   FlLine(
            color: PadraoCores.texto_2,
         strokeWidth: 1
          );
        },
        drawVerticalLine: true,
        getDrawingVerticalLine: (value){
          return FlLine(
            color: PadraoCores.texto_2,
            strokeWidth: 1
          );
        }

      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: PadraoCores.gradiente1)
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 90),
            FlSpot(1, 100),
            FlSpot(2, 150),
            FlSpot(3, 90),

          ],
          isCurved: true,
          colors: [
            PadraoCores.gradiente2_1,
            PadraoCores.gradiente2_2
          ],
          barWidth: 5,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
           colors: gradientColor.map((color) => color.withOpacity(0.3)).toList()
          )


        )
      ]


    )
  );


}
