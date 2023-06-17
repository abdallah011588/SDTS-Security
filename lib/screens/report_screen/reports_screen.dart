
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/home_layout/cubit/states.dart';
import 'package:graduation_project/screens/report_details_screen/report_details.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
       return AppCubit.get(context).reports.length>0?
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
                  height: 150,
                  decoration: BoxDecoration(
                    color:  AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.light,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("assets/images/img2.jpg",
                          height: 200,
                          width: 100,
                          fit: BoxFit.cover,
                          isAntiAlias: true,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              getTranslated(context, "report")!+" ${index+1}",
                              style: TextStyle(
                                color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              AppCubit.get(context).reports[index].report,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:TextStyle(
                                color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black54,
                              ),
                            ),
                            Text(
                              AppCubit.get(context).reports[index].dateTime,
                              style:TextStyle(
                                color:AppColors.primaryColor2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DropdownButton(
                          underline:const SizedBox(),
                          icon: Icon(
                            Icons.more_vert,
                            color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,
                          ),
                          items: [
                            DropdownMenuItem(
                              onTap: (){
                                setState(() {
                                  AppCubit.get(context).removeReport(AppCubit.get(context).reports[index].id);
                                });
                              },
                              value: 'delete',
                              child: Text(
                                getTranslated(context,'delete')!,
                                style:const TextStyle(color: Colors.black,),
                              ),
                            ),
                          ],
                          onChanged: (value){
                            // setState(() {});
                            //   AppCubit.get(context).removeReport(AppCubit.get(context).reports[index].id);
                          }
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.delete,color: Colors.red,),
                      //   onPressed: (){
                      //     setState(() {
                      //       AppCubit.get(context).removeReport(AppCubit.get(context).reports[index].id);
                      //     });
                      //     },
                      // ),
                    ]
                    ,),
                ),
              ),

            ),
          ),
        )
         :Center(
          child: Text(getTranslated(context, "no_reports")!,
           style: TextStyle(
             color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black,
             fontSize: 18,
           ),
         ),
       );
      },
    );
  }

}


