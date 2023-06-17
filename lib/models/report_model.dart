

class ReportModel{
  late String name;
  late String id;
  late String dateTime;
  late String report;

  ReportModel({
    required this.name,
    required this.id,
    required this.dateTime,
    required this.report,
  });

  ReportModel.fromJson(json){
    name = json['name'];
    id = json['id'];
    dateTime = json['dateTime'];
    report = json['report'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'id':id,
      'dateTime':dateTime,
      'report':report,
    };
  }
}