
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/models/camera_model.dart';
import 'package:graduation_project/models/notification_model.dart';
import 'package:graduation_project/models/report_model.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/screens/devices_screen/devices_screen.dart';
import 'package:graduation_project/screens/home_layout/cubit/states.dart';
import 'package:graduation_project/screens/profile_screen/profile_screen.dart';
import 'package:graduation_project/screens/report_screen/reports_screen.dart';
import 'package:graduation_project/screens/setting_screen/setting_screen.dart';
import 'package:graduation_project/shared/remote/dio_tool.dart';
import 'package:graduation_project/shared/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialState());

  static AppCubit get(context)=>BlocProvider.of(context);
  bool isPass=true;
  bool isActive=Shared.getBool(key: "saveReport")??false;
  IconData visibilityIcon = Icons.visibility;
  bool agreeTerms=false;
  int pageIndex = 0;
  late  DatabaseReference dbRef=FirebaseDatabase.instance.ref();
  static  DatabaseReference dbRef2=FirebaseDatabase.instance.ref();
  UserModel? userData;

  String groupValue =Shared.getString(key: 'currentLang') ??'2';

  String themeValue =Shared.getString(key: 'theme') ??'2';

  List<Widget> screens=[
    ReportsScreen(),
    DevicesScreen(),
    SettingScreen(),
    ProfileScreen(),
  ];

  void showPassword()
  {
    isPass= !isPass;
    visibilityIcon = isPass ? Icons.visibility_off : Icons.visibility;
    emit(ShowPasswordState());
  }

  void agreeTermsChanged(bool value)
  {
    agreeTerms = value ;
    emit(AgreeTermsState());
  }

  void changeScreen(int index)
  {
    emit(ChangeScreenState());
    pageIndex=index;
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }){
    UserModel _userModel= UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: "https://firebasestorage.googleapis.com/v0/b/graduation-project-bb3e2.appspot.com/o/users%2Fprof.png?alt=media&token=15834b0d-de95-4614-a62c-8cc213346623",
      address: 'Unknown',
    );
    FirebaseFirestore.instance.collection('users')
        .doc(uId).set(_userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState(uId));
    }).catchError((error){
      emit( CreateUserErrorState(error.toString()) );
    });
  }
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  })
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password,)
        .then((value) {
        //  sendEmailVerification();
      createUser(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }

  void sendEmailVerification()async
  {
    final user=FirebaseAuth.instance.currentUser;
    await user!.sendEmailVerification();
    print('verification sent');
  }
  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      UID=value.user!.uid;
      emit(LoginSuccessState(value.user!.uid));
      print('${value.user!.uid} user with email : ${value.user!.email} has logged in');
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }

  void userResetPassword({
    required String email,
  })
  {
    emit(ResetPassLoadingState());
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(ResetPassSuccessState());
      print(' pass reset sent ');
    }).catchError((onError){
      emit(ResetPassErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  void getUserData()
  {
    emit(GetUserDataLoadingState());
    if(Shared.getString( key: 'uId')!=null && Shared.getString( key: 'uId')!='' )
    FirebaseFirestore.instance.collection('users').doc(Shared.getString( key: 'uId')).get().then((value) {
      userData=UserModel.fromJson(value.data()!);
      getReports();
      getCameras();
      print(userData!.name);
      print(userData!.phone);
      print(userData!.email);
      print(userData!.uId);

      emit(GetUserDataSuccessState());
    }).catchError((onError){
      emit(GetUserDataErrorState());
      print('Error ${onError.toString()} in getting user data');
    });
  }

  File? Image;
  final ImagePicker picker =ImagePicker();
  Future<void> getImage()async
  {
   Image=null;
    var pickedImage= await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage !=null)
    {
      Image=File(pickedImage.path);
      emit(GetImageSuccessState());
    }
    else
    {
      emit(GetImageErrorState());
    }
  }

  Future<void> getImageFromCamera()async
  {
    var pickedImage= await picker.pickImage(source: ImageSource.camera);
    if(pickedImage !=null)
    {
      Image=File(pickedImage.path);
      emit(GetImageSuccessState());
    }
    else
    {
      emit(GetImageErrorState());
    }
  }

  void updateUser({
    String? name,
    String? uId,
    String? phone,
    String? email,
    String? image,
  })
  {
    emit(UpdateUserLoadingState());
    UserModel model= UserModel(
      email: email??userData!.email,
      name: name??userData!.name,
      phone: phone??userData!.phone,
      uId: userData!.uId,
      image: image??userData!.image,
      address: '',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userData!.uId)
        .update(model.toMap()).then((value)
    {
      getUserData();
    }).catchError((onError){
      emit(UpdateUserErrorState(onError.toString()));
    });

  }

  void updateImage()
  {
    emit(UploadImLoadingState());
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(Image!.path).pathSegments.last}')
        .putFile(Image!).then((value) {

      value.ref.getDownloadURL().then((value)
      {
        updateUser(image: value);
        //Image=null;
        emit(UploadImSuccessState());
      }).catchError((error){
        emit(UploadImErrorState());
      });
    }).catchError((onError){
      emit(UploadImErrorState());
    });
  }

  void signOut()async
  {
    await FirebaseAuth.instance.signOut().then((value) {
      emit(LogOutSuccessState());
    }).catchError((onError){
      emit(LogOutErrorState());
    });
  }

  void sendNotification({required String title, required String body,})
  {
    AppNotification app_notification=AppNotification(
        title: title,
        body: body,
        mutableContent: true,
        sound: "default"
    );
    Data notData=Data(
        type: "order",
        id: "100",
        clickAction: "FLUTTER_ACTION_DEFAULT"
    );
    NotificationModel notifyModel= NotificationModel(
      to: Shared.getString(key: "FCMToken")!,
      notification: app_notification,
      data: notData,
    );
    dioTool.postData(data: notifyModel.toJson()).then( (value) {
      print('successful process of sending notification');
      emit(SendNotificationSuccessState());
    }).catchError((error){
      print('Error in sending notification');
      emit(SendNotificationErrorState(error.toString()));
    });
  }

  /// ////////////////////////////////////////////////////////
  void sendNotificationToAnother({
    //required String receiver,
    required String title,
    required String body,
  })
  {
    AppNotification app_notification=AppNotification(
        title: title,
        body: body,
        mutableContent: true,
        sound: "default"
    );
    Data notData=Data(
        type: "order",
        id: "100",
        clickAction: "FLUTTER_ACTION_DEFAULT"
    );
    NotificationModel notifyModel= NotificationModel(
      to: "fByinBsVT_afQzSlDaB-0E:APA91bG0LbnTcIFGdexYtxhl0Y8QLoeNQwbUrmVHqvo0ue1stEZu6XKfj0UAa_J7vKHYpezWBD0XGKXSxBrCf2OfGSB_2X6Izu5iHxTLrJ7T6iir0jVhngxetLjy4aVzJW14zp2PMOZQ",
      notification: app_notification,
      data: notData,
    );
    dioTool.postData(data: notifyModel.toJson()).then( (value) {
      print('successful process of sending notification');
      emit(SendNotificationSuccessState());
    }).catchError((error){
      print('Error in sending notification');
      emit(SendNotificationErrorState(error.toString()));
    });

  }

  void createDB()
  {
   // emit(RegisterLoadingState());
    dbRef.child('dd').set("0");
  }

  /// ALL CAMERA FUNCTIONS

  CameraModel? cameraModel;
  Future addCamera({required String cameraName, required String url,
  }) {
    CameraModel model = CameraModel(
      name: cameraName,
      url: url,
      id: "",
    );
    emit(AddCameraLoadingState());
    return FirebaseFirestore.instance
        .collection('users_cameras').doc(userData!.uId).collection("cameras")
        .add(model.toMap())
        .then((value) {
        FirebaseFirestore.instance
          .collection('users_cameras').doc(userData!.uId).collection("cameras").doc(value.id).update(
          CameraModel(
            name: cameraName,
            url: url,
            id: value.id,
          ).toMap()
      ).then((value) {
        getCameras();
        emit(AddCameraSuccessState());
      });

    }).catchError((error) {
      print(error.toString());
      emit(AddCameraErrorState(error.toString()));
    });
  }

  List<CameraModel> cameras = [];
  void getCameras() {
    emit(GetCameraLoadingState());
    FirebaseFirestore.instance.collection('users_cameras').doc(userData!.uId).collection("cameras")
      .get().then((value) {
      cameras = [];
      value.docs.forEach((element) {
        cameras.add(CameraModel.fromJson(element.data()));
      });
      emit(GetCameraSuccessState());
    }).catchError((error) {
      emit(GetCameraErrorState(error.toString()));
    });
  }

  void removeCamera(String id) {
    FirebaseFirestore.instance
        .collection('users_cameras').doc(userData!.uId).collection("cameras").doc(id).delete()
        .then((value) {
      getCameras();
      emit(RemoveCameraSuccessState());
    }).catchError((error) {
      emit(RemoveCameraErrorState());
    });
  }
  /// REPORT Functions

  ReportModel? reportModel;
  Future addReport({
    required String reportName,
    required String dateTime,
    required String report,
  }) {
    ReportModel model = ReportModel(
        name: reportName,
        id: "",
        dateTime: dateTime,
        report: report
    );

    emit(AddReportLoadingState());
    return FirebaseFirestore.instance
        .collection('users_reports').doc(userData!.uId).collection("reports")
        .add(model.toMap())
        .then((value) {

        FirebaseFirestore.instance
        .collection('users_reports').doc(userData!.uId).collection("reports").doc(value.id).update(
          ReportModel(
              name: reportName,
              id: value.id,
              dateTime: dateTime,
              report: report
          ).toMap()
      ).then((value) {
        getReports();
        emit(AddReportSuccessState());
      });

    }).catchError((error) {
      print(error.toString());
      emit(AddReportErrorState(error.toString()));
    });
  }

  List<ReportModel> reports = [];
  List<ReportModel> notifications = [];
  void getReports() {
    emit(GetReportLoadingState());
    FirebaseFirestore.instance.collection('users_reports').doc(userData!.uId).collection("reports")
        .get().then((value) {
      reports = [];
      value.docs.forEach((element) {
        reports.add(ReportModel.fromJson(element.data()));
        notifications.add(ReportModel.fromJson(element.data()));
      });
      emit(GetReportSuccessState());
    }).catchError((error) {
      emit(GetReportErrorState(error.toString()));
    });
  }
  void removeReport(String id) {
    FirebaseFirestore.instance
        .collection('users_reports').doc(userData!.uId).collection("reports").doc(id).delete()
        .then((value) {
      getReports();
      emit(RemoveReportSuccessState());
    }).catchError((error) {
      emit(RemoveReportErrorState());
    });
  }
  void removeAllReports(context) {
    if(reports.length>0)
      {
        print("-------------"+ userData!.uId.toString());
        reports.forEach((element) {
          FirebaseFirestore.instance
              .collection('users_reports').doc(userData!.uId).collection("reports").doc(element.id).delete()
              .then((value) {
            log("-------------done");
            emit(RemoveAllReportsSuccessState());
          }).catchError((error) {
            emit(RemoveAllReportsErrorState());
          });
        });
        reports=[];
        Navigator.pop(context);
      }
  }

  void changeLanguage(String groupV,)
  {
    groupValue=groupV;
    emit(ChangeLanguageState());
  }

  void changeTheme(String value,)
  {
    themeValue = value;
    emit(ChangeThemState());
  }

  void changeAppMode({String? fromShared})
  {
    if(fromShared!=null)
    {
      themeValue = fromShared;
      emit(ChangeThemState());
    }
    else
    {
      themeValue= themeValue=="1"? "2":"1";
      Shared.setData(key: 'heme', value: themeValue).then((value) {
        emit(ChangeThemState());
      });
    }
  }
//////////////////////
//
// FirebaseMessaging messaging = FirebaseMessaging.instance;
//
// initializeNotification()async
// {
//   FirebaseMessaging.onMessage.listen((event) {
//     print("done");
//     Fluttertoast.showToast(
//       msg:'${event.notification!.title.toString()} \n\n ${event.notification!.body.toString()}',
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.TOP,
//     );
//
//     AppCubit()..addReport(
//         reportName: "1",
//         dateTime:  '${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
//         report:'${event.notification!.body.toString()}'
//     ).then((value) {
//       print(value.toString());
//     });
//   });
//   FirebaseMessaging.onMessageOpenedApp.listen((event) {
//     AppCubit()..addReport(
//         reportName: "1",
//         dateTime: '${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
//         report:'${event.notification!.body.toString()}'
//     ).then((value) {
//       print(value.toString());
//     });
//
//     Fluttertoast.showToast(
//       msg:'${event.notification!.body.toString()}',
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.TOP,
//
//     );
//     print("done");
//
//
//   });
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//
// }
/////////////////

/// CUBIT END

}

