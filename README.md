# Biometric IoT Bridge

A Flutter package providing **biometric authentication**, **secure token generation**, and **MQTT-based IoT signaling**.

Designed for applications that require trusted user verification before sending commands to remote devices.

---

## ✨ Features

✔ Biometric authentication (fingerprint / face / device biometrics)  
✔ Secure HMAC-SHA256 token generation  
✔ MQTT message publishing for IoT devices  
✔ Minimal, lightweight API  
✔ Flutter-friendly & platform-aware  

---

## 🚀 Use Cases

- Smart locks / IoT access control  
- Device unlocking workflows  
- Secure remote commands  
- Trusted device signaling  
- Biometric-gated actions  

---

## 📦 Installation

Add dependency to `pubspec.yaml`:

```yaml
dependencies:
  biometric_iot_bridge: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## 🔐 Basic Example

```dart
final bridge = BiometricIotBridge();

final authenticated = await bridge.verifyBiometrics();

if (authenticated) {
  final token = bridge.generateSecureToken(
    'your_secret_key',
    subject: 'iot/unlock',
  );

  await bridge.sendRemoteSignal('iot/unlock', token);
}
```

---

## 🧩 API Overview

### Verify Biometrics

```dart
Future<bool> verifyBiometrics()
```

Triggers device biometric authentication.

---

### Generate Secure Token

```dart
String generateSecureToken(
  String secretKey, {
  required String subject,
})
```

Creates an HMAC-SHA256 token:

```
HMAC(subject:timestamp).timestamp
```

---

### Send Remote Signal (MQTT)

```dart
Future<void> sendRemoteSignal(
  String topic,
  String token,
)
```

Publishes the token to an MQTT broker.

Default broker:

```
broker.emqx.io
```

---

## ⚙️ Requirements

- Flutter SDK  
- Device biometric support  
- Internet access (for MQTT)  

---

## 🔒 Security Notes

- Tokens use HMAC-SHA256  
- Never expose secret keys  
- Always validate tokens server/device-side  
- Biometrics verify user presence, not identity  

---

## 📚 Intended Architecture

Typical flow:

```
User → Biometric Auth → Secure Token → MQTT → IoT Device
```

---

## 🛠 Maintained By

**SEOSiri**  
https://seosiri.com  

**Momenul Ahmad**  
https://www.seosiri.com/p/about.html

---

## 📄 License

MIT License
