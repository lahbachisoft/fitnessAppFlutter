import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness_app/screens/UnityAdsManager.dart';
import 'package:fitness_app/screens/exercise.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ExerciseScreen extends StatefulWidget {
  final Exercises exercises;
  final int seconds;
  ExerciseScreen({this.exercises, this.seconds});
  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  bool isCompleted = false;
  int _elapsedseconds = 0;
  Timer timer;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  static String Rewardedad;
  final UnityAD = FirebaseDatabase.instance.reference().child("unityAd");

  @override
  void initState() {

      Timer.periodic(
        Duration(seconds: 1),
            (t) {
          if (t.tick == widget.seconds) {
            t.cancel();
            Navigator.of(context).pop();
            setState(() {
              isCompleted = true;
            });
            playAudio();
          }
          try {
            setState(
                  () {
                _elapsedseconds = t.tick;
              },
            );
          } catch(e) {
            print("Error!");
          }
         
        },
      );

    super.initState();

      UnityAD.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        var Id = [];
        values.forEach((key,values) {
          Id.add(values);
        });
        print("items 0: "+Id[0]);
        print("items 1: "+Id[1]);
        print("items 2: "+Id[2]);
        print("items 2: "+Id[3].toString());

        UnityAdsManager.init(Id[3].toString());
        Rewardedad=Id[1];
        print("hyUnityAD");
      });

  }

  void playAudio() {
    audioCache.play("cheering.wav");
  }

  void dispose() {
    try {
      if (this.mounted) { // check whether the state object is in tree
        setState(() {
          timer.cancel();

        });
      }
    } catch(e) {
      print("Error!");
    }
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
      /*  leading:IconButton(
          icon: Icon(Icons.close,color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
            print("hy2");
          },
        ),*/
        //     Color.fromRGBO(255, 246 ,255, 1),
        leading:IconButton(
        icon: Icon(Icons.close,color: Colors.white,),

    onPressed: () {
      UnityAdsManager.loadRewardedVideoAd(Rewardedad);
    Navigator.of(context).pop();
    print("hy2");
    },),
        backgroundColor: Color.fromRGBO(232 ,187,83,1),
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Center(child: Text("",style:  TextStyle(
            color:  Color.fromRGBO(127, 65 ,184 ,1),fontFamily: 'ComicSansMS3' ,fontSize: 20,fontWeight: FontWeight.bold))),
        //  Color.fromRGBO(252,164,247,1)
      ),
      body: Stack(
        children: <Widget>[
            Center(
          child:   FadeInImage(
              image: NetworkImage(widget.exercises.gif),
              //  image: NetworkImage("https://image.freepik.com/free-photo/young-fitness-woman-working-out-with-dumbbell-isolated-white-wall_231208-1721.jpg"),
              placeholder:
              AssetImage("assets/placeholder.jpg"),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.1,
              fit: BoxFit.none,
            ),
    ),
          isCompleted != true
              ? SafeArea(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: CircularCountDownTimer(
                      // Countdown duration in Seconds
                      duration: widget.seconds,

                      // Width of the Countdown Widget
                      width: MediaQuery.of(context).size.width / 6,

                      // Height of the Countdown Widget
                      height: MediaQuery.of(context).size.height / 6,

                      // Default Color for Countdown Timer
                      color: Color.fromRGBO(232 ,187,83,1),
                      // Filling Color for Countdown Timer
                      fillColor: Colors.white,
                      // Border Thickness of the Countdown Circle
                      strokeWidth: 5.0,

                      // Text Style for Countdown Text

                      textStyle: TextStyle(fontSize: 35,   color:Color.fromRGBO(232 ,187,83,1),fontFamily: 'DS-DIGI'),

                      // true for reverse countdown (max to 0), false for forward countdown (0 to max)
                      isReverse: false,

                      // Function which will execute when the Countdown Ends
                      onComplete: () {
                        // Here, do whatever you want
                        print('Countdown Ended');
                      },
                    )
                    /*  RichText(
                      text: TextSpan( /*defining default style is optional */
                        children: <TextSpan>[
                          TextSpan(
                              text:  '$_elapsedseconds', style: TextStyle(fontSize: 35,color:Color.fromRGBO(232 ,187,83,1),fontFamily: 'DS-DIGI')),
                          TextSpan(
                              text: ' /',
                              style: TextStyle(fontFamily: 'DS-DIGI',fontSize: 35,color:Colors.grey)),
                          TextSpan(
                              text: ' ${widget.seconds}',
                              style: TextStyle( fontSize: 28,fontFamily: 'DS-DIGI',color:Colors.black)),
                          TextSpan(
                              text: 's',
                              style: TextStyle(fontSize: 20,color:Color.fromRGBO(232 ,187,83,1))),

                        ],
                      ),
                    ),*/

                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
