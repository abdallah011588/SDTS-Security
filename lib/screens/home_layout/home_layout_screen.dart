import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/models/notification_model.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/home_layout/cubit/states.dart';
import 'package:graduation_project/screens/login_screen/login_screen.dart';
import 'package:graduation_project/screens/notification_screen/notification_scrern.dart';
import 'package:graduation_project/shared/remote/dio_tool.dart';
import 'package:graduation_project/shared/shared_pref.dart';
import 'package:intl/intl.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();
  var formKey = GlobalKey<FormState>();

  List<String> titles=[
    'Home',
    'Devices',
    'Settings',
    'User',
  ];

  var cameraNameController =TextEditingController();
  var cameraIpController =TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
            appBar: AppBar(
              backgroundColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
              ),
              leading: IconButton(
                splashRadius: 20,
                icon: Icon(Icons.menu,color: AppColors.primaryColor2,size: 26,),
                onPressed: (){
                  scaffoldKey.currentState!.openDrawer();
                },
              ),
              actions: [
                IconButton(
                  splashRadius: 20,
                  icon: Icon(Icons.notifications,color: AppColors.primaryColor2,size: 26,),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
                  },
                ),
              ],
            ),
            body: AppCubit.get(context).screens[AppCubit.get(context).pageIndex],
            floatingActionButton:AppCubit.get(context).pageIndex ==1?
            FloatingActionButton(
              onPressed: (){
                showDialog<String>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: AppColors.primaryColor1,
                    title:  Text(getTranslated(context,"add_cam")!,style: TextStyle(color: AppColors.primaryColor2)),
                    content: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: cameraNameController,
                            keyboardType: TextInputType.text,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return getTranslated(context,"empty");
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.white60),
                            decoration: InputDecoration(
                              labelText: getTranslated(context,'cam_name'),
                              labelStyle: TextStyle(
                                color:AppColors.primaryColor2,
                              ),
                              floatingLabelStyle: TextStyle(
                                color:AppColors.primaryColor2,
                              ),
                              border: inputBorder,
                              enabledBorder:inputBorder,
                              focusedBorder:inputBorder,
                              prefixIcon: Icon(
                                Icons.camera_outdoor_outlined,
                                color:AppColors.primaryColor2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0,),
                          TextFormField(
                            controller: cameraIpController,
                            keyboardType: TextInputType.text,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return getTranslated(context,"empty");
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.white60),
                            decoration: InputDecoration(
                              labelText: getTranslated(context,'cam_ip'),
                              labelStyle: TextStyle(
                                color:AppColors.primaryColor2,
                              ),
                              floatingLabelStyle:  TextStyle(
                                color:AppColors.primaryColor2,
                              ),
                              border: inputBorder,
                              enabledBorder:inputBorder,
                              focusedBorder:inputBorder,
                              prefixIcon: Icon(
                                Icons.privacy_tip_outlined,
                                color:AppColors.primaryColor2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          cameraIpController.text="";
                          cameraNameController.text="";
                          Navigator.pop(context,'Cancel');
                        },
                        child:  Text(getTranslated(context,'cancel')!,),
                      ),
                      TextButton(
                        onPressed: () {
                         if(formKey.currentState!.validate())
                           {
                             AppCubit.get(context).addCamera(
                               cameraName: cameraNameController.text,
                               url: cameraIpController.text,
                             ).then((value) {
                               cameraIpController.text="";
                               cameraNameController.text="";
                               Navigator.pop(context,'Cancel');
                             });
                           }
                        },
                        child: Text(getTranslated(context,'ok')!,style: TextStyle(color: AppColors.primaryColor2)),
                      ),
                    ],

                  ),
                );
              },
              backgroundColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.light,
              child: Icon(Icons.add,color: AppColors.primaryColor2,),
            ) : null,

            drawer: Container(
              color: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
              width: MediaQuery.of(context).size.width*(2/3),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 200,
                    width: double.infinity,
                    color: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
                    child: Center(
                      child:Image.asset("assets/images/sdts.png") ,
                    ),
                  ),
                  Divider(color: AppColors.grey,thickness: 2),
                  Container(
                    height: 400,
                    color: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
                    child: Drawer(
                      elevation: 0,
                      backgroundColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
                      child: ListView(
                        //shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ListTile(
                            leading: Icon(Icons.notifications,color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.primaryColor3,),
                            title:Text(getTranslated(context,'notification')!,
                              style: TextStyle(fontSize: 18,color: AppColors.primaryColor2,),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
                              //AppCubit.get(context).userResetPassword(email: 'a860000.94@gmail.com');
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.help_center_rounded,color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.primaryColor3,),
                            title:Text(getTranslated(context,'help')!,
                              style: TextStyle(fontSize: 18,color: AppColors.primaryColor2,),
                            ),
                            onTap: (){
                              //print(Shared.getString(key: "FCMToken"));
                              //Isolate.spawn(sendNoty,1);
                            },
                          ),
                          ListTile(
                            hoverColor: Colors.red,
                            leading: Icon(Icons.logout ,color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.primaryColor3,),
                            title:Text(getTranslated(context,'sign_out')!,
                              style: TextStyle(fontSize: 18,color: AppColors.primaryColor2,),
                            ),
                            onTap: (){

                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  backgroundColor: AppColors.primaryColor1,
                                  title:  Text(getTranslated(context,'sign_out')!,style: TextStyle(color: AppColors.primaryColor2)),
                                  content: Text(getTranslated(context,'try_sign_out')!,style: TextStyle(color: AppColors.white70)),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context,'Cancel'),
                                      child:  Text(getTranslated(context,'cancel')!,),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Shared.setData(key: 'isLogin', value: false).then((value) {
                                          Shared.removeData(key: 'uId',).then((value) {
                                            UID='';
                                            AppCubit.get(context).signOut();
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false,
                                            );
                                          });

                                        });

                                      },
                                      child: Text(getTranslated(context,'ok')!,style: TextStyle(color: AppColors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              height: 60,
              index: AppCubit.get(context).pageIndex,
              backgroundColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
              color: AppColors.primaryColor2,
              animationDuration: const Duration(milliseconds:300),
              //animationCurve: Curves.easeInToLinear,
              // letIndexChange: (index)=>true,
              items: const <Widget>[
                Icon(Icons.home_outlined, size: 25),
                Icon(Icons.camera_outdoor, size: 25),
                Icon(Icons.settings, size: 25),
                Icon(Icons.person, size: 25),
              ],
              onTap: (index) {
                setState(() {
                  AppCubit.get(context).changeScreen(index);
                });
              },
            ),
          );
     },

    );

  }
}


