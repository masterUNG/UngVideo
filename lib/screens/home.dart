import 'package:flutter/material.dart';
import 'package:ung_video/screens/register.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit
  double mySizeLogo = 150.0;
  Color myColor = Color.fromARGB(0xFF, 0x00, 0x3c, 0x8f);

  // Method

  Widget showLogo() {
    return Container(
      width: mySizeLogo,
      height: mySizeLogo,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Ung Video',
      style: TextStyle(
        fontSize: 30.0,
        color: myColor,
        fontWeight: FontWeight.bold,
        fontFamily: 'BethEllen',
      ),
    );
  }

  Widget showButton() {
    return Container(
      width: 250,
      child: Row(
        children: <Widget>[
          signInButton(),
          mySizeBox(),
          signUpButton(),
        ],
      ),
    );
  }

  Widget signInButton() {
    return Expanded(
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: myColor,
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget signUpButton() {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: myColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(color: myColor),
        ),
        onPressed: () {
          print('You Click SignUp');

          // Create Route With Arrow Back
          MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => Register());
          Navigator.of(context).push(materialPageRoute);


        },
      ),
    );
  }

  Widget mySizeBox() {
    return SizedBox(
      width: 8.0,
      height: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.white, Colors.grey.shade600],
              radius: 1.0,
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showLogo(),
              showAppName(),
              mySizeBox(),
              showButton(),
            ],
          ),
        ),
      ),
    );
  }
}
