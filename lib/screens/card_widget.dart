import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String cardImg;
  const CardWidget({
    Key key,
    this.cardImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(25, 0, 0, 2),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        height: MediaQuery.of(context).size.width/4.2,
        width: MediaQuery.of(context).size.width/4.2,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              cardImg,
            ),
            fit: BoxFit.contain,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}