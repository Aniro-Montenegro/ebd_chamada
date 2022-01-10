

import 'package:ebd_chamada/config/padrao-cores.dart';
import 'package:ebd_chamada/modelos/aula.dart';
import 'package:ebd_chamada/modelos/boxes-aulas.dart';
import 'package:ebd_chamada/widgets/calendario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ChamadaPage extends StatefulWidget {

  final Aula aula;

  ChamadaPage({required this.aula});
  @override
  _ChamadaPageState createState() => _ChamadaPageState();
}

class _ChamadaPageState extends State<ChamadaPage> {

  Aula editedAula = Aula.buildAula();



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



  @override
  void initState() {
    setState(() {
      editedAula=widget.aula;
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: GestureDetector(child: Icon(Icons.save,color:PadraoCores.texto_2 ,),
              onTap: (){

              //  editedAula.total=editedAula.adultosMulheres+editedAula.adultosMulheres+editedAula.jovens+editedAula.adolescentes+editedAula.criancas+editedAula.visitantes;

               Navigator.pop(context,editedAula);


              },
              ),
            ),
          ]
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StaggeredGrid.count(
              crossAxisCount: 8,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,

              children: [
                StaggeredGridTile.count(
                    crossAxisCellCount: 4,
                    mainAxisCellCount: 4,
                    child: GestureDetector(
                      onTap: (){
                        _selectDate(context);
                        print("data");
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

                                  leading:  Text(editedAula.data.toLocal().toString().substring(0,11),style: TextStyle(color: PadraoCores.texto_1,
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
                    )),
                StaggeredGridTile.count(
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

                                trailing:  GestureDetector(child: Icon(Icons.add, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    editedAula.adultosHomens+=1;
                                    editedAula.total+-1;
                                  });
                                },),
                                leading: Text(editedAula.adultosHomens.toString(),style: TextStyle(
                                    color: PadraoCores.texto_1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),),
                              ),
                            ),
                            Text(
                              "Homens",
                              style: TextStyle(
                                  color: PadraoCores.texto_1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: ListTile(

                                leading:  GestureDetector(child: Icon(Icons.remove, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    editedAula.adultosHomens>0 ? editedAula.adultosHomens-=1 : editedAula.adultosHomens=0;
                                  });
                                },),
                              ),
                            ),

                          ],
                        ))),
                StaggeredGridTile.count(
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

                                trailing:  GestureDetector(child: Icon(Icons.add, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    editedAula.adultosMulheres+=1;
                                    editedAula.total+-1;
                                  });
                                },),
                                leading: Text(editedAula.adultosMulheres.toString(),style: TextStyle(
                                    color: PadraoCores.texto_1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),),
                              ),
                            ),
                            Text(
                              "Mulheres",
                              style: TextStyle(
                                  color: PadraoCores.texto_1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: ListTile(

                                leading:  GestureDetector(child: Icon(Icons.remove, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    editedAula.adultosMulheres>0 ? editedAula.adultosMulheres-=1 : editedAula.adultosMulheres=0;
                                  });
                                },),
                              ),
                            ),

                          ],
                        ))),
                StaggeredGridTile.count(
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

                                trailing:  GestureDetector(child: Icon(Icons.add, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    editedAula.jovens+=1;
                                    editedAula.total+-1;
                                  });
                                },),
                                leading: Text(editedAula.jovens.toString(),style: TextStyle(
                                    color: PadraoCores.texto_1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),),
                              ),
                            ),
                            Text(
                              "Jovens",
                              style: TextStyle(
                                  color: PadraoCores.texto_1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: ListTile(

                                leading:  GestureDetector(child: Icon(Icons.remove, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    editedAula.jovens>0 ? editedAula.jovens-=1 : editedAula.jovens=0;
                                  });
                                },),
                              ),
                            ),

                          ],
                        ))),
                StaggeredGridTile.count(
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

                                trailing:  GestureDetector(child: Icon(Icons.add, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    editedAula.adolescentes+=1;
                                    editedAula.total+-1;
                                  });
                                },),
                                leading: Text(editedAula.adolescentes.toString(),style: TextStyle(
                                    color: PadraoCores.texto_1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),),
                              ),
                            ),
                            Text(
                              "Adolescentes",
                              style: TextStyle(
                                  color: PadraoCores.texto_1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: ListTile(

                                leading:  GestureDetector(child: Icon(Icons.remove, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    editedAula.adolescentes>0 ? editedAula.adolescentes-=1 : editedAula.adolescentes=0;
                                  });
                                },),
                              ),
                            ),

                          ],
                        ))),
                StaggeredGridTile.count(
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

                                trailing:  GestureDetector(child: Icon(Icons.add, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    editedAula.criancas+=1;
                                    editedAula.total+-1;
                                  });
                                },),
                                leading: Text(editedAula.criancas.toString(),style: TextStyle(
                                    color: PadraoCores.texto_1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),),
                              ),
                            ),
                            Text(
                              "Crianças",
                              style: TextStyle(
                                  color: PadraoCores.texto_1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: ListTile(

                                leading:  GestureDetector(child: Icon(Icons.remove, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    editedAula.criancas>0 ? editedAula.criancas-=1 : editedAula.criancas=0;
                                  });
                                },),
                              ),
                            ),

                          ],
                        ))),
                StaggeredGridTile.count(
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

                                trailing:  GestureDetector(child: Icon(Icons.add, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    editedAula.visitantes+=1;
                                    editedAula.total+-1;
                                  });
                                },),
                                leading: Text(editedAula.visitantes.toString(),style: TextStyle(
                                    color: PadraoCores.texto_1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),),
                              ),
                            ),
                            Text(
                              "Visitantes",
                              style: TextStyle(
                                  color: PadraoCores.texto_1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: ListTile(

                                leading:  GestureDetector(child: Icon(Icons.remove, color: PadraoCores.texto_1,size: 25,),onTap: (){
                                  setState(() {
                                    editedAula.visitantes>0 ? editedAula.visitantes-=1 : editedAula.visitantes=0;
                                  });
                                },),
                              ),
                            ),

                          ],
                        ))),
                StaggeredGridTile.count(
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
                        ))),

              ],
            ),
          ),
        ));
  }
}
