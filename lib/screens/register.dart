import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ung_video/screens/my_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  Color textColor = Colors.blueGrey.shade700;
  final formKey = GlobalKey<FormState>();
  String name, email, password;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Method
  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        print('Register Clicked');

        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('name = $name, email = $email, pass = $password');
          registerThread();
        }
      },
    );
  }

  Future<void> registerThread() async {
    
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((response) {
          print('Welcome To Firebase');
          setupDisplayName();
        })
        .catchError((response) {
          print('response = ${response.toString()}');
        });
  }

  Future<void> setupDisplayName()async{

    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    firebaseUser.updateProfile(userUpdateInfo);

    // Create Thread Without Arrow Back
    MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => MyService());
    Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);


  }

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
        icon: Icon(
          Icons.face,
          size: 36.0,
          color: Colors.purple,
        ),
        labelText: 'Display Name:',
        labelStyle: TextStyle(color: Colors.purple),
        helperText: 'Type Name in English',
        helperStyle: TextStyle(color: Colors.purple),
        hintText: 'FirstName SecondName',
      ),
      validator: (String value) {
        value = value.trim();
        if (value.isEmpty) {
          return 'Please Fill Name in Blank';
        }
      },
      onSaved: (String value) {
        name = value;
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        icon: Icon(
          Icons.email,
          size: 36.0,
          color: Colors.green,
        ),
        labelText: 'Email:',
        labelStyle: TextStyle(color: Colors.green),
        helperText: 'Type Email Format',
        helperStyle: TextStyle(color: Colors.green),
        hintText: 'you@abc.com',
      ),
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please Type Email Format';
        }
      },
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
        icon: Icon(
          Icons.lock,
          size: 36.0,
          color: Colors.yellow,
        ),
        labelText: 'Password:',
        labelStyle: TextStyle(color: Colors.yellow),
        helperText: 'Type Your Password',
        helperStyle: TextStyle(color: Colors.yellow),
        hintText: 'More 6 Charactor',
      ),
      validator: (String value) {
        if (value.length < 6) {
          return 'Please Type Pass More 6 Charactor';
        }
      },
      onSaved: (String value) {
        password = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[registerButton()],
        backgroundColor: textColor,
        title: Text('Register'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [Colors.white, Colors.blueGrey],
                radius: 1.7,
                center: Alignment.topCenter),
          ),
          child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
              children: <Widget>[
                nameText(),
                emailText(),
                passwordText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
