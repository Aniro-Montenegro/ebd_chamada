import 'package:ebd_chamada/modelos/customer.dart';
import 'package:ebd_chamada/modelos/supplier.dart';

class Invoice {
  final AulaInfo info;
  final IgrejaDados igreja;
  final Customer customer;
  final List<ClasseAlunos> items;

  const Invoice({
    required this.info,
    required this.igreja,
    required this.customer,
    required this.items,
  });
}

class AulaInfo {
  final String total;
  final String oferta;
  final DateTime dataAula;


  const AulaInfo({
    required this.total,
    required this.oferta,
    required this.dataAula,

  });
}

class ClasseAlunos {
  final String nomeClasse;
  final int quantidade;



  const ClasseAlunos({
    required this.nomeClasse,
    required this.quantidade,


  });
}