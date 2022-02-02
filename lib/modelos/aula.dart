


import 'package:hive/hive.dart';

part 'aula.g.dart';


@HiveType(typeId:0)
class Aula extends HiveObject{

  @HiveField(0)
  late DateTime data;



  @HiveField(1)
  late int total;

  @HiveField(2)
  late double oferta;

  @HiveField(3)
  late List<Map<String,int>> infomarcaoAula;


  @override
  String toString() {
    return 'Aula{data: $data, total: $total, oferta: $oferta, infomarcaoAula: $infomarcaoAula}';
  }

  static buildAula(){
    Aula aula = Aula();

    aula.data= new DateTime.now();
    aula.total=0;
    aula.oferta=0.0;
    aula.infomarcaoAula=[];

    return aula;

  }
}