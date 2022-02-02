import 'package:hive/hive.dart';

part 'classe-aula.g.dart';


@HiveType(typeId:3)
class ClasseAula extends HiveObject{

  @HiveField(0)
  late DateTime data;



  @HiveField(1)
  late int total;

  @HiveField(2)
  late double oferta;

  @HiveField(3)
  late int id_classe;


  @override
  String toString() {
    return 'ClasseAula{data: $data, total: $total, oferta: $oferta, id_classe: $id_classe}';
  }

  static buildAula(){
    ClasseAula classeAula = ClasseAula();

    classeAula.data= new DateTime.now();
    classeAula.total=0;
    classeAula.oferta=0.0;
    classeAula.id_classe=0;

    return classeAula;

  }
}