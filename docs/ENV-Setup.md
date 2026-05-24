# Environment setup

This project uses a `.env` file for runtime configuration via `flutter_dotenv`.

- Copy `.env.example` to `.env` at the project root:

```bash
cp .env.example .env
```

- Put your real API keys and IDs into `.env` (do NOT commit it).

- `.env` is already ignored by `.gitignore` and the example file is committed.

- `pubspec.yaml` includes `.env` and `.env.example` under `flutter.assets` so the file is available on all platforms (web, Android, iOS).

- After creating or updating `.env`, run:

```bash
flutter pub get
```

- Then run the app on your target device/emulator:

```bash
flutter run -d chrome
# or
flutter emulators --launch <emulatorId>
flutter run -d emulator-5554
```

Notes:
- The app uses defaults when `.env` is missing to allow quick local development.
- Keep secrets out of the repository; use environment variables in CI or a secret store for production.
