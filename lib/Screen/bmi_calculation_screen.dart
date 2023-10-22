import 'package:bmi_calculation_app/Services/activity_model_class.dart';
import 'package:bmi_calculation_app/Services/db_handeler.dart';
import 'package:bmi_calculation_app/Services/tost_screen.dart';
import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BMICalculatorState();
  }
}

class BMICalculatorState extends State<BMICalculator> {
  Color myColor = Colors.transparent;

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String gender = "male";

  var myReading;
  var myWeight;
  var myHeight;

  var result = TextEditingController();

  calculateBMI(String weight, String height) async {
    var myWeight = double.parse(weight);
    var myHeight = double.parse(height);

    var res = (myWeight / (myHeight * myHeight));

    setState(() {
      result.text = res.toStringAsFixed(2);
      if (res < 18.5) {
        myColor = const Color(0xFF87B1D9);
      } else if (res >= 18.5 && res <= 24.9) {
        myColor = const Color(0xFF3DD365);
      } else if (res >= 25 && res <= 29.9) {
        myColor = const Color(0xFFEEE133);
      } else if (res >= 30 && res <= 34.9) {
        myColor = const Color(0xFFFD802E);
      } else if (res >= 35) {
        myColor = const Color(0xFFF95353);
      }
    });
  }

  TextEditingController meditationController = TextEditingController();
  TextEditingController readingController = TextEditingController();

  bool gym = false;
  bool meditation = false;
  bool reading = false;

