import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/home_layout/cubit/states.dart';
import 'package:graduation_project/screens/home_layout/home_layout_screen.dart';
import 'package:graduation_project/shared/shared_pref.dart';
import 'package:intl_phone_field/intl_phone_field.dart';



class register_screen extends StatefulWidget{
  register_screen({Key? key}) : super(key: key);

  @override
  State<register_screen> createState() => _register_screenState();
}

class _register_screenState extends State<register_screen> {
  var formKey=GlobalKey<FormState>();

  var nameController=TextEditingController();

  var emailController=TextEditingController();

  var phoneController=TextEditingController();

  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {

  return BlocConsumer<AppCubit,AppStates>(
    listener: (context, state) {


      if(state is CreateUserSuccessState)
      {

        UID=state.uId;
        Shared.setData( key: 'uId', value: state.uId ).then((value) {
          AppCubit.get(context).getUserData();
          //AppCubit.get(context).getAllUsers();
          Shared.setData(key: 'isLogin', value: true).then((value) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeLayoutScreen(),), (route) => false,
            ).then((value) {
            });
          });
          print(state.uId +'in login state.uid tap');
          Fluttertoast.showToast(
            msg: 'Sign_success',
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

      if(state is RegisterErrorState )
      {
        print('REGISTER ERROR : ${state.error}');
        Fluttertoast.showToast(
          msg: '${
              state.error.toString().contains('[firebase_auth/email-already-in-use]')?
              state.error.toString().replaceAll('[firebase_auth/email-already-in-use]', '')
                  :state.error.toString().contains('[firebase_auth/invalid-email]')?
              state.error.toString().replaceAll('[firebase_auth/invalid-email]', '')
                  : state.error.toString().replaceAll('[firebase_auth/weak-password]', '')
          }',
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          timeInSecForIosWeb: 5,
          toastLength: Toast.LENGTH_LONG,
        );
      }

    },
    builder: (context, state) {
      return Scaffold(
          // appBar: AppBar(
          //   title: Text(getTranslated(context,'Register'),),
          // ),
        backgroundColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,

          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(
                          getTranslated(context,'create_account')!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.0,
                            color: AppCubit.get(context).themeValue=="2"? AppColors.white:AppColors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 45.0,),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return getTranslated(context,'Name_empty');
                          }
                          return null;
                        },
                        style:  TextStyle(color: AppCubit.get(context).themeValue=="2"? AppColors.white60:AppColors.black),
                        decoration: InputDecoration(
                          labelText: getTranslated(context,'user_name'),
                          labelStyle: TextStyle(
                            color:AppColors.primaryColor2,
                          ),
                          floatingLabelStyle:  TextStyle(
                            color:AppColors.primaryColor2,
                          ),
                          border: inputBorder,
                          enabledBorder:inputBorder,
                          focusedBorder:inputBorder,
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color:AppColors.primaryColor2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return getTranslated(context,"email_empty")!;
                          }
                          else if(!value.contains('@') || !value.contains('.com'))
                          {
                            return getTranslated(context,"email_format")!;
                          }
                          return null;
                        },
                        style:  TextStyle(color: AppCubit.get(context).themeValue=="2"? AppColors.white60:AppColors.black),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: getTranslated(context,"email")!,
                          labelStyle: TextStyle(
                            color:AppColors.primaryColor2,
                          ),
                          floatingLabelStyle:  TextStyle(
                            color:AppColors.primaryColor2,
                          ),
                          border: inputBorder,
                          enabledBorder:inputBorder,
                          focusedBorder:inputBorder,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color:AppColors.primaryColor2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      IntlPhoneField(
                        dropdownTextStyle: TextStyle(color: Colors.white60),
                        dropdownIcon: Icon(Icons.arrow_drop_down,color: AppColors.primaryColor2,),
                        style:  TextStyle(color: AppCubit.get(context).themeValue=="2"? AppColors.white60:AppColors.black),
                        decoration: InputDecoration(
                          labelText: getTranslated(context,'Phone')!,
                          labelStyle: TextStyle(
                            color:AppColors.primaryColor2,
                          ),
                          floatingLabelStyle:  TextStyle(
                            color:AppColors.primaryColor2,
                          ),
                          border: inputBorder,
                          enabledBorder:inputBorder,
                          focusedBorder:inputBorder,
                          counterText: "",
                        ),
                        controller: phoneController,
                        initialCountryCode: 'EG',
                        onChanged: (phone) {
                         // print(phone.completeNumber);
                        },
                      ),

                      /*
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return  getTranslated(context,'Phone_empty');
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white60),
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText:getTranslated(context,'Phone'),
                        labelStyle: TextStyle(
                          color:AppColors.primaryColor2,
                        ),
                        floatingLabelStyle:  TextStyle(
                          color:AppColors.primaryColor2,
                        ),
                        border: inputBorder,
                        enabledBorder:inputBorder,
                        focusedBorder:inputBorder,
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          color:AppColors.primaryColor2,
                        ),
                      ),
                    ),
                    */
                      const SizedBox(height: 20.0,),
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
                        style:  TextStyle(color: AppCubit.get(context).themeValue=="2"? AppColors.white60:AppColors.black),
                        obscureText:AppCubit.get(context).isPass,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText:  getTranslated(context,'password')!,
                          labelStyle: TextStyle(
                            color:AppColors.primaryColor2,
                          ),
                          floatingLabelStyle:  TextStyle(
                            color:AppColors.primaryColor2,
                          ),
                          border: inputBorder,
                          enabledBorder:inputBorder,
                          focusedBorder:inputBorder,
                          prefixIcon: Icon(
                            Icons.lock_outlined,
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
                      const SizedBox(height: 25.0,),
                      SizedBox(
                        width: double.infinity,
                        child: state is! RegisterLoadingState?
                        MaterialButton(
                          height: 50.0,
                          color: AppColors.primaryColor2,
                          shape: StadiumBorder(),
                          onPressed: (){
                            if(formKey.currentState!.validate())
                            {
                              AppCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                              print('register');
                            }
                          },
                          child:Text(
                            getTranslated(context,'register')!,
                            style: TextStyle(color: AppColors.primaryColor1,fontSize: 16),
                          ),
                        )
                            : Center(child: CircularProgressIndicator(color: AppColors.primaryColor2,)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
    } ,

   );
  }



  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }


}
