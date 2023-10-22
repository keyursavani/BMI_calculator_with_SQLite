import 'package:bmi_calculation_app/Screen/bmi_calculation_screen.dart';
import 'package:bmi_calculation_app/Screen/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return WillPopScope(
     onWillPop: ()async{
       SystemNavigator.pop();
       return true;
     },
     child:Scaffold (
       body: Center(
         child: Container(
             decoration: const BoxDecoration(
                 gradient: LinearGradient(
                     colors: [Color(0xFF6DD5ED), Color(0xFF2193B0)])),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Center(
                 child: InkWell(
                   onTap: (){
                     Navigator.push(context,
                     MaterialPageRoute(builder: (context){
                       return const BMICalculator();
                     }));
                   },
                   child: Container(
                     height: 50,
                     width: 250,
                     decoration: const BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(15)),
                       color: Colors.black54,
                     ),
                     child:  const Align(
                       alignment: Alignment.center,
                       child:Text("Calculate Your BMI",style: TextStyle(
                           color: Colors.white,
                           fontSize: 22
                       ),),
                     ),
                   ),
                 ),
               ),
               const SizedBox(height: 20,),
               Center(
                 child: InkWell(
                   onTap: (){
                     Navigator.push(context,
                         MaterialPageRoute(builder: (context){
                           return const DatabaseHistoryScreen();
                         }));
                   },
                   child: Container(
                     height: 50,
                     width: 250,
                     decoration: const BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(15)),
                       color: Colors.black54,
                     ),
                     child:  const Align(
                       alignment: Alignment.center,
                       child:Text("Show  your records",style: TextStyle(
                           color: Colors.white,
                           fontSize: 22
                       ),),
                     ),
                   ),
                 ),
               ),
             ],
           )
         ),
       ),
     ),
   );
  }
}