  String? _selectedTime;
  Future<void> _show() async {
    final TimeOfDay? result =
    await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
    }
  }

  DBHelper? dbHelper;
  late Future<List<ActivitiesModel>> notesList;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    loadData ();
  }

  loadData () async{
    notesList = dbHelper!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF6DD5ED), Color(0xFF2193B0)])),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    "BMI Calculator",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: Color(0xFF0038FF),
                        color: Colors.white,
                        fontSize: 25),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 10),
                    child: TextField(
                      controller: nameController,
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter your Name",
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: TextField(
                      controller: weightController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter your weight in kg",
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: TextField(
                      controller: heightController,
                      autofocus: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter your height in meter",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 22),
                        child: Text(
                          "Select Your Gender",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: RadioListTile(
                          title: const Text("Male",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          value: "male",
                          groupValue: gender,
                          activeColor: Colors.red,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: RadioListTile(
                          title: const Text("Female",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          value: "female",
                          activeColor: Colors.red,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: RadioListTile(
                          title: const Text(
                            "Other",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          value: "other",
                          activeColor: Colors.red,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            calculateBMI(
                                weightController.text, heightController.text);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black38),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ))),
                          child: const Text(
                            "Calculate",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Container(
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                          color: myColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: Center(
                          child: Text(
                        "BMI: ${result.text}",
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    "Tracked Your Daily Activities",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: Color(0xFF0038FF),
                        color: Colors.white,
                        fontSize: 25),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 17),
                      child: Text(
                        "Please select your wake-up time",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // color: Color(0xFF0038FF),
                            color: Colors.black,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width-30,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 20),
                      child: InkWell(
                        onTap: _show,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),

                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                          ),
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _selectedTime != null ? _selectedTime! : 'Enter your wake-up time',
                              style:  TextStyle(
                                fontSize:  _selectedTime != null ? 16  :20,
                                color:  _selectedTime != null ? const Color(0xFF19232d)  : Colors.black38,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    title: const Text('Gym',style: TextStyle(
                        fontSize: 17
                    ),),
                    activeColor: Colors.red,
                    value: gym,
                    onChanged: (bool? value) {
                      setState(() {
                        gym = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: const Text('Meditation',style: TextStyle(
                        fontSize: 17
                    ),),
                    activeColor: Colors.red,
                    value: meditation,
                    onChanged: (bool? value) {
                      setState(() {
                        meditation = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  Container(
                    child:meditation ? Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      child: TextField(
                        controller: meditationController,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Please mention how much minutes",
                        ),
                      ),
                    ) : Container(),
                  ),
                  CheckboxListTile(
                    title: const Text('Reading',style: TextStyle(
                        fontSize: 17
                    ),),
                    activeColor: Colors.red,
                    value: reading,
                    onChanged: (bool? value) {
                      setState(() {
                        reading = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  Container(
                    child:reading ? Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      child: TextField(
                        controller: readingController,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Please mention no. of pages read",
                        ),
                      ),
                    ) : Container(),
                  ),
                  const SizedBox(height: 50,),
                  Center(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          print(result.text.toString());
                          print(_selectedTime.toString());
                        });
                     if(nameController.text.isEmpty && heightController.text.isEmpty &&
                         weightController.text.isEmpty && result.text.toString().isEmpty){
                       Utils().toastMessage("Please Enter Your Name , Height ,Weight And Calculate Your BMI");
                     }
                        if(_selectedTime.toString() == "null"){
                          Utils().toastMessage("Please Select Your Wake-up Time");
                        }
                     // if(meditation == true){
                     //   if(meditationController.text.isEmpty){
                     //     Utils().toastMessage("Please Enter You Meditation Time");
                     //   }
                     // }
                     // if(reading == true){
                     //   if(meditationController.text.isEmpty){
                     //     Utils().toastMessage("Please Enter Number Of Page");
                     //   }
                     // }
                     // if(_selectedTime.toString() == null){
                     //   Utils().toastMessage("Please Select Your Wake-up Time");
                     // }
                     //    if(result.text.isEmpty){
                     //      Utils().toastMessage("Please Calculate Your BMI");
                     //    }
                     else if(nameController.text.isNotEmpty && heightController.text.isNotEmpty &&
                         weightController.text.isNotEmpty && result.text.toString().isNotEmpty){
                       if(_selectedTime.toString() == "null"){
                         Utils().toastMessage("Please Select Your Wake-up Time");
                       }
                       if(meditation == true || reading == true){
                         if(meditationController.text.isEmpty){
                           Utils().toastMessage("Please Enter You Meditation Time");
                         }
                         if(readingController.text.isEmpty){
                           Utils().toastMessage("Please Enter Number Of Page");
                         }
                         else{
                           dbHelper!.insert(
                               ActivitiesModel(
                                 name: nameController.text.toString().trim(),
                                 weight: weightController.text.toString().trim(),
                                 height: heightController.text.toString().trim(),
                                 gender: gender.toString().trim(),
                                 bmi: result.text.toString().trim(),
                                 wakeupTime: _selectedTime.toString() != "null" ? _selectedTime.toString().trim() : "Not added Wake-up time",
                                 gym: gym.toString().trim(),
                                 meditation: meditation == true ? meditationController.text.toString().trim() : "You are note doing Meditation",
                                 reading: reading == true ? readingController.text.toString().trim() : "You are note Reading a Book",
                               )
                           ).then((value){
                             Utils().toastMessage("Data Added Successfully");
                             Navigator.pop(context);
                             setState(() {
                               notesList = dbHelper!.getNotesList();
                             });
                           }).onError((error, stackTrace){
                             print(error.toString());
                           });
                         }
                       }
                       else{
                         dbHelper!.insert(
                             ActivitiesModel(
                               name: nameController.text.toString().trim(),
                               weight: weightController.text.toString().trim(),
                               height: heightController.text.toString().trim(),
                               gender: gender.toString().trim(),
                               bmi: result.text.toString().trim(),
                               wakeupTime: _selectedTime.toString() != "null" ? _selectedTime.toString().trim() : "Not added Wake-up time",
                               gym: gym.toString().trim(),
                               meditation: meditation == true ? meditationController.text.toString().trim() : "You are note doing Meditation",
                               reading: reading == true ? readingController.text.toString().trim() : "You are note Reading a Book",
                             )
                         ).then((value){
                           Utils().toastMessage("Data Added Successfully");
                           Navigator.pop(context);
                           setState(() {
                             notesList = dbHelper!.getNotesList();
                           });
                         }).onError((error, stackTrace){
                           print(error.toString());
                         });
                       }
                     }
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
                          child:Text("Tracked",style: TextStyle(
                              color: Colors.white,
                              fontSize: 22
                          ),),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
