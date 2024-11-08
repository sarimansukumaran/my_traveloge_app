import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_travelogue_app/utils/color_constants.dart';
import 'package:my_travelogue_app/view/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (contex) => HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("My Traveloges Dairy",
            style: GoogleFonts.workSans(
                textStyle: TextStyle(
                    color: ColorConstants.primary_color,
                    fontSize: 20,
                    fontWeight: FontWeight.w600))),
      ),
    );
  }
}
