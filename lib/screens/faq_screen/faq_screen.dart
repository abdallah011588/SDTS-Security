import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/constants/faq.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key,}) : super(key: key);
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
        title: Text(getTranslated(context, 'faq')!,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color:  AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.white,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ExpansionTile(
              // textColor: AppColors.blue,
              collapsedIconColor: AppColors.primaryColor2,
              collapsedTextColor: AppCubit.get(context).themeValue=="2"? AppColors.white70 : AppColors.black,
              title: Text(
               '${faqStrings[index]['question']}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                  '${faqStrings[index]['answer']}',
                    style: TextStyle(fontSize: 16,height: 2,
                        color:AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black54 ,
                    ),
                  ),
                ),
              ],
              backgroundColor:AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.white,
            );
          },
          itemCount: faqStrings.length,
          separatorBuilder:(context, index)=> SizedBox(height: 10,),
        ),
      ),
    );
  }
}

