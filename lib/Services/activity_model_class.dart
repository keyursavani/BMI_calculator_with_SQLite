// class ActivitiesModel{
//   final int? id;
//   final String gym;
//   final String meditation;
//   final double reading;
//   final String name;
//   final double weight;
//   final double height;
//   final String gender;
//
//   ActivitiesModel({this.id  ,required this.gym ,required this.meditation ,
//     required this.reading , required this.name,required this.weight , required this.height , required this.gender });
//
//   ActivitiesModel.fromMap(Map<String , dynamic> res):
//         id = res['id'],
//         gym = res['gym'],
//         meditation = res['meditation'],
//         reading = res['reading'],
//         name = res['name'],
//         weight = res['weight'],
//         height = res['height'],
//         gender = res['gender'];
//
//   Map<String , Object?> toMap(){
//     return {
//       'id' : id,
//       'gym' : gym,
//       'meditation' : meditation,
//       'reading' : reading,
//       'name' : name,
//       'weight' : weight,
//       'height' : height,
//       'gender' : gender
//     };
//   }
// }

class ActivitiesModel{
  final int? id;
   var name;
   var weight;
   var height;
   var gender;
   var bmi;
   var wakeupTime;
  var gym;
  var meditation;
  var reading;

  ActivitiesModel({this.id ,required this.name ,required this.weight ,required this.height ,
    required this.gender , required this.bmi , required this.wakeupTime , this.gym,
    this.meditation ,  this.reading});

  ActivitiesModel.fromMap(Map<String , dynamic> res):
        id = res['id'],
        name = res['name'],
        weight = res['weight'],
        height = res['height'],
        gender = res['gender'],
        bmi = res['bmi'],
        wakeupTime = res['wakeupTime'],
        gym = res['gym'],
        meditation = res['meditation'],
        reading = res['reading'];

  Map<String , Object?> toMap(){
    return {
      'id' : id,
      'name' : name,
      'weight' : weight,
      'height' : height,
      'gender' : gender,
      'bmi' : bmi,
      'wakeupTime' : wakeupTime,
      'gym' : gym,
      'meditation' : meditation,
      'reading' : reading,
    };
  }
}