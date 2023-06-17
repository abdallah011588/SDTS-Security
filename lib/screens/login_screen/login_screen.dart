
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/home_layout/cubit/states.dart';
import 'package:graduation_project/screens/home_layout/home_layout_screen.dart';
import 'package:graduation_project/screens/register_screen/register_screen.dart';

import 'package:graduation_project/shared/shared_pref.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey=GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
          if(state is LoginSuccessState)
          {
           // emailController.clear();
           // passwordController.clear();
            print('login view *********************************');
            UID=state.uId;
            Shared.setData( key: 'uId', value: state.uId ).then((value) {
              AppCubit.get(context).getUserData();
              //AppCubit.get(context).getAllUsers();
              Shared.setData(key: 'isLogin', value: true).then((value) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeLayoutScreen(),), (route) => false,
                );
              });
              print(state.uId +'in login state.uid tap');
              Fluttertoast.showToast(
                msg: getTranslated(context,'sign_successfully')!,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                timeInSecForIosWeb: 5,
                toastLength: Toast.LENGTH_LONG,
              );

            }).catchError((error){
              print(error.toString());
            });
          }
          if( state is LoginErrorState)
          {
            Fluttertoast.showToast(
              msg:
              state.error.toString().contains('[firebase_auth/email-already-in-use]')?
              state.error.toString().replaceAll('[firebase_auth/email-already-in-use]', '')
                  :state.error.toString().contains('[firebase_auth/invalid-email]')?
              state.error.toString().replaceAll('[firebase_auth/invalid-email]', ''):
              state.error.toString().contains('[firebase_auth/wrong-password]')?
              state.error.toString().replaceAll('[firebase_auth/wrong-password]', ''):
              state.error.toString().contains('[firebase_auth/too-many-requests]')?
              state.error.toString().replaceAll('[firebase_auth/too-many-requests]', '')
                  :state.error.toString().replaceAll('[firebase_auth/user-not-found]', '')
              ,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              timeInSecForIosWeb: 5,
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
                            getTranslated(context,'welcome')! ,
                            textAlign: TextAlign.center,
                            style:TextStyle(
                              color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,
                              fontSize: 35,
                            ),
                          ),
                        ),
                        Text(
                          getTranslated(context,'continue')! ,
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
                          style: TextStyle(color: AppCubit.get(context).themeValue=="2"? AppColors.white60:AppColors.black),
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

                        /// PASSWORD TEXT FORM FIELD
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return getTranslated(context,'pass_empty')!;
                            }
                            else if(value.length<6)
                            {
                              return getTranslated(context,'pass_format')!;
                            }
                            return null;
                          },
                          obscureText: AppCubit.get(context).isPass,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          style:  TextStyle(color:  AppCubit.get(context).themeValue=="2"? AppColors.white60:AppColors.black),
                          decoration: InputDecoration(
                            labelText:  getTranslated(context,'password')!,
                            border: inputBorder,
                            enabledBorder:inputBorder,
                            focusedBorder:inputBorder,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color:AppColors.primaryColor2,
                            ),
                            labelStyle: TextStyle(
                              color:AppColors.primaryColor2,
                            ),
                            floatingLabelStyle:  TextStyle(
                              color:AppColors.primaryColor2,
                            ),
                            suffixIcon: IconButton(
                              onPressed: ()
                              {
                                AppCubit.get(context).showPassword();
                              },

                              icon: Icon(
                                AppCubit.get(context).visibilityIcon,
                                color:AppColors.primaryColor2,
                              ),
                            ),
                          ),
                        ),

                        /// Forgot Password Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen(),));
                              },
                              child:  Text(
                                getTranslated(context,'forgot_password')!,
                                style: TextStyle(
                                  color: AppCubit.get(context).themeValue=="2"? AppColors.white60:AppColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0,),

                        /// Sign In Button
                        Container(
                          width: double.infinity,
                          child: state is! LoginLoadingState?
                          MaterialButton(
                            height: 50.0,
                            color: AppColors.primaryColor2,
                            shape: StadiumBorder(),
                            onPressed: (){
                              if(formKey.currentState!.validate())
                              {
                                AppCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            child: Text(
                              getTranslated(context,'sign_in')!,
                              style: TextStyle(color: AppColors.primaryColor1,fontSize: 16),),
                          )
                              : Center(child: CircularProgressIndicator(color:AppColors.primaryColor2,)),
                        ),

                        const SizedBox(height: 10.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getTranslated(context,'have_no_account')!,
                              style:  TextStyle(
                                color:AppColors.primaryColor2,
                              ),
                            ),
                            const SizedBox(width: 5.0,),
                            TextButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => register_screen(),),
                                );
                              },
                              child:  Text(
                                getTranslated(context,'register')!,
                                style: TextStyle(
                                  color:  AppCubit.get(context).themeValue=="2"? AppColors.white60:AppColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
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
    passwordController.dispose();
    super.dispose();
  }

}




// String getTranslated(BuildContext context, String s) {
//   return s;
// }
