
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/constants/app_constants.dart';
import 'package:graduation_project/shared/shared_pref.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login_screen/login_screen.dart';

class BoardingModel {

  final String image, title, body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var pageViewController = PageController();
  bool isLast = false;
  void submit() {

    Shared.setData(key: 'onBoarding', value: true).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          (route) => false,
        );
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {

    List<BoardingModel> boarding = [
      BoardingModel(
        image: 'assets/images/img1.jpg',
        title: 'Make it available',
        body:'Connect your devices using your phone',
      ),
      BoardingModel(
          image: 'assets/images/img2.jpg',
          title:  'Keep it secure',
          body:  'Camera stream from everywhere',
      ),
      BoardingModel(
          image: 'assets/images/img3.jpg',
          title: 'Make it Under Control',
          body: 'Manage your devices and buildings',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.primaryColor1,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:AppColors.primaryColor1,
          statusBarIconBrightness: Brightness.light,
        ),
        actions: [
          TextButton(
            onPressed: () {
             submit();
            },
            child: Text(
              'Skip',
              style: TextStyle(color: AppColors.primaryColor2,fontSize: 16),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => pageViewBuilder(boarding[index]),
                controller: pageViewController,
                physics:const BouncingScrollPhysics(),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: pageViewController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor:AppColors.primaryColor2,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 10,
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageViewController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                  backgroundColor: AppColors.primaryColor2,
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.primaryColor1,
    );
  }
}

Widget pageViewBuilder(BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
           image: AssetImage(model.image,),
            // fit: BoxFit.fill,
        ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          decoration: BoxDecoration(
              color:AppColors.primaryColor3,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20))
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              model.title,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,color: AppColors.primaryColor2,),
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model.body,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: AppColors.white70,),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
