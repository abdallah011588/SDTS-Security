
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/home_layout/home_layout_screen.dart';
import 'package:graduation_project/screens/onboarding/onboarding_screen.dart';
import 'package:graduation_project/shared/shared_pref.dart';
// import 'package:hexcolor/hexcolor.dart';/

import '../login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {

  // late bool isLogin;
  // late bool onBoarding;
  // late bool isDark;
  //
  //  splashScreen({
  //    required this.isLogin ,
  //    required this.onBoarding,
  //    required this.isDark,
  //  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isLogin= Shared.getBool(key: 'isLogin') ==null ? false :Shared.getBool(key: 'isLogin');
  bool onBoarding= Shared.getBool(key: 'onBoarding') ==null ? false :Shared.getBool(key: 'onBoarding');
  Timer? timer;
  void goTo()
  {
     timer= Timer( const Duration(seconds: 3), (){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => onBoarding? isLogin? const HomeLayoutScreen():const LoginScreen(): const OnBoardingScreen(),
        ),
       (route) => false
      );
     });
  }

  @override
  void initState() {
    goTo();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.light,
      appBar: AppBar(
        backgroundColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.light,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppCubit.get(context).themeValue=="2"? AppColors.primaryColor1:AppColors.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 100),
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/sdts.png"),
              const SizedBox(height: 10,),
              SpinKitSpinningLines(
                color:AppColors.primaryColor2,
              duration: const Duration(milliseconds: 1700),
              size: 50,
             ),
            ],
          ),
        ),
      ),
    );
  }

}

//59:2C:8F:B4:8E:97:60:56:07:EB:64:3F:0C:3D:14:82:6B:CF:27:14

/*


 Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TweenAnimationBuilder(
                  duration: Duration(seconds: 3),
                  curve: Curves.easeInToLinear,
                  tween: Tween<double>(begin: 25,end: 40),
                  builder: (context,double value,child)
                  {
                    return Text(
                      'KIN SECURITY',
                      style: TextStyle(
                        color:AppColors.primaryColor2,
                        fontSize: value,
                        fontFamily:  "Orbitron",

                      ),
                    );
                  },
                 // child: FlutterLogo(size: 200,)
              ),
            ),
            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SpinKitSpinningLines(
                color:AppColors.primaryColor2,
                duration: Duration(milliseconds: 1700),
                size: 80,
              ),
            ),
          ],
        ),

 */