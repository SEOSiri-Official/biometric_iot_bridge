import 'package:flutter/material.dart';
import 'package:biometric_iot_bridge/biometric_iot_bridge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometric IoT Bridge Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const BiometricDemo(),
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
  bool _isLoading = false;

  Future<void> _authenticate() async {
    setState(() {
      _status = 'Authenticating...';
      _isLoading = true;
    });

    try {
      final authenticated = await _bridge.verifyBiometrics();

      if (authenticated) {
        final token = _bridge.generateSecureToken(
          'my_secret_key',
          subject: 'iot/unlock',
        );

        await _bridge.sendRemoteSignal('iot/unlock', token);

        setState(() {
          _status = '✅ Authenticated and signal sent!';
          _isLoading = false;
        });
      } else {
        setState(() {
          _status = '❌ Authentication failed';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _status = '❌ Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSuccess = _status.contains('✅');
    final isError = _status.contains('❌');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric IoT Bridge'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isLoading
                    ? Icons.fingerprint
                    : isSuccess
                        ? Icons.check_circle
                        : Icons.lock,
                size: 80,
                color: isSuccess
                    ? Colors.green
                    : isError
                        ? Colors.red
                        : Colors.blue,
              ),
              const SizedBox(height: 32),
              Text(
                _status,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _authenticate,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.fingerprint),
                label: const Text('Unlock IoT Device'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
