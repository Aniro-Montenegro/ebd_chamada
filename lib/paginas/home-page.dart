
import 'package:ebd_chamada/config/padrao-cores.dart';
import 'package:ebd_chamada/modelos/aula.dart';
import 'package:ebd_chamada/modelos/boxes-aulas.dart';
import 'package:ebd_chamada/modelos/boxes-igreja.dart';
import 'package:ebd_chamada/modelos/igreja.dart';
import 'package:ebd_chamada/paginas/AulasPage.dart';
import 'package:ebd_chamada/paginas/ChamadaPage.dart';
import 'package:ebd_chamada/paginas/estatisticas.dart';
import 'package:ebd_chamada/widgets/clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final box= BoxesIgrejas.getTransactions();

  TextEditingController igrejaController = new TextEditingController();

  Igreja igreja =Igreja.buildIgreja();

  Future addAula(Aula aula) async {
    final box =BoxesAulas.getTransactions();
    box.add(aula);

    // box.put("key", aluno);


  }
  Future addIgreja(Igreja igreja) async {


    final box =BoxesIgrejas.getTransactions();

    if(box.length>0){
      box.putAt(0, igreja);
    }
    else{
      box.add(igreja);
    }




    // box.put("key", aluno);


  }

  void _novaAula() async {
    Aula aula= Aula.buildAula();
    final recAluno  = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChamadaPage(aula: aula,))
    );

    addAula(aula);

  }

  @override
  void initState() {
   setState(() {

     print(box.values.toList());
     box.values.toList().length>0 ? igreja=box.values.toList().first:igreja=Igreja.buildIgreja();
   });

    super.initState();
  }


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
                  crossAxisCellCount: 4,
                  mainAxisCellCount: 2,
                  child: GestureDetector(
                    child: Card(
                        color: PadraoCores.cards_1,
                        shape:RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),),
                        elevation: 5.0,
                        child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                igreja.nomeIgreja,
                                style: TextStyle(
                                    color: PadraoCores.texto_1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ))),
                    onTap: (){

                      _displayNomeIgreja(context);

                    },


                  ),


                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: GestureDetector(
                    child: Card(
                        color: PadraoCores.cards_1,
                        shape:RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),),
                        elevation: 5.0,
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
                          shape:RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),),
                          elevation: 5.0,
                          child: Center(
                              child: Text("Chamada",
                                  style: TextStyle(
                                      color: PadraoCores.texto_1,

                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)))),
                    onTap: (){


                      _novaAula();
                    },
                    )),
                StaggeredGridTile.count(
                    crossAxisCellCount: 4,
                    mainAxisCellCount: 2,
                    child: GestureDetector(
                      child: Card(
                          color: PadraoCores.cards_1,
                          shape:RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),),
                          elevation: 5.0,
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

  Future<void> _displayNomeIgreja(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          igrejaController.text="";
          return AlertDialog(

            backgroundColor: PadraoCores.gradiente1_2,



            title: Text('Digite o nome de sua igreja',style: TextStyle(color: PadraoCores.texto_1),),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  igreja.nomeIgreja=value;
                });
              },
              controller: igrejaController,
              decoration: InputDecoration(
                focusColor: PadraoCores.texto_1,
                fillColor:PadraoCores.texto_1,
                hoverColor: PadraoCores.texto_1,


              ),
              cursorColor: PadraoCores.texto_1,
              style: TextStyle(color:PadraoCores.texto_1, ),
              keyboardType: TextInputType.text,
              autofocus: true,
              showCursor: true,

            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                //color: Colors.red,
                //textColor: Colors.white,
                child: Text('Sair',style: TextStyle(color: PadraoCores.texto_1),),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              // ignore: deprecated_member_use
              FlatButton(
                //color: Colors.green,
                //textColor: Colors.white,
                child: Text('Gravar',style: TextStyle(color: PadraoCores.texto_1),),
                onPressed: () {
                  setState(() {

                    addIgreja(igreja);

                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}


