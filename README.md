# biometric_iot_bridge

Flutter biometric authentication and secure MQTT IoT bridge. Verify users with platform biometrics, generate cryptographic tokens, and trigger trusted device actions with hardware-level security.

[![Pub Version](https://img.shields.io/pub/v/biometric_iot_bridge)](https://pub.dev/packages/biometric_iot_bridge)
[![Pub Points](https://img.shields.io/pub/points/biometric_iot_bridge)](https://pub.dev/packages/biometric_iot_bridge/score)
[![Popularity](https://img.shields.io/pub/popularity/biometric_iot_bridge)](https://pub.dev/packages/biometric_iot_bridge/score)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Flutter-blue)](https://flutter.dev)
[![Security Focus](https://img.shields.io/badge/focus-Security-critical)](https://pub.dev/packages/biometric_iot_bridge)

---

## ✨ What is biometric_iot_bridge?

`biometric_iot_bridge` is a Flutter plugin that connects **device biometrics** with **secure token generation** and **IoT device signaling**.

It allows Flutter apps to securely:

- Verify users using fingerprint / face / device credentials
- Generate cryptographically secure tokens
- Send trusted commands to IoT devices via MQTT

This package is designed for **security-sensitive**, **device-aware**, and **remote-control** workflows.

---

## 🚀 Core Capabilities

| Feature | Description |
|---|---|
| ✅ Biometric Auth | Native platform APIs (fingerprint, face, device pin) |
| ✅ Secure Tokens | Cryptographic hashing — no raw biometric storage |
| ✅ MQTT Signaling | Publish tokens to IoT topics via MQTT |
| ✅ Flutter-First | Clean, minimal Dart API |
| ✅ Multi-Platform | Android, iOS, Windows, macOS |

---

## 🏗 Architecture Overview

```

┌───────────────────────┐
│     Flutter App       │
│  (Dart / UI Layer)    │
└──────────┬────────────┘
│
│ verifyBiometrics()
▼
┌───────────────────────┐
│   local_auth Plugin   │
│ (Platform Biometrics) │
└──────────┬────────────┘
│ Success / Failure
▼
┌───────────────────────┐
│  Token Generation     │
│ (SHA-256 via crypto)  │
└──────────┬────────────┘
│
│ sendRemoteSignal()
▼
┌───────────────────────┐
│    MQTT Client        │
│   (mqtt_client)       │
└──────────┬────────────┘
│
▼
┌───────────────────────┐
│    IoT / Backend      │
│ (Broker / Device)     │
└───────────────────────┘

````

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  biometric_iot_bridge: ^0.1.4
````

Then fetch packages:

```bash
flutter pub get
```

---

## ⚙️ Platform Setup

### Android

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC"/>
<uses-permission android:name="android.permission.USE_FINGERPRINT"/>
```

---

### iOS

Add to `ios/Runner/Info.plist`:

```xml
<key>NSFaceIDUsageDescription</key>
<string>This app uses Face ID / Touch ID to verify your identity.</string>
```

---

### Windows / macOS

No additional setup required. Uses native device authentication APIs.

---

## 🛠 Quick Start

### 1. Import

```dart
import 'package:biometric_iot_bridge/biometric_iot_bridge.dart';
```

---

### 2. Initialize

```dart
final bridge = BiometricIotBridge();
```

---

### 3. Verify Biometrics

```dart
final authenticated = await bridge.verifyBiometrics();

if (!authenticated) {
  print("Authentication failed");
  return;
}
```

---

### 4. Generate Secure Token

```dart
final token = bridge.generateSecureToken("my_secret_key");
```

---

### 5. Send Signal to IoT Device

```dart
await bridge.sendRemoteSignal("iot/unlock", token);
```

---

## 🔄 Full End-to-End Example

```dart
final bridge = BiometricIotBridge();

final authenticated = await bridge.verifyBiometrics();
if (!authenticated) return;

final token = bridge.generateSecureToken("your_secret_key");

await bridge.sendRemoteSignal("iot/device/action", token);
```

---

## 🔐 Security Design

This package follows a **non-invasive security model**:

* Uses platform-native biometric APIs — no raw biometric data accessed
* Does **NOT** store fingerprint / face data
* Cryptographic token generation via SHA-256
* Designed for **trust signaling**, not identity storage

> ⚠️ Important: Always validate tokens server-side or device-side.

---

## 🛡 Threat Model & Security Notes

`biometric_iot_bridge` assumes:

**Trusted Components**

* OS biometric subsystem
* Secure enclave / TEE (when available)
* MQTT transport security (developer responsibility)

**Out of Scope**

* Broker compromise
* Replay attacks without nonce/expiry
* Secret key management

**Recommended Hardening**

* Use TLS MQTT (port 8883)
* Add token expiry / nonce
* Rotate secrets periodically
* Validate topic permissions

---

## 🧩 Example Use Cases

* Smart locks / physical access systems
* IoT device authorization
* Hardware-bound trust flows
* Secure remote triggers
* Multi-factor security pipelines

---

## ⚙️ Supported Platforms

| Platform | Status      |
| -------- | ----------- |
| Android  | ✅ Supported |
| iOS      | ✅ Supported |
| Windows  | ✅ Supported |
| macOS    | ✅ Supported |

---

## 📖 API Reference

### `verifyBiometrics()`

```dart
Future<bool> verifyBiometrics()
```

Triggers platform biometric authentication.

---

### `generateSecureToken(String secret)`

```dart
String generateSecureToken(String secret)
```

Returns SHA-256 hash token.

---

### `sendRemoteSignal(String topic, String token)`

```dart
Future<void> sendRemoteSignal(String topic, String token)
```

Publishes token to MQTT topic.

---

## 📦 Dependencies

| Package     | Purpose                  |
| ----------- | ------------------------ |
| local_auth  | Biometric authentication |
| crypto      | Secure hashing           |
| mqtt_client | MQTT communication       |

---

## 🏗 Design Goals

* Predictable API behaviour
* Minimal abstraction
* Security-aware defaults
* Broker-agnostic design

---

## 📈 pub.dev Scoring Optimization

This package follows pub.dev best practices:

* ✅ Platform setup documented
* ✅ Example usage provided
* ✅ Null-safe Dart
* ✅ Lints enabled
* ✅ License included
* ✅ Repository metadata defined

---

## 🤝 Contributing

PRs and improvements welcome.

Repository: [https://github.com/SEOSiri-Official/biometric_iot_bridge](https://github.com/SEOSiri-Official/biometric_iot_bridge)

---

## 📜 License

MIT License. See [LICENSE](LICENSE).

---

## 🌍 Attribution & Maintenance

Developed & maintained by:

**Momenul Ahmad**
SEOSiri — [https://www.seosiri.com](https://www.seosiri.com)

---

## ⭐ Support

If this package is useful:

* ⭐ Star the GitHub repository
* 👍 Like on pub.dev
* 🐛 Report issues

```