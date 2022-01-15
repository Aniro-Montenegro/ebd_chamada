import 'package:ebd_chamada/config/padrao-cores.dart';
import 'package:ebd_chamada/modelos/aula.dart';
import 'package:ebd_chamada/modelos/boxes-classes.dart';
import 'package:ebd_chamada/modelos/classe-alunos.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'EditClassePage.dart';


enum OrderOptions {orderaz, orderza}

class ClassesPage extends StatefulWidget {


  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {





  String ordenacao= "z-a";

  final box= BoxesClasses.getTransactions();
  List<ClasseAlunos> classes =[];

  @override
  void initState() {
    box.values.toList().length>0 ? classes=box.values.toList() : classes=[];
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PadraoCores.cor_fundo_1,
        appBar: AppBar(
          title: Text("Classes",
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

            _novaClasse();
          },
          child: Icon(Icons.add,color: PadraoCores.gradiente1_1,),
          backgroundColor: PadraoCores.texto_1,
        ),
        body: ValueListenableBuilder<Box<ClasseAlunos>>(
          valueListenable: BoxesClasses.getTransactions().listenable(),
          builder: (context,box,_){
            final alunosLista=box.values.toList().cast<ClasseAlunos>();

            classes=alunosLista;

            print(classes);
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
        itemCount: classes.length,
        itemBuilder: (cont, index) {
          return _classesCard(cont, index);
        }
    );
  }

  Widget _classesCard(BuildContext context, int index){

    return GestureDetector(
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.1,
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


                      Text(classes[index].nome_classe ,
                        style: TextStyle(fontSize: 18.0,color: PadraoCores.texto_2),
                      ),


                    ],
                  ),
                )
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

                          _editClasse(classe: classes[index]);
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
                            classes[index].delete();
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
  Future addClasse(ClasseAlunos classe) async {
    final box =BoxesClasses.getTransactions();
    box.add(classe);

    // box.put("key", aluno);


  }

  void editClasse(Aula aula){
    aula.save();
  }
  void _editClasse({required ClasseAlunos classe}) async {
    final recAluno  = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditClassePage(classe: classe,))
    );

    classe.save();
  }

  void _novaClasse() async {
    ClasseAlunos classe= ClasseAlunos.buildClasse();
    final recAluno  = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditClassePage(classe: classe,))
    );

    print(classe.nome_classe+" "+classe.id_classe.toString());
     if(classe.nome_classe!=""){
      addClasse(classe);
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
    classes.sort((a, b) {

              return a.nome_classe.compareTo(b.nome_classe);
            });

  }

  ordenarListaZa(){
    classes.sort((a, b) {

    return b.nome_classe.compareTo(a.nome_classe);
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