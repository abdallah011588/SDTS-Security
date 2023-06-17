

import 'package:graduation_project/models/camera_model.dart';

class UserModel
{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? address;

  UserModel({
  required this.name,
  required this.email,
  required this.phone,
  required this.uId,
  required this.image,
  required this.address,
});

  UserModel.fromJson(Map<String,dynamic> json)
  {
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    address=json['address'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'address':address,
    };
  }


}


