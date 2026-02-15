import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:crypto/crypto.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class BiometricIotBridge {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> verifyBiometrics() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Scan to unlock remote IoT device',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } catch (e) {
      debugPrint('Biometric error: $e');
      return false;
    }
  }

  String generateSecureToken(
    String secretKey, {
    required String subject,
  }) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final payload = '$subject:$timestamp';

    final digest = Hmac(sha256, utf8.encode(secretKey))
        .convert(utf8.encode(payload));

    debugPrint('Secure token generated');

    return '${digest.toString()}.$timestamp';
  }

  Future<void> sendRemoteSignal(String topic, String token) async {
    final client = MqttServerClient('broker.emqx.io', 'flutter_client_bio');

    try {
      client.port = 1883;
      client.keepAlivePeriod = 20;
      client.logging(on: false);
      client.setProtocolV311();

      final status = await client.connect();

      if (status?.state != MqttConnectionState.connected) {
        client.disconnect();
        throw Exception('MQTT connection failed');
      }

      final builder = MqttClientPayloadBuilder();
      builder.addString(token);

      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);

      debugPrint('✅ Signal sent for: $topic');

      client.disconnect();
    } catch (e) {
      debugPrint('❌ Connection failed: $e');
    }
  }
}
