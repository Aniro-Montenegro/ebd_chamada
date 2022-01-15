import 'package:ebd_chamada/config/padrao-cores.dart';
import 'package:ebd_chamada/modelos/boxes-igreja.dart';
import 'package:ebd_chamada/modelos/igreja.dart';
import 'package:ebd_chamada/widgets/linear_chart.dart';
import 'package:flutter/material.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

class EstatisticasPage extends StatefulWidget {
  @override
  _EstatisticasPageState createState() => _EstatisticasPageState();
}

class _EstatisticasPageState extends State<EstatisticasPage> {

  final box= BoxesIgrejas.getTransactions();
  Igreja igreja =Igreja.buildIgreja();

  @override
  void initState() {
    box.values.toList().length>0 ? igreja=box.values.toList().first:igreja=Igreja.buildIgreja();
    super.initState();
  }

  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 800;
  late Image image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PadraoCores.cor_fundo_1,
        appBar: AppBar(
          title: Text(
            "Estatísticas",
            style: TextStyle(
                color: PadraoCores.texto_2, fontWeight: FontWeight.bold),
          ),
          backgroundColor: PadraoCores.gradiente1_1,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: GestureDetector(child: Icon(Icons.share_rounded,color:PadraoCores.texto_2 ,),
                onTap: (){

                  ShareFilesAndScreenshotWidgets().shareScreenshot(
                      previewContainer,
                      originalSize,
                      "Title",
                      "Name.png",
                      "image/png",
                      text: "Chamada Ebd!");

                },
              ),
            ),
          ],
        ),
        body: RepaintBoundary(
          key: previewContainer,
          child: Container(
            color: PadraoCores.cor_fundo_1,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 15, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      igreja.nomeIgreja,
                      style: TextStyle(color: PadraoCores.texto_1, fontSize: 20),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        child: ConstrainedBox(
                            constraints: BoxConstraints.expand(
                                height: MediaQuery.of(context).size.height * 0.75,
                                width: MediaQuery.of(context).size.width * 0.80),
                            child: LineChartWidget()),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "Alunos",
                          style:
                              TextStyle(color: PadraoCores.texto_1, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Datas",
                    style: TextStyle(color: PadraoCores.texto_1, fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
