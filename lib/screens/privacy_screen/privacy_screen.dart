import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/constants/privacy.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var keys = privacyString.keys.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor:  AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined,color:AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,),
        ),
        title: Text(getTranslated(context, 'privacy')!,style: TextStyle(fontWeight: FontWeight.bold,color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black),),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color:  AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.white,
        child: ListView.builder(
          itemCount: privacyString.length,
          itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              keys[index],
              style: TextStyle(
                color: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor2:AppColors.black,
                fontSize: 25,
              ),
            ),
            subtitle: Text(
             privacyString[keys[index]],
             style: TextStyle(
             color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black54,
             fontSize: 18,
          ),
            ),
          ) ;
        },),
      ),
    );
  }
}

