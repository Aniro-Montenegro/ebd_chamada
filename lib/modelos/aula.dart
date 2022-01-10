

import 'package:hive/hive.dart';

part 'aula.g.dart';


@HiveType(typeId:0)
class Aula extends HiveObject{

  @HiveField(0)
  late DateTime data;

  @HiveField(1)
  late int adultosHomens;

  @HiveField(2)
  late int adultosMulheres;

  @HiveField(3)
  late int jovens;

  @HiveField(4)
  late int adolescentes;

  @HiveField(5)
  late int criancas;

  @HiveField(6)
  late int total;

  @HiveField(7)
  late double oferta;

  @HiveField(8)
  late int visitantes;


  @override
  String toString() {
    return 'Aula{data: $data, adultosHomens: $adultosHomens, adultosMulheres: $adultosMulheres, jovens: $jovens, adolescentes: $adolescentes, criancas: $criancas, total: $total, oferta: $oferta, visitantes: $visitantes}';
  }

  static buildAula(){
    Aula aula = Aula();

    aula.data= new DateTime.now();
    aula.adultosMulheres=0;
    aula.adultosHomens=0;
    aula.jovens=0;
    aula.adolescentes=0;
    aula.criancas=0;
    aula.total=0;
    aula.visitantes=0;
    aula.oferta=0.0;

    return aula;

  }
}