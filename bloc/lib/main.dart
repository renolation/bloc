import 'package:bloc_reno/core/res/colours.dart';
import 'package:bloc_reno/core/res/fonts.dart';
import 'package:bloc_reno/core/services/injection_container.dart';
import 'package:bloc_reno/core/services/router.dart';
import 'package:flutter/material.dart';


Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colours.primaryColour,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: Fonts.roboto,
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: generateRoute,

    );
  }
}

