

import 'package:ebd_chamada/modelos/igreja.dart';
import 'package:hive/hive.dart';

class BoxesIgrejas{

  static Box<Igreja> getTransactions()=>
     Hive.box<Igreja>('igrejas');


}