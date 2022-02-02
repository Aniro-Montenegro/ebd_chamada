
import 'package:ebd_chamada/modelos/classe-aula.dart';
import 'package:hive/hive.dart';

class BoxesClasseAula{

  static Box<ClasseAula> getTransactions()=>
      Hive.box<ClasseAula>('classes-aula');

}
