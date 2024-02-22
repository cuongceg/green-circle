## In this document:

1. [How to run this project?](#how-to-run-this-project)
2. [Folder structure](#folder-structure)
3. [Bugs and todo](#bugs-and-todo)

## How to run this project?

> ⚠️ **Make sure Flutter CLI is installed.**

1. Clone this repository:

```
git clone https://github.com/cuongceg/meow-money.git
```

2. Install all dependencies (libraries):

```
flutter pub get
```

3. Run the project:

```
flutter run
```

Using this command, the terminal will look somthing like this:

```
Connected devices:
Windows (desktop) • windows • windows-x64    • Microsoft Windows [Version 10.0.22621.2134]
Chrome (web)      • chrome  • web-javascript • Google Chrome 116.0.5845.187
Edge (web)        • edge    • web-javascript • Microsoft Edge 116.0.1938.76
[1]: Windows (windows)
[2]: Chrome (chrome)
[3]: Edge (edge)
Please choose one (or "q" to quit):
```

If you have an [Android virtual device](https://developer.android.com/studio/run/managing-avds?hl=en), or an Android Device connected via USB that enabled [USB Debugging](https://developer.android.com/studio/debug/dev-options?hl=en#debugging), it will show up in the connected devices as well.

Running the app on mobile devices is recommended.

## Folder structure
```
├── android/ - Contains build artifacts for Android
├── assets/ - Contains static files (images, videos, audios)
├── ios/ - Contains build artifacts for iOS
├── lib/ - Contains source code
    ├── models/ - Contains classes of real-world objects
    ├── pages/ - Contains widgets represented as pages or screens
        ├── e_commerce/ - Contains e_commerce screens
            ├── wrapper is a listen for auth changes screen
        ├── mapbox/ -Contains map screens
    ├── services/ - Contains classes controll models
    ├── widgets/ - Contains components
        ├── product_widgets - Contains product components
        ├── home_slider.dart is image slider for banner in home
        ├── nav_bar.dart is  top navigator component in home.dart
    ├── const_value.dart - Contains const value and methods
    ├── firebase_options.dart - Contains current platform for Firebase
    ├── main.dart - Entry point (code starts here)
├── macos/ - Contain build artifacts for macOS
├── test/ - Contains code for testing
├── web/ - Contains static web files (HTML, CSS)
├── analysis_options.yaml - Contains rules for linter (flutter_lints)
├── pubspec.lock - Contains exact, locked version of dependencies
├── pubspec.yaml - Contains approximate version of dependencies
├── README.md - This documents
```

## Bugs and todo
**Bugs:**
* AppCheck token
* Location package confict with mapbox_gl
* Secret map token is ignored in gradle.properties (don't push Github)

**Todo**
* Get current user location ([Location](https://pub.dev/packages/location))
* Mark up button onPressed()
