# DigitalHam

A cross‑platform Flutter app for ham radio operators that encodes and decodes FT8, FT4 and FT2 signals. The project is structured around **agents** that encapsulate distinct responsibilities (signal processing, audio handling, storage, synchronization, UI, integrations, security, testing and CI/CD).

## Features (planned)
- Real‑time generation and decoding of FT8/FT4/FT2 signals.
- Audio capture, filtering and playback.
- Offline‑first local storage (Drift + SQLCipher) with optional encrypted cloud sync (Firebase Firestore).
- Dark theme, accessibility support and hot‑reload friendly UI.
- Integration with QRZ/HamQTH, DXCluster (WebSocket) and other external services.
- Secure handling of microphone permission and secret keys.
- Comprehensive unit, integration and UI test suite.
- CI/CD pipelines with GitHub Actions.

## Getting Started
```bash
# Clone the repository (already done in your workspace)
flutter pub get            # Install dependencies
flutter run               # Launch the app on a connected device or emulator
```

### Development workflow
- Run `flutter pub get` after any change to `pubspec.yaml`.
- Use **hot‑reload** (`r` in the console) for rapid UI iteration.
- Follow the **agents** directory layout for any new feature.
- All commits must be in English and pass `flutter test` and `flutter analyze`.

## Contributing
Contributions are welcome! Please:
1. Fork the repo.
2. Create a feature branch.
3. Ensure all tests pass.
4. Open a pull request with a clear description.

## Donations
If you find this project useful, consider supporting its development:

- PayPal: https://www.paypal.me/yuryja

## License
This project is released under the MIT License. See the [LICENSE](LICENSE) file for details.
