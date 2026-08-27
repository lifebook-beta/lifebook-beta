# LifeBook Beta — Build APK from an Android phone

## 1. Create a GitHub repository
Create a new repository named `lifebook-beta`.

## 2. Upload this project
Upload the contents of this ZIP to the repository root. Keep the `.github/workflows/build_demo_apk.yml` file.

## 3. Run the build
Open GitHub → Actions → `Build LifeBook Beta Demo APK` → `Run workflow`.

The workflow creates the missing Android project files with `flutter create`, installs dependencies, and builds:
`build/app/outputs/flutter-apk/app-release.apk`

## 4. Download
When the workflow finishes, open the workflow run and download the artifact:
`LifeBook-Beta-Demo-APK`

## Note
This is a UI/demo APK. Firebase is intentionally not initialized in the demo entry point, so it can run before Firebase configuration.
The production build will use the real Firebase configuration and Google authentication.
