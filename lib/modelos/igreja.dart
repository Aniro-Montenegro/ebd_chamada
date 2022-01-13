import 'package:hive/hive.dart';

part 'igreja.g.dart';


@HiveType(typeId:1)
class Igreja extends HiveObject{



  @HiveField(0)
  late String nomeIgreja;






  static buildIgreja(){
    Igreja igreja = Igreja();

    igreja.nomeIgreja= "Minha Igreja";


    return igreja;

  }
}