import 'dart:io';


import 'package:ebd_chamada/api/pdf-api.dart';
import 'package:ebd_chamada/modelos/customer.dart';
import 'package:ebd_chamada/modelos/invoice.dart';
import 'package:ebd_chamada/modelos/supplier.dart';
import 'package:ebd_chamada/paginas/pdf-relatorio.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../uteis.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
    final profileImage = pw.MemoryImage(
      (await rootBundle.load('imagens/EBD.jpg')).buffer.asUint8List(),
    );
    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice,profileImage),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildInvoice(invoice),

       // buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'Aula: ${Utils.formatDate(invoice.info.dataAula)}.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice, MemoryImage profileImage) => Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSupplierAddress(invoice.igreja),
          Container(
            height: 65,
            width: 65,
            child: pw.ClipOval(
              child: pw.Container(
                width: 50,
                height: 50,
                color: lightGreen,
                child: pw.Image(profileImage),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildCustomerAddress(invoice.customer),
          buildInvoiceInfo(invoice.info),
        ],
      ),
    ],
  );

  static Widget buildCustomerAddress(Customer customer) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
      Text(customer.address),
    ],
  );

  static Widget buildInvoiceInfo(AulaInfo info) {

    final titles = <String>[

      'Data:',
      'Total:',

    ];
    final data = <String>[

      Utils.formatDate(info.dataAula),
      info.total,

    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(IgrejaDados supplier) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(supplier.nome, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Text(supplier.departamento),
    ],
  );

  static Widget buildTitle(Invoice invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Relatório',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
      Text("Data: "+Utils.formatDate(invoice.info.dataAula)),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Nome da Classe',
      'Quantidade',

    ];
    final data = invoice.items.map((item) {


      return [
        item.nomeClasse,


        '${item.quantidade}',

      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: pw.TableBorder(
        left: pw.BorderSide(
          width: 2,
          color: PdfColors.black,

        ),
        top: pw.BorderSide(
          width: 2,
          color: PdfColors.black,

        ),
        bottom: pw.BorderSide(
          width: 2,
          color: PdfColors.black,

        ),
        right: pw.BorderSide(
          width: 2,
          color: PdfColors.black,

        ),
        horizontalInside: pw.BorderSide(
          width: 1,
          color: PdfColors.black,

        ),
      ),


      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.center,

      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.quantidade)
        .reduce((item1, item2) => item1 + item2);
    final vatPercent = invoice.items.first.quantidade;
    final vat = netTotal * vatPercent;
    final total = netTotal + vat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // buildText(
                //   title: 'Vat ${vatPercent * 100} %',
                //   value: Utils.formatPrice(vat),
                //   unite: true,
                // ),
                Divider(),
                // buildText(
                //   title: 'Total amount due',
                //   titleStyle: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   value: Utils.formatPrice(total),
                //   unite: true,
                // ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      //Divider(),
      SizedBox(height: 2 * PdfPageFormat.mm),
      buildSimpleText(title: '', value:"Superintendente"),
      SizedBox(height: 1 * PdfPageFormat.mm),

    ],
  );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}