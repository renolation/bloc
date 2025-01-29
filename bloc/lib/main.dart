import 'package:bloc_reno/core/common/app/providers/user_provider.dart';
import 'package:bloc_reno/core/res/colours.dart';
import 'package:bloc_reno/core/res/fonts.dart';
import 'package:bloc_reno/core/services/injection_container.dart';
import 'package:bloc_reno/core/services/router.dart';
import 'package:bloc_reno/firebase_options.dart';
import 'package:bloc_reno/src/dashboard/providers/dashboard_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardController(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => UserProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              accentColor: Colours.primaryColour,
            ),
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: Fonts.roboto,
            appBarTheme: const AppBarTheme(
              color: Colors.transparent,
            ),
            useMaterial3: true,
          ),
          onGenerateRoute: generateRoute,
        ),
      ),
    );
  }
}
