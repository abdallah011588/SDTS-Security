import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/home_layout/cubit/states.dart';

class ShowImageScreen extends StatelessWidget {


  final File image;
  const ShowImageScreen({required this.image}) ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        if(state is UploadImSuccessState) {
          Navigator.pop(context);
        }
      },
      builder:  (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor:  AppColors.primaryColor1,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.primaryColor1,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
            actions: [
            state is! UploadImLoadingState?
              IconButton(
                onPressed: (){
                  AppCubit.get(context).updateImage();
                },
                icon: Icon(Icons.check,color: AppColors.primaryColor2,),
              )
              :Center(child: CircularProgressIndicator(color: AppColors.primaryColor2),
            ),
            ],
          ),
          backgroundColor: Colors.black,
          body: SizedBox.expand(
            child: InteractiveViewer(
              child: Image(image: FileImage(image),),
            ),
          ),
        );
      },
    );
  }
}
