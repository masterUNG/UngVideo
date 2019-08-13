import 'package:flutter/material.dart';

class Informarion extends StatefulWidget {
  @override
  _InformarionState createState() => _InformarionState();
}

class _InformarionState extends State<Informarion> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Information',
        style: TextStyle(fontSize: 30.0),
      ),
    );
  }
}
