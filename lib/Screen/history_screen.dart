import 'package:bmi_calculation_app/Services/activity_model_class.dart';
import 'package:bmi_calculation_app/Services/db_handeler.dart';
import 'package:flutter/material.dart';

class DatabaseHistoryScreen extends StatefulWidget{
  const DatabaseHistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  DatabaseHistoryScreenState();
  }
}

class DatabaseHistoryScreenState extends State<DatabaseHistoryScreen>{

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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Records"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: notesList,
                builder: (context , AsyncSnapshot<List<ActivitiesModel>> snapshot){
                  if(snapshot.hasData){
                    return
                      ListView.builder(
                          itemCount: snapshot.data?.length,
                          reverse: false,
                          shrinkWrap: true,
                          itemBuilder: (context , index){
                            return Dismissible(
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                child: Icon(Icons.delete_forever),
                              ),
                              onDismissed: (DismissDirection direction){
                                setState(() {
                                  dbHelper!.delete(snapshot.data![index].id!);
                                  notesList = dbHelper!.getNotesList();
                                  snapshot.data!.remove(snapshot.data![index]);
                                });
                              },
                              key: ValueKey<int>(snapshot.data![index].id!),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10 ,bottom: 10,left: 15,right: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20,),
                                          Text("Name :- ${snapshot.data![index].name.toString()}"),
                                          const SizedBox(height: 20,),
                                          Text("Weight :- ${snapshot.data![index].weight.toString()}"),
                                          const SizedBox(height: 20,),
                                          Text("Height :- ${snapshot.data![index].height.toString()}"),
                                          const SizedBox(height: 20,),
                                          Text("Gender :- ${snapshot.data![index].gender.toString()}"),
                                          const SizedBox(height: 20,),
                                          Text("BMI :- ${snapshot.data![index].bmi.toString()}"),
                                          const SizedBox(height: 20,),
                                          Text("Wake-up Time :- ${snapshot.data![index].wakeupTime.toString()}"),
                                          const SizedBox(height: 20,),
                                          Text("GYM :- ${snapshot.data![index].gym.toString()}"),
                                          const SizedBox(height: 20,),
                                          Text("Meditation ${snapshot.data![index].meditation.toString()}"),
                                          const SizedBox(height: 20,),
                                          Text("Reading :- ${snapshot.data![index].reading.toString()}"),
                                          const SizedBox(height: 20,),
                                        ],
                                      ),
                                    )
                                  ),
                                ),
                              ),
                            );
                          });
                  }
                  else if(snapshot.hasError){
                   print(snapshot.error.toString());
                   return Text("Error");
                  }
                  else{
                    return Center(
                        child: CircularProgressIndicator(strokeWidth: 2,));
                  }
                }
            ),
          )
        ],
      ),
    );
  }
}