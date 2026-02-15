import 'package:flutter/material.dart';
import 'package:biometric_iot_bridge/biometric_iot_bridge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BiometricDemo(),
    );
  }
}

class BiometricDemo extends StatefulWidget {
  const BiometricDemo({super.key});

  @override
  State<BiometricDemo> createState() => _BiometricDemoState();
}

class _BiometricDemoState extends State<BiometricDemo> {
  final BiometricIotBridge _bridge = BiometricIotBridge();

  String _status = 'Ready to authenticate';

  Future<void> _authenticate() async {
    setState(() {
      _status = 'Authenticating...';
    });

    final authenticated = await _bridge.verifyBiometrics();

    if (authenticated) {
      final token = _bridge.generateSecureToken(
        'my_secret_key',
        subject: 'iot/unlock',
      );

      await _bridge.sendRemoteSignal('iot/unlock', token);

      setState(() {
        _status = '✅ Authenticated and signal sent!';
      });
    } else {
      setState(() {
        _status = '❌ Authentication failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biometric IoT Bridge')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _authenticate,
              child: const Text('Unlock IoT Device'),
            ),
          ],
        ),
      ),
    );
  }
}
