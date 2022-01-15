


import 'package:ebd_chamada/config/padrao-cores.dart';


import 'package:ebd_chamada/modelos/classe-alunos.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class EditClassePage extends StatefulWidget {

  final ClasseAlunos classe;

  EditClassePage({required this.classe});
  @override
  _EditClassePageState createState() => _EditClassePageState();
}

class _EditClassePageState extends State<EditClassePage> {

 ClasseAlunos editedClasse = ClasseAlunos.buildClasse();






 final TextEditingController _ageController = new TextEditingController();




  @override
  void initState() {
    setState(() {
      editedClasse=widget.classe;
      _ageController.text=editedClasse.nome_classe;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PadraoCores.cor_fundo_1,
        appBar: AppBar(
          title: Text(
            "Classes",
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

              setState(() {
                editedClasse.nome_classe=_ageController.text;
              });

               Navigator.pop(context,editedClasse);


              },
              ),
            ),
          ]
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top:48.0,right: 15,left: 25),
            child: TextFormField(
              controller: _ageController,
              onChanged: setNomeClasse(),
              style:TextStyle(color: PadraoCores.texto_1),
              decoration: InputDecoration(
                hintText: "Nome da Classe",
                fillColor: PadraoCores.texto_1,



                hintStyle: TextStyle(color: PadraoCores.texto_1),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PadraoCores.texto_1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PadraoCores.gradiente1),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: PadraoCores.texto_1),
                ),
              ),

              // ignore: missing_return

            ),
          ),
        )

    );
  }

 setNomeClasse() {
   editedClasse.nome_classe= _ageController.text;
 }

}
