import 'dart:convert';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

/// FileName mqtt_manager.dart
///
/// @Author 8kEatRadish
/// @Date 2021/12/9 11:03 上午
///
/// @Description TODO
class MqttManager {
  static final MqttManager _instance = MqttManager._();

  MqttManager._();

  static MqttManager getInstance() => _instance;

  void connect() async {
    await _connect();
  }

  MqttServerClient? _client;

  Future<MqttServerClient?> _connect() async {
    _client =
        MqttServerClient.withPort('broker.emqx.io', 'flutter_client${DateTime.now().millisecondsSinceEpoch}', 1883);
    _client?.logging(on: true);
    _client?.onConnected = onConnected;
    _client?.onDisconnected = onDisconnected;
    _client?.onUnsubscribed = onUnsubscribed;
    _client?.onSubscribed = onSubscribed;
    _client?.keepAlivePeriod = 60;
    _client?.onSubscribeFail = onSubscribeFail;
    _client?.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .authenticateAs('username', 'password')
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    _client?.connectionMessage = connMessage;
    try {
      await _client?.connect();
    } catch (e) {
      print('Exception: $e');
      _client?.disconnect();
    }

    _client?.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      // final payload =
      //     MqttPublishPayload.bytesToStringAsString(message.payload.message);

      Utf8Decoder utf8decoder = new Utf8Decoder();
      String payload = utf8decoder.convert(message.payload.message);

      print('Received message:$payload from topic: ${c[0].topic}>');
    });

    return _client;
  }

  void pubMessage(String message){
    const pubTopic = 'topic/test';
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client?.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);
  }

  // 关闭链接
  void closeConnect(){
    _client?.disconnect();
  }

  // 连接成功
  void onConnected() {
    print('Connected');
    try{
      _client?.subscribe("topic/test", MqttQos.atLeastOnce);
    }catch(e){
      print(e.toString());
    }

  }

  // 连接断开
  void onDisconnected() {
    print('Disconnected');
  }

  // 订阅主题成功
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  // 订阅主题失败
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  // 成功取消订阅
  void onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
  }

  // 收到 PING 响应
  void pong() {
    print('Ping response client callback invoked');
  }
}
