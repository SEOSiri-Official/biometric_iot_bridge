import 'package:local_auth/local_auth.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

/// Main API for biometric IoT bridge
class BiometricIotBridge {
  final LocalAuthentication _auth = LocalAuthentication();

  /// Verify device biometrics
  Future<bool> verifyBiometrics() async {
    return _auth.authenticate(
      localizedReason: 'Authenticate to continue',
      options: const AuthenticationOptions(biometricOnly: true),
    );
  }

  /// Generate secure token
  String generateSecureToken(String secret, {String subject = ''}) {
    final bytes = utf8.encode('$secret:$subject');
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Send remote signal (mock for now)
  Future<void> sendRemoteSignal(String topic, String token) async {
    // TODO: integrate mqtt_client
  }
}
