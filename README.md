<div align="center">

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=26&duration=3000&pause=1000&color=54C5F8&center=true&width=500&lines=💧+Tanker+Wala;Water+Tanker+Booking+App" alt="Tanker Wala" />

<p>
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=54C5F8" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=black" />
  <img src="https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white" />
</p>

<p>
  <img src="https://img.shields.io/badge/License-MIT-blue?style=flat" />
  <img src="https://img.shields.io/badge/Built_With-Flutter-54C5F8?style=flat" />
  <img src="https://img.shields.io/badge/Status-Active-39d353?style=flat" />
</p>

</div>

---

## 💧 About

**Tanker Wala** is a cross-platform mobile app (iOS & Android) that lets users book water tankers on demand. Users can browse available tankers, place a booking, and track their delivery in real-time — all powered by Flutter & Firebase.

---

## ✨ Features

### 📱 User Side
- 🔐 User authentication (Sign up / Login via Firebase Auth)
- 📍 Browse available water tankers nearby
- 🗓️ Book a tanker with preferred date & time slot
- 📦 Real-time booking status tracking
- 🔔 Push notifications for booking updates (FCM)
- 🧾 Order history & delivery receipts
- ❌ Cancel or reschedule bookings

### 🚚 Driver / Admin Side
- ✅ Accept or reject incoming booking requests
- 🗺️ View assigned deliveries with details
- 🔄 Update delivery status in real-time
- 📊 Dashboard for managing all orders

---

## 🛠️ Tech Stack

| Technology | Usage |
|---|---|
| **Flutter** | Cross-platform UI framework |
| **Dart** | Programming language |
| **Firebase Auth** | User authentication |
| **Cloud Firestore** | Real-time database |
| **Firebase Cloud Messaging** | Push notifications |
| **Firebase Storage** | Image & file storage |

---

## 📸 Screenshots

<table>
  <tr>
    <td align="center"><b>Home</b></td>
    <td align="center"><b>Booking</b></td>
    <td align="center"><b>Tracking</b></td>
    <td align="center"><b>Profile</b></td>
  </tr>
  <tr>
    <td><img src="screenshots/home.png" width="180"/></td>
    <td><img src="screenshots/booking.png" width="180"/></td>
    <td><img src="screenshots/tracking.png" width="180"/></td>
    <td><img src="screenshots/profile.png" width="180"/></td>
  </tr>
</table>

> 📌 Add your screenshots inside a `screenshots/` folder in the repo root

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed → [flutter.dev](https://flutter.dev)
- Firebase project set up → [console.firebase.google.com](https://console.firebase.google.com)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/M-Rohail/tanker-wala.git

# 2. Navigate into the project
cd tanker-wala

# 3. Install dependencies
flutter pub get

# 4. Add Firebase config files
#    Android: place google-services.json in android/app/
#    iOS: place GoogleService-Info.plist in ios/Runner/

# 5. Run the app
flutter run
```

---

## 📁 Project Structure

```
lib/
├── main.dart
├── models/          # Data models (User, Booking, Tanker)
├── screens/         # All app screens
├── services/        # Firebase services
├── widgets/         # Reusable UI components
└── utils/           # Constants & helpers
```

---

## 🤝 Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

<div align="center">
  <p>Built with 💙 by <a href="https://github.com/M-Rohail">Muhammad Rohail</a></p>
  <p>
    <img src="https://img.shields.io/badge/Flutter-Developer-54C5F8?style=flat&logo=flutter" />
    <img src="https://img.shields.io/badge/Islamabad-Pakistan-green?style=flat" />
  </p>
</div>
