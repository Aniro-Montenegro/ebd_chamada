


import 'package:ebd_chamada/config/padrao-cores.dart';
import 'package:ebd_chamada/modelos/aula.dart';

import 'package:ebd_chamada/modelos/boxes-classes.dart';
import 'package:ebd_chamada/modelos/classe-alunos.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class ChamadaPage extends StatefulWidget {

  final Aula aula;

  ChamadaPage({required this.aula});
  @override
  _ChamadaPageState createState() => _ChamadaPageState();
}

class _ChamadaPageState extends State<ChamadaPage> {



  Aula editedAula = Aula.buildAula();

  final box= BoxesClasses.getTransactions();
  List<ClasseAlunos> classes =[];
  final DateFormat dataFormatada = DateFormat('dd/MM/yyyy');





  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final  selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),



    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        editedAula.data=selectedDate;
      });
  }


  TextEditingController ageController = new TextEditingController();


List<StaggeredGridTile> grids=[];

  @override
  void initState() {
    print(widget.aula);
    classes=[];

    box.values.toList().length>0 ? classes=box.values.toList() : classes=[];
    if(widget.aula.infomarcaoAula.length>0){
      for(var m in widget.aula.infomarcaoAula){
        for(var c in classes){
          if(m.keys.first==c.nome_classe){
            c.quantidade_alunos=m.values.first;
          }
        }
      }
      widget.aula.infomarcaoAula=[];
    }


    setState(() {
      editedAula=widget.aula;

    });

    grids.add(StaggeredGridTile.count(
        crossAxisCellCount: 4,
        mainAxisCellCount: 4,
        child: GestureDetector(
          onTap: (){
            _selectDate(context);

          },
          child: Card(
              color: PadraoCores.cards_1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ListTile(

                        leading:  Text(dataFormatada.format(editedAula.data),style: TextStyle(color: PadraoCores.texto_1,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),)
                    ),
                  ),
                  Text(
                    "Data",
                    style: TextStyle(
                        color: PadraoCores.texto_1,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: ListTile(

                      trailing:  Icon(Icons.calendar_today_rounded, color: PadraoCores.texto_1,size: 25,),
                    ),
                  ),
                ],
              )),
        )),);


    for( var a in classes){

setState(() {
  grids.add(StaggeredGridTile.count(
      crossAxisCellCount: 4,
      mainAxisCellCount: 4,

      child: Card(
          color: PadraoCores.cards_1,
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ListTile(


                  trailing:  InkWell(child: Icon(Icons.add, color: PadraoCores.texto_1,size: 25,),onTap: (){
                    setState(() {
                      print(a.quantidade_alunos.toString());
                      a.quantidade_alunos+=1;

                      editedAula.total+=1;

                    });
                  },



                  ),
                  leading: Text(a.quantidade_alunos.toString(),style: TextStyle(
                      color: PadraoCores.texto_1,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),),
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    a.nome_classe,
                    style: TextStyle(
                        color: PadraoCores.texto_1,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),


                  ),
                ),

                onTap: (){

                  setState(() {
                    _displayQuantidadeInputDialog(context,a);
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: ListTile(

                  leading:  GestureDetector(child: Icon(Icons.remove, color: PadraoCores.texto_1,size: 25,),onTap: (){
                    setState(() {
                      a.quantidade_alunos>0 ? a.quantidade_alunos-=1 : a.quantidade_alunos=0;
                      editedAula.total>0 ? editedAula.total-=1 : editedAula.total=0;
                    });
                  },),
                ),
              ),

            ],
          )
      )

  ),);

});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PadraoCores.cor_fundo_1,
        appBar: AppBar(
          title: Text(
            "Chamada",
            style: TextStyle(
                color: PadraoCores.texto_2, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: PadraoCores.gradiente1_1,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: GestureDetector(child: Icon(Icons.save,color:PadraoCores.texto_2 ,),
              onTap: (){

              //  editedAula.total=editedAula.adultosMulheres+editedAula.adultosMulheres+editedAula.jovens+editedAula.adolescentes+editedAula.criancas+editedAula.visitantes;

              int total=0;
                for(var c in classes){
                  editedAula.infomarcaoAula.add({c.nome_classe:c.quantidade_alunos});
                  total+=c.quantidade_alunos;
                  c.quantidade_alunos=0;
                }
                editedAula.infomarcaoAula.add({"Total":total});
                editedAula.total=total;

               Navigator.pop(context,editedAula);


              },
              ),
            ),
          ]
        ),
        body: SingleChildScrollView(
          child: Column(


            children: [

              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        _selectDate(context);

                      },
                      child: Card(
                          color: PadraoCores.cards_1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: ListTile(

                                    leading:  Text(dataFormatada.format(editedAula.data),style: TextStyle(color: PadraoCores.texto_1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),)
                                ),
                              ),
                              Text(
                                "Data",
                                style: TextStyle(
                                    color: PadraoCores.texto_1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: ListTile(

                                  trailing:  Icon(Icons.calendar_today_rounded, color: PadraoCores.texto_1,size: 25,),
                                ),
                              ),
                            ],
                          )

                      ),
                    ),
                  ),
                  Expanded(
                    child:
                  GestureDetector(
                    onTap: (){
                      _displayTextInputDialog(context);
                    },
                    child: Card(
                        color: PadraoCores.cards_1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: ListTile(

                                trailing:  Icon(Icons.add, color: PadraoCores.texto_1,size: 25,),
                                leading: Text("R\$ "+editedAula.oferta.toString(),style: TextStyle(
                                    color: PadraoCores.texto_1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),),
                              ),
                            ),
                            Text(
                              "Oferta",
                              style: TextStyle(
                                  color: PadraoCores.texto_1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: ListTile(

                                leading:  Icon(Icons.remove, color: PadraoCores.texto_1,size: 25,),
                              ),
                            ),

                          ],
                        )

                    ),
                  ),)
                ],
              ),

              GridView.builder(
                physics: ScrollPhysics(),

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 0.95,
                  ),
                  itemCount: classes.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){
                    return Card(
                        color: PadraoCores.cards_1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: ListTile(

                                trailing:  InkWell(child: Icon(Icons.add, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    print(classes[index].quantidade_alunos.toString());
                                    classes[index].quantidade_alunos+=1;

                                    editedAula.total+=1;

                                  });
                                },



                                ),
                                leading: Text(classes[index].quantidade_alunos.toString(),style: TextStyle(
                                    color: PadraoCores.texto_1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),),
                              ),
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  classes[index].nome_classe,
                                  style: TextStyle(
                                      color: PadraoCores.texto_1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              onTap: (){
                                _displayQuantidadeInputDialog(context,classes[index]);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: ListTile(

                                leading:  GestureDetector(child: Icon(Icons.remove, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    classes[index].quantidade_alunos>0 ? classes[index].quantidade_alunos-=1 : classes[index].quantidade_alunos=0;
                                    editedAula.total>0 ? editedAula.total-=1 : editedAula.total=0;
                                  });
                                },),
                              ),
                            ),

                          ],
                        )
                    );
                  }
                  ,
                shrinkWrap: true,

              ),
            ],
          ),
        )

    );

  }

 
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          ageController.text="";
          return AlertDialog(

            backgroundColor: PadraoCores.gradiente1_2,



            title: Text('Oferta',style: TextStyle(color: PadraoCores.texto_1),),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  editedAula.oferta=double.parse(value);
                });
              },
              controller: ageController,
              decoration: InputDecoration(
                focusColor: PadraoCores.texto_1,
                fillColor:PadraoCores.texto_1,
                hoverColor: PadraoCores.texto_1,


              ),
              cursorColor: PadraoCores.texto_1,
              style: TextStyle(color:PadraoCores.texto_1, ),
              keyboardType: TextInputType.number,
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

                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }


  Future<void> _displayQuantidadeInputDialog(BuildContext context, ClasseAlunos classe) async {
    int valor=0;
    return showDialog(
        context: context,
        builder: (context) {
          ageController.text="";
          return AlertDialog(

            backgroundColor: PadraoCores.gradiente1_2,



            title: Text(classe.nome_classe,style: TextStyle(color: PadraoCores.texto_1),),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valor= int.parse(value.toString());
                });
              },
              controller: ageController,
              decoration: InputDecoration(
                focusColor: PadraoCores.texto_1,
                fillColor:PadraoCores.texto_1,
                hoverColor: PadraoCores.texto_1,


              ),
              cursorColor: PadraoCores.texto_1,
              style: TextStyle(color:PadraoCores.texto_1, ),
              keyboardType: TextInputType.number,
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
                   if(valor>0){
                     classe.quantidade_alunos=valor;

                   }

                    Navigator.pop(context);

                  });
                },
              ),
            ],
          );
        }
        );


  }

}
