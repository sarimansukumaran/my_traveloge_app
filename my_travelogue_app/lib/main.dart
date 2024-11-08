import 'package:flutter/material.dart';
import 'package:my_travelogue_app/controller/home_screen_controller.dart';
import 'package:my_travelogue_app/utils/color_constants.dart';

import 'package:my_travelogue_app/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await HomeScreenController.initDb();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => HomeScreenController())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: ColorConstants.scaffold_bg),
      home: SplashScreen(),
    );
  }
}
