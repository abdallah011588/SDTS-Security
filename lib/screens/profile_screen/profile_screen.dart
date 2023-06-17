import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/home_layout/cubit/states.dart';
import 'package:graduation_project/screens/show_image_screen/show_image_screen.dart';
import 'package:graduation_project/screens/update_fields_screen/update_fields_screen.dart';


class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var bioController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 0.0,bottom: 0),
                  child: Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.light,
                          radius: 140,
                          backgroundImage: NetworkImage(AppCubit.get(context).userData!.image!,),
                        ),
                        IconButton(
                          splashRadius: 25,
                          onPressed: (){
                            showDialog<String>(
                              context: context,
                              builder:(BuildContext context)=>AlertDialog(
                                backgroundColor: AppColors.primaryColor1,
                                title: Text(getTranslated(context,'select_image')! ,style: TextStyle(color: AppColors.primaryColor2)),
                                content: Text(getTranslated(context,'select_image2')!,style: TextStyle(color: AppColors.white70)),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);},
                                    child: Text(getTranslated(context,'cancel')!,),
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      AppCubit.get(context).getImageFromCamera().then((value) {

                                        if(AppCubit.get(context).Image !=null)
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ShowImageScreen(image:AppCubit.get(context).Image!),),
                                        ).then((value) {
                                          Navigator.pop(context);
                                        });
                                      });

                                    },
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      color: AppColors.primaryColor2,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      AppCubit.get(context).getImage().then((value) {
                                        if(AppCubit.get(context).Image !=null)
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ShowImageScreen(image:AppCubit.get(context).Image!),),
                                        ).then((value) {
                                          Navigator.pop(context);
                                         // AppCubit.get(context).Image=null;
                                        });
                                      });
                                    },
                                    icon: Icon(
                                      Icons.image_outlined,
                                      color:  AppColors.primaryColor2,

                                    ),
                                  ),
                                ],
                              ),
                            );

                            /*  if(state is appGetImageSuccessState)
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => showImageScreen(image:appCubit.get(context).Image!),));
                              }*/
                          },
                          icon: CircleAvatar(
                            backgroundColor:AppColors.primaryColor2 ,
                            child: Icon(Icons.add_a_photo_rounded,color: AppColors.primaryColor1,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          getTranslated(context, 'account')!,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: AppColors.primaryColor2),
                        ),
                      ),
                      SizedBox(height: 15,),
                      InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => updateFields(
                                    title:'User Name',
                                    field: AppCubit.get(context).userData!.name!,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.person,size: 20,color: AppColors.primaryColor2,),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: Text(
                                    AppCubit.get(context).userData!.name!,
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black),
                                  ),
                                ),
                              ),
                               Icon(Icons.edit,size: 20,color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.grey,),
                            ],
                          )),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => updateFields(
                                  title:'Phone',
                                  field:AppCubit.get(context).userData!.phone!,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.phone,size: 20,color: AppColors.primaryColor2,),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(AppCubit.get(context).userData!.phone!,
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,
                                        color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,
                                    ),
                                ),
                              ),
                            ),
                             Icon(Icons.edit,size: 20,color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.grey,),

                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color:Colors.grey[300],
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => updateFields(
                                title:'Email',
                                field: AppCubit.get(context).userData!.email!),
                            ),
                          );
                        },
                        child:Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.email,
                              size: 20,
                              color: AppColors.primaryColor2,
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(AppCubit.get(context).userData!.email!,
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,
                                        color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,
                                    ),
                                ),
                              ),
                            ),
                             Icon(Icons.edit,size: 20,color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.grey,),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color:Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/* appBar: AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.all(15),
                child: DropdownButton(
                    underline: SizedBox(),
                    icon: Icon(
                      Icons.language_outlined,
                      color:appCubit.get(context).isdark? Colors.white:Colors.white,
                    ),
                    items: Language.languageList()
                        .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                      value: lang,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            lang.flag,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(lang.name,
                            style: TextStyle(color: Colors.black,),
                          ),
                        ],
                      ),
                    )).toList(),
                    onChanged: (value){
                      Language lang=value as Language;
                      _changeLanguage(lang,context);
                      // print(lang.name);
                      //print(lang.languageCode);
                    }
                ),
              )
            ],
            elevation: 0.0,
          ),*/
