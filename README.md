# my_first_app01

A Flutter mobile application that uses Firebase for email registration and OTP verification. This project includes the following features:

- **Email and password authentication**
- **OTP verification for email registration**
- **Glassmorphism-based user interface**
- **Firebase authentication integration**
- **Firebase Emulator Suite for local development**

## 🚀 Getting Started

Follow these steps to run the project locally:

1. **Clone the repository:**

```bash
git clone https://github.com/matinebadi/my_first_app01.git
Navigate into the project folder:

bash
Copy code
cd my_first_app01
Install dependencies:

bash
Copy code
flutter pub get
Run the app:

bash
Copy code
flutter run
🛠️ Prerequisites
Flutter SDK installed

Android Studio or Xcode for mobile development

Firebase CLI (for using Firebase Emulator Suite)

🔒 Sensitive Files
Sensitive files like google-services.json (Android) and GoogleService-Info.plist (iOS) are removed from Git history and are included in .gitignore to prevent them from being pushed again.

⚠️ If you want to use real Firebase services, you need to add your own google-services.json and GoogleService-Info.plist locally, but do not commit them.

📄 Project Structure
lib/ → Contains the Flutter source code (auth_screen.dart, main.dart, etc.)

functions/ → Firebase Cloud Functions for sending OTP emails

android/ → Android project configuration

ios/ → iOS project configuration

web/, linux/, macos/, windows/ → Platform-specific folders

⚡ Features
Step-based registration with OTP

Email verification

Login with email and password

Responsive UI with animations and Glassmorphism effect
