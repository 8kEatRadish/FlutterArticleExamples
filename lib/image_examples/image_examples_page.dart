import 'package:flutter/material.dart';

class ImageExamplesPage extends StatefulWidget {
  const ImageExamplesPage({Key? key}) : super(key: key);

  @override
  _ImageExamplesPageState createState() => _ImageExamplesPageState();
}

class _ImageExamplesPageState extends State<ImageExamplesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(left: 9),
          decoration: BoxDecoration(
              image: DecorationImage(
            centerSlice: Rect.fromLTRB(4, 20, 70, 40),
            image: AssetImage(
              "assets/image_examples_bg.png",
            ),
          )),
          constraints: BoxConstraints(maxWidth: 257),
          padding: EdgeInsets.only(left: 12, right: 15, top: 12, bottom: 12),
          child: Text("这是"),
        ),
      ),
    );
  }
}
