import 'package:flutter/material.dart';

class PhotoList extends StatelessWidget {
  final List photos;
  PhotoList({this.photos});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (BuildContext context, int index) {
        //return Text('looool');
        return Center(
          child: Container(
            padding: EdgeInsets.all(10),
            height: 200,
            width: 200,
            child: Image.network(photos[index].url),
            ),
        );
      },
    );
  }
}