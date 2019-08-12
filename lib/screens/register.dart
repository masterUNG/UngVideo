import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  Color textColor = Colors.blueGrey.shade700;

  // Method
  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {},
    );
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
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
        icon: Icon(
          Icons.lock,
          size: 36.0,
          color: Colors.orange,
        ),
        labelText: 'Password:',
        labelStyle: TextStyle(color: Colors.orange),
        helperText: 'Type Your Password',
        helperStyle: TextStyle(color: Colors.orange),
        hintText: 'More 6 Charactor',
      ),
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
              colors: [Colors.white, Colors.blueGrey],radius: 1.5,center: Alignment.topCenter
            ),
          ),
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
    );
  }
}