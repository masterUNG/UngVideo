import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ung_video/screens/my_service.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String emailString, passwordString;

  // Method

  Widget emailText() {
    return TextFormField(
      onSaved: (String value) {
        emailString = value;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email :',
        helperText: 'Type Your Email',
      ),
    );
  }

  Widget passwordText() {
    return TextFormField(
      onSaved: (String value) {
        passwordString = value;
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password :',
        helperText: 'More 6 Charactor',
      ),
    );
  }

  Widget showText() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.white),
          color: Color.fromARGB(70, 255, 255, 255),
        ),
        padding: EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width * 0.7,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              emailText(),
              passwordText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showWallpaper() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'images/wallpaper.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget backButton() {
    return Container(
      padding: EdgeInsets.only(top: 38.0, left: 12.0),
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(
          Icons.navigate_before,
          color: Colors.white,
          size: 36.0,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> checkAuthen() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      myAlert(title, message);
    });
  }

  Widget okButton() {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  void myAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[okButton()],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wallpaper.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            backButton(),
            showText(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.navigate_next,
          color: Colors.grey,
          size: 36.0,
        ),
        onPressed: () {
          formKey.currentState.save();
          print('email = $emailString, pasword = $passwordString');
          checkAuthen();
        },
      ),
    );
  }
}
