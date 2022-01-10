import 'package:ebd_chamada/config/padrao-cores.dart';
import 'package:ebd_chamada/modelos/aula.dart';
import 'package:ebd_chamada/modelos/boxes-aulas.dart';
import 'package:ebd_chamada/widgets/linear_chart.dart';



import 'package:flutter/material.dart';

class EstatisticasPage extends StatefulWidget {


  @override
  _EstatisticasPageState createState() => _EstatisticasPageState();
}

class _EstatisticasPageState extends State<EstatisticasPage> {

  List<Aula> aulas=[];

  final box= BoxesAulas.getTransactions();



  @override
  void initState() {

    aulas=box.values.toList();
    print(aulas);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PadraoCores.cor_fundo_1,
        appBar: AppBar(
          title: Text("Estatisticas",
            style: TextStyle(
                color: PadraoCores.texto_2, fontWeight: FontWeight.bold),


          ),
          backgroundColor: PadraoCores.gradiente1_1,
          centerTitle: true,

        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(

            child: LineChartWidget(),


          ),
        )
    );
  }
}



