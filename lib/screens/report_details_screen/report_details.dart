import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/models/report_model.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';

class ReportsDetails extends StatelessWidget {
  const ReportsDetails({Key? key,required this.reportModel}) : super(key: key);
   final ReportModel reportModel;
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
        title: Text(getTranslated(context,"report_details")!,style: TextStyle(color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black),),
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: (){
              AppCubit.get(context).removeReport(reportModel.id);
              Navigator.pop(context);
            },
            icon:
           // state is! UpdateUserLoadingState?
            Icon(
              Icons.delete_outline,
              color:AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,
            )
              //  :Center(child: CircularProgressIndicator(color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,)),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color:  AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset("assets/images/img2.jpg",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                isAntiAlias: true,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              reportModel.report,
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

