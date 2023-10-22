import 'package:bmi_calculation_app/Services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>{

  SplashServices splashScreen = SplashServices();

  @override
  void initState(){
    super.initState();
    splashScreen.splash(context);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      body: Center(
        child: Text("Track Your Daily Activities",style: TextStyle(
          fontSize: 30,
          color: Colors.black
        ),),
      ),
    );
  }
}