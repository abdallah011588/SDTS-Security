
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


String UID='';
int marker=0;

class AppColors{
 static final Color primaryColor1=HexColor('1B1E2C');
 static final Color primaryColor2=HexColor('EAB401');
 static final Color primaryColor3= HexColor('323640');
 static final Color light= HexColor('F1F2F6');
 static final Color white= Colors.white;
 static final Color white70= Colors.white70;
 static final Color white60= Colors.white60;
 static final Color grey=Colors.grey;
 static final Color black=Colors.black;
 static final Color black54=Colors.black54;
 static final Color red=Colors.red;
 static final Color blue=Colors.blue;
 static final Color green=Colors.green;
}

InputBorder inputBorder =OutlineInputBorder(
 borderRadius: BorderRadius.circular(25.0),
 borderSide:  BorderSide(
  color: AppColors.primaryColor2,
  width: 1.0,
 ),
);

ThemeData lightTheme=ThemeData(
 fontFamily: "Cairo",
 backgroundColor: Colors.white,
 dividerColor: Colors.transparent,
 primarySwatch: Colors.blue,
);

ThemeData darkTheme=ThemeData(
 fontFamily: "Cairo",
 dividerColor: Colors.transparent,
 primarySwatch: Colors.blue,
);


