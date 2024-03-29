import 'dart:convert';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

MqttServerClient? client;

MqttServerClient getMqtt() {
  if (client == null) {
    client = MqttServerClient('mqtt.itdevclub.com', 'chonlatee');
    client!.port = 18835;
    client!.autoReconnect = true;
    client!.keepAlivePeriod = 15;
    client!.onDisconnected = () {
      print('mqtt disconnected');
    };
    client!.onConnected = () async {
      client!.updates!.listen(onMqttMessage);
    };
    client!.connect('mqtt',
        'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6IiJ9.eyJzdWIiOiJtcXR0Iiwic3VicyI6WyIjIl0sInB1YmwiOlsiIyJdLCJpYXQiOjE3MTE2ODY1NjEsImV4cCI6MjAyNzI2MjU2MX0.rvnAprlM3kNZqDUKxRe7DCRKcUJKN9fAAwtaQrUJqFhiw78YBFppJXdjQdqD12Mi4SkUjnKVKvgLvLfsrmiLCQ');
  }
  return client!;
}

onMqttMessage(List<MqttReceivedMessage<MqttMessage?>>? c) async {
  if (c == null) {
    return;
  }
  for (int i = 0; i < c.length; i++) {
    String topic = c[i].topic;
    print('mqtt GOT $topic');
    final MqttPublishMessage message = c[i].payload as MqttPublishMessage;
    final str =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);
    final json = jsonDecode(str);
    print('mqtt JSON $json');
  }
}
