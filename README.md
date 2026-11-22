# DoorStep Fix GTA — Android App

Customer-facing Android app for **DoorStep Fix GTA**, mobile phone repair at the
customer's home (iPhone & Samsung). Companion to the appointment website — same
prices, slots and service area.

- Package / applicationId: `com.doorstepfix.gta`
- App name shown: **DoorStep Fix GTA**
- Screens (bottom nav): Home, Prices, Book, Info

## Owner setup — constants in `lib/config.dart`

All owner-editable values live at the top of **`lib/config.dart`**.

**Booking system (owner decision, Nov 22, 2026): ONLINE FORM -> WHATSAPP ONLY.**
There is no third-party booking platform in this app. The Book screen form *is*
the appointment system: on submit it opens WhatsApp with the full booking
summary prefilled (Copy is offered as a backup).

### WhatsApp number — SET (real number)
```dart
const String whatsAppNumber = '16476840588';
const String whatsAppDisplayNumber = '647-684-0588';
const String whatsAppLink = 'https://wa.me/16476840588';
```
Owner-provided Nov 22, 2026. Displayed as **647-684-0588** everywhere in the app.
The Book screen's **"Send on WhatsApp"** button opens
`https://wa.me/16476840588?text=<url-encoded booking summary>` with the customer's
booking prefilled; "Copy Booking" is also offered. If the number ever changes,
update all three constants together.

## How booking works in the app
The Book form (name, phone, city, model, repair, date, 11 AM / 1 PM / 3 PM slot,
notes) shows a live estimate (repair price + $25 home visit fee, waived at $120+),
then generates a booking summary the customer can send on WhatsApp or copy.
**No payment is taken in the app.** Booking is confirmed by the owner's WhatsApp reply.

## Build

Toolchain on this machine (from `~/workspace/tools/`):
```bash
export JAVA_HOME=$HOME/workspace/tools/jdk
export ANDROID_HOME=$HOME/workspace/tools/android-sdk
export PATH=$JAVA_HOME/bin:$HOME/workspace/tools/flutter/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH

cd ~/workspace/phone-repair-mobile-business/app-src
flutter pub get
flutter analyze
flutter build apk --debug     # debug APK
flutter build apk --release   # release APK (debug-signed by default config — set up a real keystore before any Play Store use)
```

Debug APK output: `build/app/outputs/flutter-apk/app-debug.apk`

## Notes
- Dependencies are kept minimal: stock Flutter + `url_launcher` (only used to open
  the wa.me WhatsApp link).
- Launcher icon: simple custom teal phone/check icon generated for all mipmap
  densities in `android/app/src/main/res/`. Replace with a designed logo anytime
  by overwriting those `ic_launcher.png` files.
- Prices live in `lib/data.dart`; cities/slots/fees in `lib/config.dart`.
- Not published to the Play Store. No accounts were created for this app.

## Build status on this machine (Nov 22, 2026)
- `flutter analyze`: **No issues found.**
- APK build: **blocked by a machine-level Gradle problem**, not by app code.
  Even a plain `./gradlew help` fails with
  `DaemonConnectionException: Could not dispatch a message to the daemon`
  caused by `java.io.IOException: Broken pipe` when the Gradle client writes
  to the daemon socket at 127.0.0.1 — reproduced with and without
  `--no-daemon`, with a warm daemon, and with the Gradle distribution
  installed from the local zip at `~/workspace/tools/gradle-9.3.1-all.zip`
  (the normal wrapper download also fails through this machine's proxy
  with an SSL error). No APK is shipped until that Gradle daemon issue is
  fixed on the machine; the app code itself analyzes clean and is ready to
  build with the commands above on a working toolchain.
