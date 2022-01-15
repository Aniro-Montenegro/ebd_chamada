import 'package:ebd_chamada/config/padrao-cores.dart';
import 'package:ebd_chamada/modelos/aula.dart';
import 'package:ebd_chamada/modelos/boxes-aulas.dart';
import 'package:ebd_chamada/modelos/boxes-igreja.dart';
import 'package:ebd_chamada/modelos/igreja.dart';
import 'package:ebd_chamada/paginas/ChamadaPage.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';


enum OrderOptions {orderaz, orderza}

class AulasPage extends StatefulWidget {


  @override
  _AulasPageState createState() => _AulasPageState();
}

class _AulasPageState extends State<AulasPage> {




  final DateFormat dataFormatada = DateFormat('dd/MM/yyyy');
  String ordenacao= "z-a";

  final box= BoxesIgrejas.getTransactions();
  Igreja igreja =Igreja.buildIgreja();

  @override
  void initState() {
    box.values.toList().length>0 ? igreja=box.values.toList().first:igreja=Igreja.buildIgreja();
    super.initState();
  }


  List<Aula> aulas = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PadraoCores.cor_fundo_1,
        appBar: AppBar(
          title: Text("Aulas",
            style: TextStyle(
                color: PadraoCores.texto_2, fontWeight: FontWeight.bold),


          ),
      backgroundColor: PadraoCores.gradiente1_1,
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<String>(
              itemBuilder: (context) => <PopupMenuEntry<String>>[
                 PopupMenuItem<String>(
                  child: Text("Ordenar de A-Z",style: TextStyle(color: PadraoCores.texto_1),),
                  value: "a-z",
                ),
                 PopupMenuItem<String>(
                  child: Text("Ordenar de Z-A",style: TextStyle(color: PadraoCores.texto_1),),
                  value: "z-a",
                ),
              ],
              onSelected: _orderList,
            )
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){

            _novaAula();
          },
          child: Icon(Icons.add,color: PadraoCores.gradiente1_1,),
          backgroundColor: PadraoCores.texto_1,
        ),
        body: ValueListenableBuilder<Box<Aula>>(
          valueListenable: BoxesAulas.getTransactions().listenable(),
          builder: (context,box,_){
            final alunosLista=box.values.toList().cast<Aula>();

            aulas=alunosLista;
            print(aulas);
            if(ordenacao=="a-z"){
              ordenarListaAz();
            }
            else{
              ordenarListaZa();
            }




            return buildContent(context);
          },
        )
    );
  }

  buildContent( BuildContext cont){

    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: aulas.length,
        itemBuilder: (cont, index) {
          return _contactCardTableDinamic(cont, index);
        }
    );
  }




  Widget _contactCardTableDinamic(BuildContext context, int index){
    final rows = <TableRow>[];
    rows.add( TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Data ",
          style: TextStyle(fontSize: 22.0,
              fontWeight: FontWeight.bold,color: PadraoCores.texto_2),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(dataFormatada.format(aulas[index].data),
            style: TextStyle(fontSize: 22.0,
                fontWeight: FontWeight.bold,color: PadraoCores.texto_2),
          ),
        ),
      ),

    ]),);
    for(var c in aulas[index].infomarcaoAula){

      rows.add(TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(c.keys.first,
            style: TextStyle(fontSize: 22.0,
                fontWeight: FontWeight.bold,color: PadraoCores.texto_2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(c.values.first.toString(),
              style: TextStyle(fontSize: 22.0,
                  fontWeight: FontWeight.bold,color: PadraoCores.texto_2),
            ),
          ),
        ),

      ]

      ),
      );


    }

    rows.add(TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Oferta",
          style: TextStyle(fontSize: 22.0,
              fontWeight: FontWeight.bold,color: PadraoCores.texto_2),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text("R\$ "+aulas[index].oferta.toString(),
            style: TextStyle(fontSize: 22.0,
                fontWeight: FontWeight.bold,color: PadraoCores.texto_2),
          ),
        ),
      ),

    ]

    ),
    );


    GlobalKey previewContainer = new GlobalKey();
    int originalSize = 800;
    Image image;
    return GestureDetector(
      child: RepaintBoundary(
        key: previewContainer,
        child: Container(
          child: Card(
            color: PadraoCores.cards_1,
            shape:RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(10),),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                color: Colors.transparent,

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(igreja.nomeIgreja,style: TextStyle(color: PadraoCores.texto_1,fontSize: 20),),
                    ),
                    Table(
                      border: TableBorder.all(color: PadraoCores.texto_2),
                      children: rows,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      onTap: (){
        _showOptions(context, index);
      },
      onLongPress: (){
        print("long");
        ShareFilesAndScreenshotWidgets().shareScreenshot(previewContainer, originalSize,"Title",
            "Name.png",
            "image/png",
            text: "Chamada EBD ${dataFormatada.format(aulas[index].data)}!").then((value){
          if(value!=null){
            setState(() {
              image=value;

            });
          }
        });


      },
    );
  }



  void _showOptions(BuildContext context, int index){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return BottomSheet(
            onClosing: (){},

            builder: (context){
              return Container(
                color: PadraoCores.gradiente1_1,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text("Editar",
                          style: TextStyle(color: PadraoCores.texto_2, fontSize: 20.0),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        //  _showContactPage(aluno: aulas[index]);

                          _editAula(aula: aulas[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text("Excluir",
                          style: TextStyle(color: PadraoCores.texto_2, fontSize: 20.0),
                        ),
                        onPressed: (){


                          setState(() {
                            aulas[index].delete();
                            Navigator.pop(context);
                          });

                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
    );
  }
  Future addAula(Aula aula) async {
    final box =BoxesAulas.getTransactions();
    box.add(aula);

    // box.put("key", aluno);


  }

  void editAula(Aula aula){
    aula.save();
  }
  void _editAula({required Aula aula}) async {
    final recAluno  = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChamadaPage(aula: aula,))
    );

    aula.save();
  }

  void _novaAula() async {
    Aula aula= Aula.buildAula();
    final recAluno  = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChamadaPage(aula: aula,))
    );

    print("Esta aqui"+aula.toString());
    if(aula.infomarcaoAula.length>0){
      addAula(aula);
      print("Esta outra aqui aqui"+aula.toString());
    }

  }

  void deleteAula(Aula aula){


    aula.delete();
  }

  void _getAllaulas(){

  }

  void _orderList(String result){
    if(result=="a-z"){
      ordenacao="a-z";
    }
    else{
      ordenacao="z-a";
    }
    setState(() {

    });
  }

  ordenarListaAz(){
    aulas.sort((a, b) {

              return a.data.millisecondsSinceEpoch.compareTo(b.data.millisecondsSinceEpoch);
            });

  }

  ordenarListaZa(){
    aulas.sort((a, b) {

    return b.data.millisecondsSinceEpoch.compareTo(a.data.millisecondsSinceEpoch);
    });

  }

  // void _orderList(OrderOptions result){
  //
  //   var aulas=BoxesAulas.getTransactions().listenable() as List<Aula>;
  //
  //   print(result);
  //   switch(result){
  //     case OrderOptions.orderaz:
  //       aulas.sort((a, b) {
  //         print(a.data.millisecondsSinceEpoch.compareTo(b.data.millisecondsSinceEpoch));
  //         return a.data.millisecondsSinceEpoch.compareTo(b.data.millisecondsSinceEpoch);
  //       });
  //       break;
  //     case OrderOptions.orderza:
  //       aulas.sort((a, b) {
  //         print(b.data.millisecondsSinceEpoch.compareTo(a.data.millisecondsSinceEpoch));
  //         return b.data.millisecondsSinceEpoch.compareTo(a.data.millisecondsSinceEpoch);
  //       });
  //       break;
  //   }
  //
  //   setState(() {
  //
  //
  //   });
  //
  // }

}