
import 'package:ebd_chamada/config/padrao-cores.dart';
import 'package:ebd_chamada/modelos/aula.dart';
import 'package:ebd_chamada/paginas/AulasPage.dart';
import 'package:ebd_chamada/paginas/ChamadaPage.dart';
import 'package:ebd_chamada/paginas/estatisticas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PadraoCores.cor_fundo_1,
        appBar: AppBar(
          title: Text(
            "EBD",
            style: TextStyle(
                color: PadraoCores.texto_2, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: PadraoCores.gradiente1_1,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,

              children: [
                StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: GestureDetector(
                      child: Card(
                          color: PadraoCores.cards_1,
                          child: Center(
                              child: Text(
                                "Aulas",
                                style: TextStyle(
                                    color: PadraoCores.texto_1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ))),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AulasPage()),
                        );
                      },
                    ),


                ),
                StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: GestureDetector(
                      child: Card(
                          color: PadraoCores.cards_1,
                          child: Center(
                              child: Text("Chamada",
                                  style: TextStyle(
                                      color: PadraoCores.texto_1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)))),
                    onTap: (){

                        Aula aula=Aula.buildAula();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChamadaPage(aula:aula)),
                      );
                    },
                    )),
                StaggeredGridTile.count(
                    crossAxisCellCount: 4,
                    mainAxisCellCount: 2,
                    child: GestureDetector(
                      child: Card(
                          color: PadraoCores.cards_1,
                          child: Center(
                              child: Text("Estatísticas",
                                  style: TextStyle(
                                      color: PadraoCores.texto_1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)))),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EstatisticasPage()),
                        );
                      },
                    ),
                ),

              ],
            ),
          ),
        ));
  }
}