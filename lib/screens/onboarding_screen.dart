import 'package:fitness_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  var pages = [
    PageViewModel(
      title: "",
      body:
          "Visible changes \n in 30 days",
      image: Container(margin: EdgeInsets.fromLTRB(0, 30, 0, 0),  child:Image.asset("assets/splash1.png", height:362.83,width: 296.9,fit: BoxFit.contain)),
      decoration: const PageDecoration(
        pageColor: Colors.white,
        bodyTextStyle: TextStyle(
            color: Color.fromRGBO(57,195, 201,1),
         fontSize: 30,
          fontFamily: "ComicSansMS3"
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,fontSize: 24.0,
        ),
      ),
    ),
    PageViewModel(
      title: "",
      body: "Forget about strict \n diet",
      image: Container(margin: EdgeInsets.fromLTRB(0, 30, 0, 0), child: Image.asset("assets/splash2.png", height:347.61,width: 346.82,)),
      decoration: const PageDecoration(
        pageColor: Colors.white,
        bodyTextStyle: TextStyle(
            color: Color.fromRGBO(57,195, 201,1),
            fontSize: 30,
            fontFamily: "ComicSansMS3"
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,fontSize: 24.0,
        ),
      ),
    ),
    PageViewModel(
      title: "",
      body:
      "Save money on gym \n membership",
      image: Container(margin: EdgeInsets.fromLTRB(0, 30, 0, 0),child: Image.asset("assets/splash3.png", height:338.18,width:360.59 ,)),
      decoration: const PageDecoration(
        pageColor: Colors.white,
        bodyTextStyle: TextStyle(
            color: Color.fromRGBO(57,195, 201,1),
            fontSize: 30,
            fontFamily: "ComicSansMS3"
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,fontSize: 24.0,
        ),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: pages,
        onDone: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(),),
          );
        },
        onSkip: () {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(),),
          );
        },
        showSkipButton: true,
      skip: const Icon(Icons.skip_next,color: Colors.white,size: 26),
      next: const Icon(Icons.navigate_next,color:  Colors.white, size: 28,),
       done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromRGBO(115,124, 164,1), fontFamily: "ComicSansMS3")),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Color.fromRGBO(115,124, 164,1),
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
