# app_icon_shape

A Flutter plugin to get the platform's app launcher icon's shape.

## Platform Support

| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :----: |
|   ✔️    | ❌  |  ❌   | ❌  |  ❌   |   ❌   |

Support for iOS is planned but not currently implemented.

## Usage

To use this plugin, add `app_icon_shape` as a dependency in your pubspec.yaml file.

## Example

Import the library.

```dart
import 'package:app_icon_shape/app_icon_shape.dart';
```

Then invoke the static `getAppIconMask` method anywhere in your Dart code.

```dart
Path? iconMask = await AppIconShape.getAppIconMask();
```

