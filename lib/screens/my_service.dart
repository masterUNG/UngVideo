import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ung_video/screens/home.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  Color textColor = Colors.blueGrey.shade800;
  String nameLogin = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<void> findDisplayName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      nameLogin = firebaseUser.displayName;
    });
  }

  Widget showLogin() {
    return Text(
      'Login by $nameLogin',
      style: TextStyle(
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget showAppName() {
    return Text(
      'Ung Video',
      style: TextStyle(
        fontSize: 18.0,
        color: textColor,
        fontFamily: 'BethEllen',
      ),
    );
  }

  Widget showLogo() {
    return Container(
      height: 60.0,
      child: Image.asset(
        'images/logo.png',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget myDrawerHead() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, Colors.yellowAccent.shade700],
          radius: 1.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          showLogo(),
          showAppName(),
          showLogin(),
        ],
      ),
    );
  }

  Widget signOutMenu() {
    return ListTile(
      leading: Icon(
        Icons.import_export,
        size: 36.0,
      ),
      title: Text('Sign Out'),onTap: (){
        signOutProcess();
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> signOutProcess()async{
    await firebaseAuth.signOut().then((response){
      MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget myDrawerMenu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          myDrawerHead(),
          signOutMenu(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body: Text('Body'),
      drawer: myDrawerMenu(),
    );
  }
}
