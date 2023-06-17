
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/home_layout/cubit/states.dart';


class ForgotPasswordScreen extends StatefulWidget{
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final formKey=GlobalKey<FormState>();
  final emailController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
          if(state is ResetPassSuccessState)
          {
            Fluttertoast.showToast(
              msg: 'Check your Email',
              gravity: ToastGravity.TOP,
              backgroundColor: AppColors.primaryColor2,
              textColor: Colors.white,
              timeInSecForIosWeb: 30,
              toastLength: Toast.LENGTH_LONG,
            );
          }
          if( state is ResetPassErrorState)
          {
            Fluttertoast.showToast(
              msg:
              state.error.toString().contains('[firebase_auth/email-already-in-use]')?
              state.error.toString().replaceAll('[firebase_auth/email-already-in-use]', '')
                  :state.error.toString().contains('[firebase_auth/invalid-email]')?
              state.error.toString().replaceAll('[firebase_auth/invalid-email]', ''):
              state.error.toString().contains('[firebase_auth/too-many-requests]')?
              state.error.toString().replaceAll('[firebase_auth/too-many-requests]', '')
                  :state.error.toString().replaceAll('[firebase_auth/user-not-found]', '')
              ,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              timeInSecForIosWeb: 30,
              toastLength: Toast.LENGTH_LONG,
            );
            print(state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child:Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            getTranslated(context,'welcome' )!,
                            textAlign: TextAlign.center,
                            style:TextStyle(
                              color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,
                              fontSize: 38,
                            ),
                          ),
                        ),
                        Text(
                          getTranslated(context, "reset1")!,
                          textAlign: TextAlign.center,
                          style:TextStyle(
                            color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,
                            fontSize: 20,
                          ),
                        ),

                        const SizedBox(height: 45.0,),

                        /// EMAIL TEXT FORM FIELD
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return getTranslated(context,'email_empty')!;
                            }
                            else if(!value.contains('@') || !value.contains('.com'))
                            {
                              return getTranslated(context,'email_format')!;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          style: TextStyle(color:  AppCubit.get(context).themeValue=="2"? AppColors.white60:AppColors.black),
                          decoration: InputDecoration(
                              labelText: getTranslated(context,'email')!,
                              border: inputBorder,
                              enabledBorder:inputBorder,
                              focusedBorder:inputBorder,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color:AppColors.primaryColor2,
                              ),
                              labelStyle:  TextStyle(
                                color:AppColors.primaryColor2,
                              )
                          ),
                        ),
                        const SizedBox(height: 30.0,),

                        /// Forgot Password Button

                        state is ResetPassLoadingState?
                        Center(child: CircularProgressIndicator(color:AppColors.primaryColor2,))
                        : SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            height: 50.0,
                            color: AppColors.primaryColor2,
                            shape: StadiumBorder(),
                            onPressed: (){
                              if(formKey.currentState!.validate())
                              {
                                AppCubit.get(context).userResetPassword(
                                  email: emailController.text,
                                );
                              }
                            },
                            child: Text(
                              getTranslated(context, "reset2")!,
                              style: TextStyle(color: AppColors.primaryColor1,fontSize: 16),),
                          ),
                        ),
                       /* : state is! ResetPassSuccessState?*/
                        // : Center(
                        //   child: Column(
                        //     children: [
                        //       Icon(
                        //         Icons.check_circle_outlined,
                        //         color: AppColors.primaryColor2,
                        //         size: 55,
                        //       ),
                        //       SizedBox(height: 5,),
                        //       Text(
                        //         'Check your email' ,
                        //         textAlign: TextAlign.center,
                        //         style:TextStyle(
                        //           color: AppColors.white70,
                        //           fontSize: 15,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

}




// String getTranslated(BuildContext context, String s) {
//   return s;
// }
