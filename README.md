# my_first_app01

A Flutter project for a mini social network with email OTP verification.

## Description

This project is a Flutter application that allows users to register and log in using email and password. It includes an email verification step using a One-Time Password (OTP) sent via Firebase Cloud Functions.

## Features

- Email and password authentication
- OTP email verification during registration
- Animated and interactive UI
- Stepper-based registration
- Glassmorphism and particle background effects
- Works with Firebase Emulator for development

## Getting Started

### Prerequisites

- Flutter SDK installed
- Firebase project configured
- A Gmail account with an app password for sending emails

### Installation

1. Clone the repository:

git clone https://github.com/matinebadi/my_first_app01.git
cd my_first_app01

markdown
Copy code

2. Install dependencies:

flutter pub get

cpp
Copy code

3. Run the Firebase emulators (optional for testing email OTP locally):

firebase emulators:start

markdown
Copy code

4. Run the Flutter app:

flutter run

markdown
Copy code

## Usage

1. Open the app.
2. Go to the "Register" tab.
3. Fill in your name and email.
4. Receive a 6-digit OTP via email.
5. Enter the OTP and set your password.
6. Login with your credentials.

## Project Structure

- `lib/` - Contains Flutter source code, including `auth_screen.dart`
- `functions/` - Firebase Cloud Functions for sending OTP emails
- `android/` - Android app configuration
- `ios/` - iOS app configuration
- `web/`, `windows/`, `macos/`, `linux/` - Platform-specific configurations

## Notes

- **Sensitive files like `google-services.json` and `GoogleService-Info.plist` are ignored and not pushed to GitHub.**
- Make sure to configure your Firebase project and app passwords before running the app.

## References

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Animated Text Kit](https://pub.dev/packages/animated_text_kit)
- [Glassmorphism UI](https://pub.dev/packages/glassmorphism)

<img width="1310" height="669" alt="Capture33265" src="https://github.com/user-attachments/assets/387357ed-1f3d-44e1-8a8b-65c5a4260700" />

<img width="1301" height="669" alt="Capture112455" src="https://github.com/user-attachments/assets/12e308e8-0abb-4849-b434-5dea0e73fa0e" />



