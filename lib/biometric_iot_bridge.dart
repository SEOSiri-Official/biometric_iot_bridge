import 'dart:convert';
import 'package:local_auth/local_auth.dart';
import 'package:crypto/crypto.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

/// Main API for biometric IoT bridge
class BiometricIotBridge {

  /// ✅ Constructor MUST appear before methods (lint rule)
  BiometricIotBridge({
    this.broker = 'test.mosquitto.org',
    this.clientId = 'biometric_bridge_client',
    this.port = 1883,
  });
  final LocalAuthentication _auth = LocalAuthentication();

  /// MQTT configuration (simple & explicit)
  final String broker;
  final String clientId;
  final int port;

  /// Verify device biometrics (local_auth 3.x SAFE)
  Future<bool> verifyBiometrics() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final supported = await _auth.isDeviceSupported();

      if (!canCheck || !supported) {
        return false;
      }

      return await _auth.authenticate(
        localizedReason: 'Authenticate to continue',
      );
    } catch (_) {
      return false;
    }
  }

  /// Generate secure token
  String generateSecureToken(String secret, {String subject = ''}) {
    final bytes = utf8.encode('$secret:$subject');
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Send remote signal via MQTT
  Future<void> sendRemoteSignal(String topic, String token) async {
    final client = MqttServerClient(broker, clientId);

    client.port = port;
    client.logging(on: false);
    client.keepAlivePeriod = 20;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    client.connectionMessage = connMessage;

    try {
      await client.connect();

      if (client.connectionStatus?.state !=
          MqttConnectionState.connected) {
        client.disconnect();
        return;
      }

      final builder = MqttClientPayloadBuilder();
      builder.addString(jsonEncode({
        'token': token,
        'timestamp': DateTime.now().toIso8601String(),
      }));

      client.publishMessage(
        topic,
        MqttQos.atLeastOnce,
        builder.payload!,
      );

      client.disconnect();
    } catch (_) {
      client.disconnect();
    }
  }
}
