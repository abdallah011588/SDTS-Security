
import 'package:flutter/material.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/lang_models/language.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/main.dart';
import 'package:graduation_project/screens/about_screen/about_screen.dart';
import 'package:graduation_project/screens/faq_screen/faq_screen.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/login_screen/login_screen.dart';
import 'package:graduation_project/screens/privacy_screen/privacy_screen.dart';
import 'package:graduation_project/shared/shared_pref.dart';
import 'package:share_plus/share_plus.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<Language> langs= Language.languageList();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:  NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
         child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            Card(
              color: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.light,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
                    child: Text(getTranslated(context,'settings')!,style: TextStyle(color: AppColors.blue,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  /// ////////////////////////////////
                  ExpansionTile(
                    title: Text(
                      getTranslated(context,'report')!,
                      style: TextStyle(fontSize: 18,color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black),
                    ),
                    backgroundColor:  AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.light,
                    collapsedIconColor:  AppColors.primaryColor2,
                    leading: Icon(Icons.report_problem_outlined,color: AppColors.primaryColor2,),
                    childrenPadding: EdgeInsets.symmetric(horizontal: 30),
                    children: [
                      Center(
                        child: Row(
                          children: [
                            Text(getTranslated(context, "saveReport")!,style: TextStyle(fontSize: 18 ,color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black),),
                            Switch.adaptive(activeColor: AppColors.primaryColor2,
                              value: AppCubit.get(context).isActive, onChanged:(value){
                              setState(() {
                                AppCubit.get(context).isActive = !AppCubit.get(context).isActive;
                                Shared.setData(key: 'saveReport', value: AppCubit.get(context).isActive);

                              });
                            }),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                    ],
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(color: AppCubit.get(context).themeValue=="2"? AppColors.black:AppColors.grey,thickness: 1,),
                  ),
                  ExpansionTile(
                    title: Text(
                      getTranslated(context,'language')!,
                      style: TextStyle(fontSize: 18,color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black),
                    ),
                    backgroundColor:  AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.light,
                    collapsedIconColor:  AppColors.primaryColor2,
                    leading: Icon(Icons.language,color: AppColors.primaryColor2,),
                    children: [
                      RadioListTile(
                        value: '1',
                        title: Text(getTranslated(context,'arabic')!,style: TextStyle(color:  AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black),),
                        subtitle: Text(langs[1].flag,style: TextStyle(color: AppColors.white70),),
                        groupValue:AppCubit.get(context).groupValue ,
                        activeColor: AppColors.green,
                        onChanged: (value1){
                          setState(() {

                          });
                          Shared.setData(key: 'currentLang', value: value1.toString()).then((value) {
                            AppCubit.get(context).changeLanguage(value1.toString());
                            _changeLanguage(langs[1] , context);
                            //Navigator.pop(context);
                          });
                        },
                      ),
                      RadioListTile(
                        value:'2',
                        groupValue: AppCubit.get(context).groupValue,
                        title: Text(getTranslated(context,'english')! ,style: TextStyle(color:  AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black),),
                        subtitle: Text(langs[0].flag,style: TextStyle(color: AppColors.white70),),
                        activeColor:  AppColors.green,
                        onChanged: (value1){
                          setState(() {

                          });
                          Shared.setData(key: 'currentLang', value: value1.toString()).then((value) {
                            AppCubit.get(context).changeLanguage(value1.toString());
                            _changeLanguage(langs[0] , context);
                            //Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(color:AppCubit.get(context).themeValue=="2"? AppColors.black:AppColors.grey,thickness: 1,),
                  ),
                  ExpansionTile(
                    title: Text(
                      getTranslated(context,'theme')!,
                      style: TextStyle(fontSize: 18,color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black),
                    ),
                    backgroundColor:  AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.light,
                    collapsedIconColor:  AppColors.primaryColor2,
                    leading: Icon(Icons.dark_mode_outlined,color: AppColors.primaryColor2,),
                    children: [
                      RadioListTile(
                        value: '1',
                        title: Text(getTranslated(context,'light')!,style: TextStyle(color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black),),
                        groupValue:AppCubit.get(context).themeValue ,
                        activeColor: AppColors.blue,
                        onChanged: (value1){
                         setState(() {
                           AppCubit.get(context).changeAppMode();
                           Shared.setData(key: 'theme', value: value1.toString()).then((value) {
                             AppCubit.get(context).changeTheme(value1.toString());
                           });
                         });
                        },
                      ),
                      RadioListTile(
                        value:'2',
                        groupValue: AppCubit.get(context).themeValue,
                        title: Text(getTranslated(context,'dark')! ,style: TextStyle(color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black),),
                        activeColor:  AppColors.blue,
                        onChanged: (value1){
                          setState(() {
                            AppCubit.get(context).changeAppMode();
                            Shared.setData(key: 'theme', value: value1.toString()).then((value) {
                              AppCubit.get(context).changeTheme(value1.toString());
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Card(
              color: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.light,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
                    child: Text(getTranslated(context,'help')!,style: TextStyle(color: AppColors.blue,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  ListTile(
                    leading:const Icon(Icons.privacy_tip_outlined),
                    iconColor: AppColors.primaryColor2,
                    trailing: Icon(Icons.keyboard_arrow_right,color: AppColors.primaryColor2,),

                    title:  Text(
                      getTranslated(context, 'privacy')!,
                      style: TextStyle(fontSize: 18,color:AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyScreen(),));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Divider(color: AppCubit.get(context).themeValue=="2"? AppColors.black:AppColors.grey,thickness: 1,),
                  ),
                  ListTile(
                    leading:const Icon(Icons.help_outline),
                    iconColor: AppColors.primaryColor2,
                    trailing: Icon(Icons.keyboard_arrow_right,color: AppColors.primaryColor2,),

                    title:  Text(
                      getTranslated(context, 'faq')!,
                      style: TextStyle(fontSize: 18,color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FAQScreen(),));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Divider(color: AppCubit.get(context).themeValue=="2"? AppColors.black:AppColors.grey,thickness: 1,),
                  ),
                  ListTile(
                    leading:const Icon(Icons.info_outline),
                    iconColor: AppColors.primaryColor2,
                    trailing: Icon(Icons.keyboard_arrow_right,color: AppColors.primaryColor2,),

                    title:  Text(
                      getTranslated(context, 'about')!,
                      style: TextStyle(fontSize: 18,color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen(),));
                    },
                  ),
                ],
              ),
            ),

            Card(
              color: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.light,
              child: ListTile(
                leading:const Icon(Icons.share_outlined),
                iconColor: AppColors.primaryColor2,
                trailing: Icon(Icons.keyboard_arrow_right,color: AppColors.primaryColor2,),

                title:  Text(
                  getTranslated(context, 'share')!,
                  style: TextStyle(fontSize: 18,color: AppCubit.get(context).themeValue=="2"? AppColors.white70:AppColors.black),
                ),
                onTap: () {
                  Share.share("https://www.google.com", subject: 'SDTS Security');
                },
              ),
            ),

            Card(
              color: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor3:AppColors.light,
              child: ListTile(
                hoverColor: Colors.red,
                leading: Icon(Icons.logout ,color: AppColors.primaryColor2,),
                trailing: Icon(Icons.keyboard_arrow_right,color: AppColors.primaryColor2,),
                title:Text(getTranslated(context,'sign_out')!,
                  style: TextStyle(fontSize: 18,color: AppColors.red,),
                ),
                onTap: (){
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: AppColors.primaryColor1,
                      title:  Text(getTranslated(context,'sign_out')!,style: TextStyle(color: AppColors.primaryColor2)),
                      content: Text(getTranslated(context,'try_sign_out')!,style: TextStyle(color: AppColors.white70)),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context,'Cancel'),
                          child:  Text(getTranslated(context,'cancel')!,),
                        ),
                        TextButton(
                          onPressed: () {
                            Shared.setData(key: 'isLogin', value: false).then((value) {
                              Shared.removeData(key: 'uId',).then((value) {
                                UID='';
                                AppCubit.get(context).signOut();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false,
                                );
                              });
                            });
                          },
                          child: Text(getTranslated(context,'ok')!,style: TextStyle(color: AppColors.red)),
                        ),
                      ],
                    ),
                  );
                },
              ),

            ),

          ],
        ),
        ),
      ),
    );
  }
}


void _changeLanguage(Language lang ,context) async
{
  Locale _temp = await setLocale(lang.languageCode);
  MyApp.setLocale( context, _temp);
}