import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ung_video/models/video_model.dart';
import 'package:ung_video/screens/video_player.dart';

class VideoListView extends StatefulWidget {
  @override
  _VideoListViewState createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {
  // Explicit
  Firestore firestore = Firestore.instance;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;
  List<VideoModel> videoModels = [];

  // Method
  @override
  void initState() {
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore() async {
    CollectionReference collectionReference = firestore.collection('Video');
    subscription =
        await collectionReference.snapshots().listen((dataSanapshot) {
      snapshots = dataSanapshot.documents;

      for (var snapshot in snapshots) {
        String nameString = snapshot.data['Name'];
        String detailString = snapshot.data['Detail'];
        String imageString = snapshot.data['PathImage'];
        String videoString = snapshot.data['PathVideo'];

        print('name = $nameString');

        VideoModel videoModel =
            VideoModel(nameString, detailString, imageString, videoString);

        setState(() {
          videoModels.add(videoModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.only(
        left: 8.0,
        top: 8.0,
        right: 8.0,
      ),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(
        videoModels[index].pathImage,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showText(int index) {
    return Column(
      children: <Widget>[
        showName(index),
        showDetia(index),
      ],
    );
  }

  Widget showName(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      alignment: Alignment.topRight,
      child: Text(
        videoModels[index].name,
        style: TextStyle(fontSize: 24.0, color: Colors.blue.shade700),
      ),
    );
  }

  Widget showDetia(int index) {
    String detailShort = videoModels[index].detail;
    if (detailShort.length > 50) {
      detailShort = detailShort.substring(0, 50);
      detailShort = '$detailShort ...';
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Text(detailShort),
    );
  }

  Widget showVideoListView() {
    return ListView.builder(
      itemCount: videoModels.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Row(
            children: <Widget>[
              showImage(index),
              showText(index),
            ],
          ),
          onTap: () {
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
                builder: (BuildContext context) => VideoPlayer(
                      videoModel: videoModels[index],
                    ));
                    Navigator.of(context).push(materialPageRoute);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return showVideoListView();
  }
}
