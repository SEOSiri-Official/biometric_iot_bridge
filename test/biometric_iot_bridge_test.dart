import 'package:flutter_test/flutter_test.dart';
import 'package:biometric_iot_bridge/biometric_iot_bridge.dart';

void main() {
  test('verify token generation', () {
    final bridge = BiometricIotBridge();

    final token = bridge.generateSecureToken(
      'test_secret',
      subject: 'test',
    );

    expect(token.contains('.'), true);
  });
}
