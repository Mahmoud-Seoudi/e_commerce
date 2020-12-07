import 'package:flutter/material.dart';

class CustomeIcon extends StatelessWidget {
  // final String icon;
  // final IconData icon;

  CustomeIcon({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      ////   عن طريقه اقدر اعمله للـ container
      padding: const EdgeInsets.all(45.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(
                'assets/icons/buy.png',
              ),
            ),
            Positioned(
              bottom: 0,
              child: Text(
                'Buy It',
                style: TextStyle(
                  // color: Colors.white,
                  fontFamily: 'Pacifico',
                  fontSize: 25.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
