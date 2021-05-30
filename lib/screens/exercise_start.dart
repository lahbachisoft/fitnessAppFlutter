import 'package:firebase_database/firebase_database.dart';
import 'package:fitness_app/screens/UnityAdsManager.dart';
import 'package:fitness_app/screens/exercise.dart';
import 'package:fitness_app/screens/exercises_creen.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ExerciseStartScreen extends StatefulWidget {
  final Exercises exercises;
  ExerciseStartScreen({this.exercises});
  @override
  _ExerciseStartScreenState createState() => _ExerciseStartScreenState();
}

class _ExerciseStartScreenState extends State<ExerciseStartScreen> {
  int seconds = 10;

  static String Rewardedad;
  final UnityAD = FirebaseDatabase.instance.reference().child("unityAd");
  @override
  void initState() {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget.exercises.title,
              style:  TextStyle(
                  color: Colors.white,fontFamily: 'design.graffiti.comicsansms' ,fontSize: 17)
          ),
          backgroundColor: Color.fromRGBO(232 ,187,83,1),
          /*bottom: Icon(
            Icons.more_vert,
            color: Colors.black,
            size: 24,
          ),*/
          leading:IconButton(
            icon: Icon(Icons.close,color: Colors.white,),

            onPressed: () {
              UnityAdsManager.loadRewardedVideoAd(Rewardedad);
              Navigator.of(context).pop();
              print("hy2");
            },
          ),
         /* actions: <Widget>[

            IconButton(
              icon:  Icon(
                Icons.more_vert,
                color: Colors.black,
                size: 24,
              ),
              tooltip: 'Comment Icon',
              onPressed: () {},
            ),
          ],*/
        ),
        body: new Material(
        type: MaterialType.transparency,
        child: new Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Hero(
        tag: widget.exercises.id,
        child: Stack(
          children: <Widget>[
            Image(
              image: NetworkImage(widget.exercises.thumbnail),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                /*gradient: LinearGradient(
                  colors: [
                    Colors.black38,
                    Colors.black38,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),*/
              ),
            ),


            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Container(
                width: 120.0,
                height: 150.0,
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                      customColors:CustomSliderColors(
                          trackColor:Colors.white,
                        dotColor: Color.fromRGBO(232 ,187,83,1),
                        progressBarColor:Color.fromRGBO(232 ,187,83,1),
                          shadowColor:Color.fromRGBO(232 ,187,83,1),

                  ),
                    spinnerMode: false,
                    size:50,
                      animDurationMultiplier:3
                  ),


                  onChange: (double value) {
                    seconds = value.toInt();
                  },

                  initialValue: 20.0,
                  min: 10,
                  max: 60,
                  innerWidget: (v) {
                    return Container(
                      alignment: Alignment.center,
                      child:
                      RichText(
                        text: TextSpan( /*defining default style is optional */
                          children: <TextSpan>[
                            TextSpan(
                                text:  '${v.toInt()}', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 33,color:Color.fromRGBO(232 ,187,83,1),fontFamily: 'DS-DIGI')),
                            TextSpan(
                                text: ' s',
                                style: TextStyle(fontSize: 20,fontFamily: 'DS-DIGI')),

                          ],
                        ),
                      ),

                    );
                  },
                ),
              ),
            ),
       /*    IconButton(
              icon: Icon(Icons.close,color: Colors.white,),

              onPressed: () {
                Navigator.of(context).pop();
                print("hy2");
              },
            ),*/
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                  onPressed: () {
                    print(seconds);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseScreen(
                          exercises: widget.exercises,
                          seconds: seconds,

                        ),
                      ),
                    );
                  },
                  child:  Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                  color:  Color.fromRGBO(232 ,187,83,1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  splashColor: Colors.white),
            ),
          ],
        ),
      ),
        )));
  }
}
