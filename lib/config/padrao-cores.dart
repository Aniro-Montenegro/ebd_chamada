import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
class PadraoCores {


  static Color gradiente1 = Color(0xFF272f3d);
  static Color gradiente1_1 = Color(0xFF404D63);
  static Color gradiente1_2 = Color(0xFF485770);
  static Color gradiente2 = Color(0xFF272f3d);
  static Color gradiente2_1 = Color(0xFF634643);
  static Color gradiente2_2 = Color(0xFFB07D76);
  static Color gradiente3 = Color(0xFF64301c);
  static Color splascreen = Color(0xFF2F394A);
  static Color cor_fundo_1 = Color(0xFF7188B0);
  static Color texto_1 = Color(0xFFfcb206);
  static Color texto_2 = Color(0xFFFDC951);
  static Color cards_1 = Color(0xFF404D63);
  static Color cards_2 = Color(0xFF687EA3);
  static Color cards_3 = Color(0xFF7188B0);


  static PdfColor gradiente1PDF = PdfColor.fromInt(0xFF272f3d);
  static PdfColor gradiente1_1PDF = PdfColor.fromInt(0xFF404D63);
  static PdfColor texto_1PDF = PdfColor.fromInt(0xFFfcb206);
  static PdfColor texto_2PDF = PdfColor.fromInt(0xFFFDC951);
  static PdfColor cards_2PDF = PdfColor.fromInt(0xFF687EA3);
  static PdfColor cards_3PDF = PdfColor.fromInt(0xFF7188B0);



  static Map<int, Color> color =
  {
    50:gradiente1,
    100:gradiente1,

  };


  MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);


}