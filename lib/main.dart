import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/localization/localization_methods.dart';
import 'package:graduation_project/localization/set_localization.dart';
import 'package:graduation_project/screens/home_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/home_layout/cubit/states.dart';
import 'package:graduation_project/screens/home_layout/home_layout_screen.dart';
import 'package:graduation_project/screens/splash_screen/splash_screen.dart';
import 'package:graduation_project/shared/remote/dio_tool.dart';
import 'package:graduation_project/shared/shared_pref.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constants/app_constants.dart';
//import 'package:intl/intl.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Fluttertoast.showToast(
    msg: 'onBackground => ${message.notification!.title}',
    backgroundColor: Colors.blue,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_LONG,
  );
}

 void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) {
    if(value)
    {
      Permission.notification.request();
    }
  });
  Shared.init();
  await Firebase.initializeApp();
  dioTool.init();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  var token = await messaging.getToken();
  Shared.setData(key: "FCMToken", value: token);
  String theme=Shared.getString(key: 'theme')==null? "2" : Shared.getString(key: 'theme')!;

  FirebaseMessaging.onMessage.listen((event) {
    Fluttertoast.showToast(
      msg:'${event.notification!.title.toString()} \n\n ${event.notification!.body.toString()}',
      backgroundColor: Colors.red,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
    );
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Fluttertoast.showToast(
      msg: event.notification!.body.toString(),
      backgroundColor: Colors.red,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,

    );
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // requestNotificationPermissions();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.landscapeRight,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp( MyApp(theme: theme,));
  });

}


class MyApp extends StatefulWidget {

  MyApp({ Key? key, required this.theme}) : super(key: key);
  late String theme;
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _local;
  void setLocale(Locale locale) {
    setState(() {
      _local = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _local = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    if (_local == null)
    {
      return Container(
        child:const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    else
    {
      return BlocProvider(
        create: (context) => AppCubit()..getUserData()..changeAppMode(fromShared: widget.theme),
        child: BlocConsumer<AppCubit,AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
               sendNotys(context);
              return  MaterialApp(
                title: 'Flutter Demo',
                theme: AppCubit.get(context).themeValue =="1"? lightTheme : darkTheme,
                home: SplashScreen(),
                debugShowCheckedModeBanner: false,

                locale: _local,
                supportedLocales: const [
                   Locale('en', 'US'),
                   Locale('ar', 'EG')
                ],

                localizationsDelegates: const [
                  SetLocalization.localizationsDelegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (deviceLocal, supportedLocales)
                {
                  for (var local in supportedLocales)
                  {
                    if (local.languageCode == deviceLocal!.languageCode &&
                        local.countryCode == deviceLocal.countryCode)
                    {
                      return deviceLocal;
                    }
                  }
                  return supportedLocales.first;
                },


              );
            }
        ),
      );
    }

  }
}



// token: cnQnHiFFTXqXt8TfUnfqqN:APA91bEUv26IfWamWhyxNJcD76w-Mbqbff_Odo2drtmMV2xDPyGe9Rq_5HwkTXFIOyR7waXtbu4umdcymkKNm6DEwSy5RkgPd2KZTB4cnpbAyJnyd8FB-cvcVPYaY-1Oq5VXKkZyRMls
// server key: AAAA1AzCXMk:APA91bFYkFmiuR1S9lD9ECvDypxQ4jxQ4u1L2gUDA270SG80--lSo3hbsQnTTI1PKhuvVk3OHK_XjNfE9FrwdrOSgEZqyktfrBG-7knkxMpwvaFxzhxBQlok4iD0A8v3ATFiwIjYP-xk

