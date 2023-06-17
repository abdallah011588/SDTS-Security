import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {

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
        title: Text(getTranslated(context, 'about')!,style: TextStyle(fontWeight: FontWeight.bold,color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black),),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color:  AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset("assets/images/sdts.png",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                isAntiAlias: true,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              "SDTS Security V1.0.0",
              style:TextStyle(
                color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black54,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

