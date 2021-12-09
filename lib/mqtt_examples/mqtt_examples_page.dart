import 'package:flutter/material.dart';
import 'package:flutter_article_examples/mqtt_examples/mqtt_manager.dart';

class MqttExamplesPage extends StatefulWidget {
  const MqttExamplesPage({Key? key}) : super(key: key);

  @override
  _MqttExamplesPageState createState() => _MqttExamplesPageState();
}

class _MqttExamplesPageState extends State<MqttExamplesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              MqttManager.getInstance().connect();
            },
            child: Text("开始链接"),
          ),
          TextButton(
            onPressed: () {
              MqttManager.getInstance().closeConnect();
            },
            child: Text("结束链接"),
          ),
          TextButton(
            onPressed: () {
              MqttManager.getInstance().pubMessage("Hello world");
            },
            child: Text("发送消息"),
          )
        ],
      ),
    );
  }
}