sendNotys(context)async
{
  Timer t=Timer.periodic(Duration(seconds: 25), (timer) {
    AppCubit.get(context).dbRef.get().then((DataSnapshot value) {
      Map<String, dynamic> _post = Map<String, dynamic>.from(value.value as Map);

      if(_post["dd"].toString()=="1")
      {
        AppNotification app_notification=AppNotification(
            title: "Security Warning",
            body: "One of the cameras detected a \"Fire\" seconds ago",
            mutableContent: true,
            sound: "alarm.mp3"
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
        });
        AppCubit.get(context).dbRef.child("dd").set("0");
        AppCubit.get(context).addReport(
            reportName: "1",
            dateTime:  '${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
            report:"One of the cameras detected a \"Fire\" on ${DateFormat.yMMMMEEEEd().format(DateTime.now())} at ${DateFormat.jm().format(DateTime.now())}"
        );
      }

      else if(_post["dd"].toString()=="2")
      {
        AppNotification app_notification=AppNotification(
            title: "Security Warning",
            body: "One of the cameras detected a \"person carrying a weapon\" seconds ago",
            mutableContent: true,
            sound: "alert.mp3"
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
        });
        AppCubit.get(context).dbRef.child("dd").set("0");
        AppCubit.get(context).addReport(
            reportName: "2",
            dateTime:  '${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
            report:"One of the cameras detected a \"person carrying a weapon\" on ${DateFormat.yMMMMEEEEd().format(DateTime.now())} at ${DateFormat.jm().format(DateTime.now())}"
        );
      }

      else if(_post["dd"].toString()=="3")
      {
        AppNotification app_notification=AppNotification(
            title: "Security Warning",
            body: "One of the cameras detected a \"person wearing a mask\" seconds ago",
            mutableContent: true,
            sound: "alert.mp3"
        );
        Data notData=Data(
            type: "order",
            id: "100",
            clickAction: "FLUTTER_ACTION_DEFAULT"
        );
        NotificationModel notifyModel= NotificationModel(
          to: Shared.getString(key: "FCMToken")!,
          //to: "fByinBsVT_afQzSlDaB-0E:APA91bG0LbnTcIFGdexYtxhl0Y8QLoeNQwbUrmVHqvo0ue1stEZu6XKfj0UAa_J7vKHYpezWBD0XGKXSxBrCf2OfGSB_2X6Izu5iHxTLrJ7T6iir0jVhngxetLjy4aVzJW14zp2PMOZQ",
          notification: app_notification,
          data: notData,
        );
        dioTool.postData(data: notifyModel.toJson()).then( (value) {
          print('successful process of sending notification');
        });
        AppCubit.get(context).dbRef.child("dd").set("0");
        AppCubit.get(context).addReport(
            reportName: "3",
            dateTime:  '${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
            report:"One of the cameras detected a \"person wearing a mask\" on ${DateFormat.yMMMMEEEEd().format(DateTime.now())} at ${DateFormat.jm().format(DateTime.now())}"
        );
      }

      else if(_post["dd"].toString()=="4")
      {
        AppNotification app_notification=AppNotification(
            title: "Security Warning",
            body: "One of the cameras detected a \"strange person\" seconds ago",
            mutableContent: true,
            sound: "alert.mp3"
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
        });
        // AppCubit.get(context).sendNotification(title: "Security Warning", body: "Some devices detected \"X\" right now ");
        AppCubit.get(context).dbRef.child("dd").set("0");

        AppCubit.get(context).addReport(
            reportName: "4",
            dateTime:  '${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
            report:"One of the cameras detected a \"strange person\" on ${DateFormat.yMMMMEEEEd().format(DateTime.now())} at ${DateFormat.jm().format(DateTime.now())}"
        );
      }

    });
  });

}
