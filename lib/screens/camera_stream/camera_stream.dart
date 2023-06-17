

import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class CameraStreamScreen extends StatelessWidget {
  final String url;
  const CameraStreamScreen({ required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              child: Mjpeg(
                width: double.infinity,
                error: (context, error, stack) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(error.toString(), style: TextStyle(color: Colors.red,fontSize: 20)),
                  );
                },
                loading: (context){
                  return Center(child: CircularProgressIndicator());
                },
                isLive: true,
                stream: url,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Row(
                children: [
                  Icon(
                    Icons.online_prediction,
                    color: Colors.red,
                  ),
                  SizedBox(width: 4,),
                  Text('Live',style: TextStyle(color: Colors.amber, fontSize: 20),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

