
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/home_layout/cubit/states.dart';

class updateFields extends StatelessWidget {

  var formKey=GlobalKey<FormState>();
  var controller=TextEditingController();

  final String title;
  final String field;
  updateFields({ required this.title,required this.field}) ;

  @override
  Widget build(BuildContext context) {

    controller.text=field;

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder:  (context, state) {
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
              splashRadius: 25,

              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_outlined,color:AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,),
            ),
            title: Text(getTranslated(context,title)!,style: TextStyle(color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black),),
            actions: [
              IconButton(
                splashRadius: 20,
                onPressed: (){
                if(formKey.currentState!.validate())
                  {
                    if(title =="User Name")
                    {
                      AppCubit.get(context).updateUser(name:controller.text);
                      Navigator.pop(context);
                    }
                    if(title =='Phone')
                    {
                      AppCubit.get(context).updateUser(phone:controller.text );
                      Navigator.pop(context);
                    }
                    if(title =='Email')
                    {
                      AppCubit.get(context).updateUser(email:controller.text );
                      Navigator.pop(context);
                    }
                  }
                },
                icon: state is! UpdateUserLoadingState?
                Icon(Icons.check,color:AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,)
                :Center(child: CircularProgressIndicator(color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,)),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: inputBorder,
                  enabledBorder:inputBorder,
                  focusedBorder:inputBorder,
                ),
                style: TextStyle(color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black54,),
                keyboardType: title=="Phone" ? TextInputType.phone:TextInputType.text,
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
