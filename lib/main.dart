import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ebd_chamada/modelos/igreja.dart';
import 'package:ebd_chamada/paginas/home-page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';

import 'config/padrao-cores.dart';
import 'modelos/aula.dart';
import 'modelos/classe-alunos.dart';




void main() async {



  WidgetsFlutterBinding.ensureInitialized();


  await Hive.initFlutter();

  Hive.registerAdapter(AulaAdapter());
  await Hive.openBox<Aula>('aulas');
  Hive.registerAdapter(IgrejaAdapter());
  await Hive.openBox<Igreja>('igrejas');
  Hive.registerAdapter(ClasseAlunosAdapter());
  await Hive.openBox<ClasseAlunos>('classes');




  runApp(



      MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [const Locale('pt', 'BR')],
          title: 'Chamada',
          debugShowCheckedModeBanner: false,
          theme:  _buildShrineTheme(),
          home: AnimatedSplashScreen(
            splash: 'imagens/splash.png',
            splashIconSize: 1000.0,
           nextScreen: HomePage(),
           //nextScreen: EditClassePage(classe: classe,),
            backgroundColor: PadraoCores.splascreen,
            pageTransitionType: PageTransitionType.fade,
            curve: Curves.linear,
            animationDuration: const Duration(milliseconds: 2000),
            duration: 2500,
            splashTransition: SplashTransition.scaleTransition,






          )
      )
  );
}

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _shrineColorScheme,
    toggleableActiveColor: shrinePink400,
    accentColor: shrineBrown900,
    primaryColor: shrinePink100,
    buttonColor: shrinePink100,
    scaffoldBackgroundColor: shrineBackgroundWhite,
    cardColor: shrineBackgroundWhite,
    textSelectionColor: shrinePink100,
    errorColor: shrineErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: _shrineColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
    caption: base.caption?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: defaultLetterSpacing,
    ),
    button: base.button?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: defaultLetterSpacing,
    ),
  )
      .apply(
    fontFamily: 'Rubik',
    displayColor: shrineBrown900,
    bodyColor: shrineBrown900,
  );
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink400,
  primaryVariant: shrineBrown900,
  secondary: shrinePink50,
  secondaryVariant: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFF7188B0);
const Color shrinePink100 = Color(0xFF404D63);
const Color shrinePink300 = Color(0xFF485770);
const Color shrinePink400 = Color(0xFF272f3d);

const Color shrineBrown900 = Color(0xFF687EA3);
const Color shrineBrown600 = Color(0xFF687EA3);

const Color shrineErrorRed = Color(0xFF7188B0);

const Color shrineSurfaceWhite = Color(0xFF7188B0);
const Color shrineBackgroundWhite = Color(0xFF7188B0);

const defaultLetterSpacing = 0.03;