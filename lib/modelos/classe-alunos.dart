


import 'package:hive/hive.dart';

part 'classe-alunos.g.dart';

@HiveType(typeId:2)
class ClasseAlunos extends HiveObject{


  @HiveField(0)
  late int id_classe;

  @HiveField(1)
  late String nome_classe;

  @HiveField(2)
  late int quantidade_alunos;


  static buildClasse(){
    ClasseAlunos classe = ClasseAlunos();

    classe.nome_classe="";
    classe.quantidade_alunos=0;
    classe.id_classe=DateTime.now().millisecondsSinceEpoch~/30;

    return classe;

  }

  @override
  String toString() {
    return 'ClasseAlunos{id_classe: $id_classe, nome_classe: $nome_classe, quantidade_alunos: $quantidade_alunos}';
  }
}