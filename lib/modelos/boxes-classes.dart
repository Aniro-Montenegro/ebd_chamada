

import 'package:ebd_chamada/modelos/classe-alunos.dart';
import 'package:hive/hive.dart';

class BoxesClasses{

  static Box<ClasseAlunos> getTransactions()=>
      Hive.box<ClasseAlunos>('classes');

}