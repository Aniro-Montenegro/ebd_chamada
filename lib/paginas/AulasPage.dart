import 'package:ebd_chamada/config/padrao-cores.dart';
import 'package:ebd_chamada/modelos/aula.dart';
import 'package:ebd_chamada/modelos/boxes-aulas.dart';
import 'package:ebd_chamada/paginas/ChamadaPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';


enum OrderOptions {orderaz, orderza}

class AulasPage extends StatefulWidget {


  @override
  _AulasPageState createState() => _AulasPageState();
}

class _AulasPageState extends State<AulasPage> {

  final DateFormat dataFormatada = DateFormat('dd/MM/yyyy');

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
            PopupMenuButton<OrderOptions>(
              itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                 PopupMenuItem<OrderOptions>(
                  child: Text("Ordenar de A-Z",style: TextStyle(color: PadraoCores.texto_1),),
                  value: OrderOptions.orderaz,
                ),
                 PopupMenuItem<OrderOptions>(
                  child: Text("Ordenar de Z-A",style: TextStyle(color: PadraoCores.texto_1),),
                  value: OrderOptions.orderza,
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

            print(alunosLista);


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
          return _contactCardTable(cont, index);
        }
    );
  }

  Widget _contactCard(BuildContext context, int index){

    return GestureDetector(
      child: Card(
        color: PadraoCores.cards_1,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(dataFormatada.format(aulas[index].data),
                      style: TextStyle(fontSize: 22.0,
                          fontWeight: FontWeight.bold,color: PadraoCores.texto_2),
                    ),

                    Text("Homens: " +aulas[index].adultosHomens.toString() ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                    Text("Mulheres: " +aulas[index].adultosMulheres.toString() ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                    Text("Jovens: " +aulas[index].jovens.toString() ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                    Text("Adolescentes: " +aulas[index].adolescentes.toString() ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                    Text("Crianças: " +aulas[index].criancas.toString() ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                    Text("Visitantes: " +aulas[index].visitantes.toString() ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                    Text("Oferta R\$: " +aulas[index].oferta.toString() ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: (){
        _showOptions(context, index);
      },
    );
  }
  Widget _contactCardTable(BuildContext context, int index){

    return GestureDetector(
      child: Card(
        color: PadraoCores.cards_1,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            color: Colors.transparent,

            child: Table(
              border: TableBorder.all(color: PadraoCores.texto_2),
              children: [
                TableRow(children: [
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

                ]),
                TableRow(children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Homens" ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(aulas[index].adultosHomens.toString() ,
                        style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                      ),
                    ),
                  ),

                ],
                ),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Mulheres" ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(aulas[index].adultosMulheres.toString() ,
                        style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                      ),
                    ),
                  ),

                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Jovens" ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(aulas[index].jovens.toString() ,
                        style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                      ),
                    ),
                  ),

                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Adolescentes" ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(aulas[index].adolescentes.toString() ,
                        style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                      ),
                    ),
                  ),

                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Crianças" ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(aulas[index].criancas.toString() ,
                        style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                      ),
                    ),
                  ),

                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Visitantes" ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(aulas[index].visitantes.toString() ,
                        style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                      ),
                    ),
                  ),

                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Total" ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(aulas[index].total.toString() ,
                        style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                      ),
                    ),
                  ),

                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Oferta" ,
                      style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("R\$ "+aulas[index].oferta.toString() ,
                        style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                      ),
                    ),
                  ),

                ]),
              ],
            ),
          ),
        ),
      ),
      onTap: (){
        _showOptions(context, index);
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

    addAula(aula);

  }

  void deleteAula(Aula aula){


    aula.delete();
  }

  void _getAllaulas(){

  }

  void _orderList(OrderOptions result){
    switch(result){
      case OrderOptions.orderaz:
        aulas.sort((a, b) {
          return a.data.compareTo(b.data);
        });
        break;
      case OrderOptions.orderza:
        aulas.sort((a, b) {
          return b.data.compareTo(a.data);
        });
        break;
    }
    

  }

}