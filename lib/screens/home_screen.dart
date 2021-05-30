
import 'dart:async';
import 'dart:convert';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness_app/screens/AboutUs.dart';
import 'package:fitness_app/screens/MyFacebookAdsManager.dart';
import 'package:fitness_app/screens/UnityAdsManager.dart';
import 'package:fitness_app/screens/card_widget.dart';
import 'package:fitness_app/screens/exercise.dart';
import 'package:fitness_app/screens/exercise_start.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;


  final Admob = FirebaseDatabase.instance.reference().child("Ads");
  final Fan = FirebaseDatabase.instance.reference().child("FANAds");
  final UnityAD = FirebaseDatabase.instance.reference().child("unityAd");
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo();
  static String Nativeadid;
  static String Bannera;
  static String Interstitialad;
  static String Rewardedad;
  BannerAd createBannerAdd(id) {
    return BannerAd(
        targetingInfo: targetingInfo,
        adUnitId: id,
        size: AdSize.smartBanner,
        listener: (MobileAdEvent event) {
          print('Bnner Event: $event');
        });
  }
  InterstitialAd createInterstitialAd(id) {
    return InterstitialAd(
        targetingInfo: targetingInfo,
        adUnitId:id,
    listener: (MobileAdEvent event) {
      if (event == MobileAdEvent.failedToLoad) {
        _interstitialAd..load();
      } else if (event == MobileAdEvent.closed) {
        _interstitialAd = createInterstitialAd(id)..load();
      }
      print(event);
    });
  }



  final String apiURl = "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";
  Exercise exercise;
  bool _loading = true;
  static List<String> cardList = [
    "assets/cafe.png",
    "assets/watherpro.png",
    "assets/music.png",
    "assets/lhbl.png",
    "assets/lgat.png",
    "assets/pikala.png",
    "assets/alterat.png",
    "assets/crono1.png",
    "assets/mizan1.png",
    "assets/planing1.png",

  //  "assets/cafeicons.png",
  //  "assets/wather1.png",

   // "assets/wzn.png",
  ];
  @override
  void initState() {
    super.initState();

    Admob.child("admobAppId").once().then((DataSnapshot snapshot) {
        FirebaseAdMob.instance.initialize(appId:snapshot.value);
        print("admobAppId:"+snapshot.value);
   });
      Admob.child("Banner").once().then((DataSnapshot snapshot) {
        print("Banner:"+snapshot.value);
        _bannerAd = createBannerAdd(snapshot.value)..load();
        print("Banner:"+snapshot.value);
      });

      Admob.child("Interstitialid").once().then((DataSnapshot snapshot) {
       print("Interstitialid:"+snapshot.value);
       _interstitialAd = createInterstitialAd(snapshot.value)..load();
      });

     Fan.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        List<String> Id = [];
        values.forEach((key,values) {
        print("this: "+values);
        Id.add(values);
        });
        print("items 0: "+Id[0]);
        print("items 1: "+Id[1]);
        print("items 2: "+Id[2]);
        print("items 3: "+Id[3]);
        print("items 4: "+Id[4]);
        Nativeadid=Id[2];
      MyFacebookAdsManager.init(Id[1],Id[4],Id[0]);

    print("hyMyFacebookAdsManager");
   });
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
      Bannera=Id[0];
      Interstitialad=Id[2];
      Rewardedad=Id[1];
      print("hyUnityAD");
    });
    getExercises();
  }
  @override
  void dispose()
  {
    try {
      _interstitialAd?.dispose();
      _bannerAd?.dispose();

      print("hydispose");
  } catch (ex) {}
    super.dispose();
  }

  void getExercises() async {
    var response = await http.get(apiURl);
    var body = response.body;
    var decodejson = jsonDecode(body);
    exercise = Exercise.fromJson(decodejson);
    setState(() {_loading = false;});
  }



    @override
  Widget build(BuildContext context) {
   Timer(Duration(seconds: 10), () {_bannerAd?.show();});
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:  Color.fromRGBO(250, 249, 255,1),
      appBar: AppBar(

          actions: <Widget>[
            IconButton(
              icon:  Icon(
                Icons.more_vert,
                color: Colors.black,
                size: 24,
              ),
              tooltip: 'Comment Icon',

              onPressed: () async {
               _interstitialAd?.show();
                /*UnityAds.showVideoAd(
                  placementId: "rewardedVideo",
                  listener: (state, args) =>
                      print('Interstitial Video Listener: $state => $args'),
                );*/
               // UnityAdsManager.loadRewardedVideoAd(Rewardedad);
             //   UnityAdsManager.loadInterstitialAd(Interstitialad);
                print(Bannera);
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => About()));

              //MyFacebookAdsManager.showInterstitialAd();
              //  MyFacebookAdsManager.showRewardedAd();
              },
            ),
          ],
        //     Color.fromRGBO(255, 246 ,255, 1),
        backgroundColor:  Color.fromRGBO(250, 249, 255,1),
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Center(child: Text("      Home",style:TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontFamily:  "MontserratExtraBold"
        ),)),

        //  Color.fromRGBO(252,164,247,1)
      ),
      // bottomNavigationBar: MyFacebookAdsManager.fbBannerAd(),
       bottomNavigationBar: UnityAdsManager.nativeAd(Bannera),
      body:  Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(35,15,0,24),
              child:  Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                      fontFamily:  "MontserratExtraBold"
                  ),
                )),
              ],
            ),
    Center(
      child:  GestureDetector(
          onTap: () {
            print("Click event on Container");
            UnityAdsManager.loadInterstitialAd(Interstitialad);
          },
     child: Container(

        height: MediaQuery.of(context).size.width/4.2,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: false,
          itemCount: 10,
          itemBuilder: (context, index) {
            return CardWidget(
              cardImg: cardList[index],
            );
          },
        ),
      ),
        ),
    ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                 child:
                  Padding(
                      padding: const EdgeInsets.fromLTRB(35,30,0,24),
                      child:  Text(
                        'Popular',
                        style: TextStyle(

                            fontSize: 24,
                            color: Colors.black,
                            fontFamily:  "MontserratExtraBold"
                        ),
                      )),
                ),
         /*       Row(
                  children: [
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5 / 2),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5 / 2),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )*/
              ],
            ),

            exercise!= null
                ?

     Expanded(
              child:
             ListView(
              scrollDirection: Axis.horizontal,
              children: exercise.exercises.map((e) {
                // ignore: unrelated_type_equality_checks
                if (!(int.parse(e.id) % 5 == 0)) { // Display `AdmobBanner` every 5 'separators'.
print(int.parse(e.id));
                  return
                    InkWell(
                    onTap: () {
                      //UnityAdsManager.loadInterstitialAd(Rewardedad);
                      MyFacebookAdsManager.showInterstitialAd();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExerciseStartScreen(
                                exercises: e,
                              ),
                        ),
                      );
                    },

                    child: Hero(
                      tag: e.id,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.7,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 3,
                        margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: FadeInImage(
                                image: NetworkImage(e.thumbnail),
                                //  image: NetworkImage("https://image.freepik.com/free-photo/young-fitness-woman-working-out-with-dumbbell-isolated-white-wall_231208-1721.jpg"),
                                placeholder:
                                AssetImage("assets/placeholder.jpg"),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 2.4,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.7,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 2.4,
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
                            Container(

                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 2.4,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                margin:
                                EdgeInsets.only(
                                    left: 0.0, bottom: 20.0, top: 20),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[

                                    Text(
                                        e.title,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'design.graffiti.comicsansms',
                                            fontSize: 17)
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(4, (index) {
                                        return Icon(
                                          index < 3 ? Icons.star : Icons
                                              .star_half,
                                          color: Color.fromRGBO(
                                              232, 187, 83, 1),
                                          size: 10,
                                        );
                                      }),),
                                  ],)
                            ),
                            Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 2.4,
                              margin:
                              EdgeInsets.only(left: 11.0, bottom: .0, top: 0),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "30 days",
                                style: TextStyle( //color:Color.fromRGBO(71, 221, 228,1)color:Color.fromRGBO(11, 198, 200,1)
                                  color: Color.fromRGBO(247, 249, 253, 1),
                                  fontFamily: 'design.graffiti.comicsansms',
                                  fontSize: 15,),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(232, 187, 83, 1),
                                /*    border: Border.all(
                                    color: Colors.pink[800],// set border color
                                    ),  */ // set border width
                                borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        10.0)), // set rounded corner radius
                                // make rounded corner of border
                              ),

                              height: 25,
                              width: 70,
                              margin:
                              EdgeInsets.only(
                                  left: 8.0, bottom: 20.0, top: 7, right: 11),
                              // alignment: Alignment.topRight,
                              child: Text(
                                  "Beginner",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(247, 249, 253, 1),
                                    fontFamily: 'design.graffiti.comicsansms',
                                    fontSize: 15,)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return Container(

                  margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: MyFacebookAdsManager.nativeAd(MediaQuery
                      .of(context)
                      .size
                      .width / 1.7, MediaQuery
                      .of(context)
                      .size
                      .height / 2.4,Nativeadid),
                );


                }

              ).toList(),
            ),)
                : CircularProgressIndicator(),
    ]
      ),
    );
  }
}
