import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/home_layout/cubit/states.dart';
import 'package:graduation_project/screens/report_details_screen/report_details.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
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
            title: Text(getTranslated(context,"notification")!,style: TextStyle(color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black),),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButton(
                    underline:const SizedBox(),
                    icon: Icon(
                      Icons.more_vert,
                      color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,
                    ),
                    items: [
                      DropdownMenuItem(
                        onTap: (){
                            AppCubit.get(context).removeAllReports(context);
                        },
                        value: 'delete',
                        child: Text(
                          getTranslated(context,'delete_all')!,
                          style:const TextStyle(color: Colors.black,),
                        ),
                      ),
                    ],
                    onChanged: (value){}
                ),
              ),            ],
          ),
          body: AppCubit.get(context).reports.length>0?
          Container(
            padding: EdgeInsets.all(15),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10.0,),
                itemCount:AppCubit.get(context).reports.length,
                itemBuilder: (context, index) => InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReportsDetails(reportModel: AppCubit.get(context).reports[index]),));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:  AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.light,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      horizontalTitleGap: 0,
                      minLeadingWidth: 30,
                      minVerticalPadding: 10,
                      leading: Icon(Icons.notifications,color: AppColors.primaryColor2,),
                      title: Text(
                        "Security Warning",
                        style: TextStyle(
                          color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,
                        ),
                      ),
                      subtitle: Text(
                        AppCubit.get(context).reports[index].report,
                        // maxLines: 1,
                        style:TextStyle(
                          fontSize: 12,
                          color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black54,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete,color: Colors.red,),
                        onPressed: (){
                          AppCubit.get(context).removeReport(AppCubit.get(context).reports[index].id);
                        },
                      ),
                    ),
                  ),
                ),

              ),
            ),
          )
          :Center(
            child: Text(getTranslated(context, "no_notification")!,
              style: TextStyle(
                color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black,
                fontSize: 18,
              ),
            ),
          ),
        );
      },
    );
  }
}

