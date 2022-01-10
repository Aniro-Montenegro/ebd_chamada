
import 'package:ebd_chamada/modelos/aula.dart';
import 'package:hive/hive.dart';

class BoxesAulas{

  static Box<Aula> getTransactions()=>
      Hive.box<Aula>('aulas');

}