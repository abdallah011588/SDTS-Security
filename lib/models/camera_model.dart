class CameraModel{
  late String name;
  late String id;
  late String url;

  CameraModel({
    required this.name,
    required this.id,
    required this.url,
  });

  CameraModel.fromJson(json){
    name = json['name'];
    id = json['id'];
    url = json['url'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'id':id,
      'url':url,
    };
  }
}