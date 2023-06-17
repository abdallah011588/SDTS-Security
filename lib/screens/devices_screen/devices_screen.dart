import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/screens/camera_stream/camera_stream.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/home_layout/cubit/states.dart';


class DevicesScreen extends StatelessWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
          return AppCubit.get(context).cameras.length>0?
           Container(
            padding: EdgeInsets.all(15),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child:ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10,),
                itemCount: AppCubit.get(context).cameras.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>CameraStreamScreen(url: AppCubit.get(context).cameras[index].url),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color:  AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.light,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: ListTile(
                      title: Text(
                        AppCubit.get(context).cameras[index].name,
                        style: TextStyle(color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,
                        ),),
                      subtitle: Text(
                        AppCubit.get(context).cameras[index].url,
                        style:TextStyle(
                          color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black54,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete,color: Colors.red,),
                        onPressed: (){
                          AppCubit.get(context).removeCamera(AppCubit.get(context).cameras[index].id);
                        },
                      ),
                    ),
                  ),
                ),
              ) ,
            ),
          )
           :Center(
            child: Text(getTranslated(context, "no_devices")!,
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



/*

 StreamBuilder(
        stream:AppCubit.get(context).dbRef.child("detector").onValue,//getDataFromRealTime() ,
        builder: (context,AsyncSnapshot snapshot) {
        List<UserModel> dataList = [];

        if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value !=null)
        {

         final myData = Map<dynamic, dynamic>.from( (snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>);
         myData.forEach((key, value) {
         final currentData = Map<String, dynamic>.from(value);
         dataList.add(
          UserModel(
          name: currentData["name"],
          email: currentData["email"] ,
          phone: currentData["phone"] ,
          uId: currentData["uId"] ,
          image: currentData["image"] ,
          address: currentData["address"] ,
          gender: currentData["gender"] ,
          age: currentData["age"]
          ),
          );
              });

            if(dataList[0].age ==10 || dataList[0].age ==20)
           {
             AppCubit.get(context).sendNotification(title: "Abdo", body: "age 10 or 20");
           }
       /// //////////////////////
        return Column(
          children: [
            Text(
            //  snapshot.data.toString(),
              dataList[0].name!,
              style: TextStyle(color: AppColors.primaryColor2),),
            Text(
              dataList[0].email!,
              style: TextStyle(color: AppColors.primaryColor2),),
            Text(
            //  snapshot.data.toString(),
              dataList[0].phone!,
              style: TextStyle(color: AppColors.primaryColor2),),
            Text(
              dataList[0].address!,
              style: TextStyle(color: AppColors.primaryColor2),),
            Text(
              dataList[0].age!.toString(),
              style: TextStyle(color: AppColors.primaryColor2),
            ),
          ],
        );
       }
        else
        {
         return Text('No data');
        }

       }),

 */