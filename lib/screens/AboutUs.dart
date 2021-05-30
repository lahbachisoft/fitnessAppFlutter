import 'package:flutter/material.dart';

class About extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {


    final Privacy = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Privacy Policy',
        style: TextStyle(fontSize: 28.0, color: Colors.grey),
      ),
    );

    final lorem1 = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'drakeApp built the Fettniss app as an Ad Supported app. This SERVICE is provided by drakeApp at no cost and is intended for use as is. This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service. If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Fettniss unless otherwise defined in this Privacy Policy.',style: TextStyle(fontSize: 15.0, color: Colors.black),

      ),
    );
    final Information  = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Information Collection and Use',
        style: TextStyle(fontSize: 28.0, color: Colors.grey),
      ),
    );

    final lorem2 = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
       'For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way. The app does use third party services that may collect information used to identify you. Link to privacy policy of third party service providers used by the app Google Play Services AdMob Facebook',style: TextStyle(fontSize: 15.0, color: Colors.black,),
      ),
    );
    final Changes  = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Changes to This Privacy Policy',
        style: TextStyle(fontSize: 28.0, color: Colors.grey),
      ),
    );

    final lorem3 = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
       'I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page. This policy is effective as of 2021-03-03' ,style: TextStyle(fontSize: 15.0, color: Colors.black),),
    );
    final Contact  = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Contact Us',
        style: TextStyle(fontSize: 28.0, color: Colors.grey),
      ),
    );

    final lorem4 = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
         'If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at hamzahabachi2001@gmail.com.' ,style: TextStyle(fontSize: 15.0, color: Colors.black),),
    );

    final body = SingleChildScrollView(
      child:Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      /*decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
         Color.fromRGBO(250, 249, 255,1),
          Color.fromRGBO(250, 249, 255,1),
        ]),
      ),*/
      child: Column(
        children: <Widget>[ Privacy, lorem1,Information,lorem2,Changes,lorem3,Contact,lorem4],
      ),
      ));

    return Scaffold(
      backgroundColor:  Color.fromRGBO(250, 249, 255,1),
      appBar: new AppBar(  backgroundColor:  Color.fromRGBO(250, 249, 255,1),
        bottomOpacity: 0.0,
        elevation: 0.0,leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ), ),
      bottomNavigationBar: Text(""),
      body: body,
    );
  }
}