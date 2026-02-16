# biometric_iot_bridge

Flutter biometric authentication and secure MQTT IoT bridge. Verify users with platform biometrics, generate cryptographic tokens, and trigger trusted device actions with hardware-level security.

![Pub Version](https://img.shields.io/pub/v/biometric_iot_bridge)
![Flutter](https://img.shields.io/badge/platform-Flutter-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Security](https://img.shields.io/badge/focus-Security-critical)
![IoT](https://img.shields.io/badge/domain-IoT-orange)

---

## ✨ What is biometric_iot_bridge?

`biometric_iot_bridge` is a Flutter plugin that connects **device biometrics** with **secure token generation** and **IoT device signaling**.

It allows Flutter apps to securely:

• Verify users using fingerprint / face / device credentials  
• Generate cryptographically secure tokens  
• Send trusted commands to IoT devices via MQTT  

This package is designed for **security-sensitive**, **device-aware**, and **remote-control** workflows.

---

## 🚀 Core Capabilities

✅ Biometric authentication using native platform APIs  
✅ Secure token generation via cryptographic hashing  
✅ MQTT signaling for IoT / remote devices  
✅ Lightweight and Flutter-first API  
✅ No biometric data storage  

---

## 📦 Installation

Add the dependency:

```yaml
dependencies:
  biometric_iot_bridge: ^0.0.1
````

Fetch packages:

```bash
flutter pub get
```

---

## 🛠 Quick Start

### Import

```dart
import 'package:biometric_iot_bridge/biometric_iot_bridge.dart';
```

---

### Initialize Bridge

```dart
final bridge = BiometricIotBridge();
```

---

### Verify Biometrics

```dart
final authenticated = await bridge.verifyBiometrics();

if (!authenticated) {
  print("Authentication failed");
  return;
}
```

---

### Generate Secure Token

```dart
final token = bridge.generateSecureToken("my_secret_key");
```

---

### Send Signal to IoT Device

```dart
await bridge.sendRemoteSignal("iot/unlock", token);
```

---

## 🔐 Security Design

This package follows a **non-invasive security model**:

• Uses platform-native biometric APIs (no raw biometric access)
• Does NOT store fingerprint / face data
• Token generation uses cryptographic hashing
• Designed for trust signaling, not identity management

⚠ Important: Developers must still validate tokens server-side or device-side.

---

## 🧩 Example Use Cases

• Smart locks / secure access systems
• IoT device control with biometric gating
• Device-bound authorization flows
• Multi-factor security architectures
• Trusted remote commands

---

## ⚙ Supported Platforms

| Platform | Status                              |
| -------- | ----------------------------------- |
| Android  | ✅ Supported                         |
| iOS      | ✅ Supported                         |
| Windows  | ✅ Supported (device auth dependent) |
| macOS    | ✅ Supported                         |
| Linux    | ⚠ Biometric API dependent           |

---

## 📖 API Reference

### verifyBiometrics()

Triggers biometric authentication.

```dart
Future<bool> verifyBiometrics()
```

Returns `true` if user verification succeeds.

---

### generateSecureToken()

Generates a cryptographically secure token.

```dart
String generateSecureToken(String secret)
```

---

### sendRemoteSignal()

Publishes token to MQTT topic.

```dart
Future<void> sendRemoteSignal(String topic, String token)
```

---

## 🏗 Design Goals

`biometric_iot_bridge` prioritizes:

• Predictability
• Minimal abstraction
• Security-aware defaults
• Easy integration with MQTT / backend systems

---

## 🤝 Contributing

Contributions, improvements, and suggestions are welcome.

Typical workflow:

1. Fork repository
2. Create feature branch
3. Commit changes
4. Submit pull request

---

## 📜 License

MIT License. See `LICENSE`.

---

## 🌍 Attribution & Maintenance

Under development by **SEOSiri**
Developer: **Momenul Ahmad**

[https://www.seosiri.com](https://www.seosiri.com)

---

## ⭐ Support

If this package is useful:

• Star the GitHub repository
• Share with other developers
• Provide feedback / improvements
