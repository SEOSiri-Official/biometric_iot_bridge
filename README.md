<<<<<<< HEAD
[![pub package](https://img.shields.io/pub/v/biometric_iot_bridge.svg)](https://pub.dev/packages/biometric_iot_bridge)
[![likes](https://img.shields.io/pub/likes/biometric_iot_bridge)](https://pub.dev/packages/biometric_iot_bridge)
[![popularity](https://img.shields.io/pub/popularity/biometric_iot_bridge)](https://pub.dev/packages/biometric_iot_bridge)
[![license](https://img.shields.io/github/license/SEOSiri-Official/biometric_iot_bridge)](LICENSE)

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
=======
<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
>>>>>>> d13d6b8 (Initial commit - biometric_iot_bridge package)
