


import 'package:hive/hive.dart';

@HiveType(typeId:2)
class Aula extends HiveObject{


  @HiveField(0)
  late int id_classe;

  @HiveField(1)
  late String nome_classe;

  @HiveField(2)
  late String quantidade_alunos;



}