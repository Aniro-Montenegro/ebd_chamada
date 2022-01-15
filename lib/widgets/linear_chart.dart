

import 'package:ebd_chamada/config/padrao-cores.dart';
import 'package:ebd_chamada/modelos/aula.dart';
import 'package:ebd_chamada/modelos/boxes-aulas.dart';
import 'package:ebd_chamada/modelos/boxes-igreja.dart';
import 'package:ebd_chamada/modelos/igreja.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'line_title.dart';

class LineChartWidget extends StatefulWidget {


  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  final List<Color> gradientColor=[
    PadraoCores.gradiente1,
    PadraoCores.gradiente1_2
  ];

  List<FlSpot> spots=[];
  List<Aula> aulas=[];
  List<Aula> aulasAux=[];

  List<String> datas=[];

  final box= BoxesAulas.getTransactions();



  final DateFormat dataFormatada = DateFormat('dd/MM/yyyy');
  final DateFormat dataFormatada2 = DateFormat('dd/MM');
  int tam=0;
  int tamLista=0;

  @override
  void initState() {

    aulas=box.values.toList();
    aulas.sort((a, b) {

      return a.data.millisecondsSinceEpoch.compareTo(b.data.millisecondsSinceEpoch);
    });
    tamLista=aulas.length;



    if(tamLista>4){

      aulasAux=aulas;
      aulas=[];

        aulas=aulasAux.reversed.toList().sublist(0,4).reversed.toList();
      for(int x=0;x<aulas.length;x++){
        var s= FlSpot(double.parse(x.toString()), double.parse(aulas[x].total.toString()));
        setState(() {
          spots.add(s);

          datas.add(dataFormatada2.format(aulas[x].data));
        });
        aulas[x].total>=tam? tam=aulas[x].total: tam=tam;
      }

      tamLista=3;
    }
    else{
      for(int x=0;x<aulas.length;x++){
        var s= FlSpot(double.parse(x.toString()), double.parse(aulas[x].total.toString()));
        setState(() {
          spots.add(s);

          datas.add(dataFormatada2.format(aulas[x].data));
        });
        aulas[x].total>=tam? tam=aulas[x].total: tam=tam;
      }
      tamLista=aulas.length-1;
      print(tamLista);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) => LineChart(

    LineChartData(


      minX: 0,
      maxX: double.parse(tamLista.toString()),
      minY: 0,
      maxY: double.parse(tam.toString())+10,

      titlesData: LineTitles.getTitleData(datas),



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
          spots: spots,
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
