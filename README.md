<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# flutter_postal_jp

[![pub package](https://img.shields.io/pub/v/flutter_postal_jp.svg)](https://pub.dev/packages/flutter_postal_jp)
![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)
[![Platform Badge](https://img.shields.io/badge/platform-android%20|%20ios%20-green.svg)](https://pub.dev/packages/flutter_postal_jp)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Dart package for retrieving Japanese postal address information from a postal code. 

This package depends on the [Zip Cloud](https://zipcloud.ibsnet.co.jp/) web service.

![demo!](https://raw.githubusercontent.com/satoyan/flutter_postal_jp/refs/heads/master/example/example.gif)

## Features

- Retrieve address information (prefecture, city, town) based on a 7-digit Japanese postal code.
    - 7桁の日本の郵便番号から住所情報（都道府県、市区町村）を取得します。
- Provides `PostalCodeService` to fetch data from an external API.
    - 外部APIからデータを取得する`PostalCodeService`を提供します。
- Returns data as `AddressInfo` objects, including Japanese address components and kana readings.
    - 日本語の住所構成要素とかな読みを含む`AddressInfo`オブジェクトとしてデータを返します。
- Handles API errors and returns `ApiFailure` with error messages.
    - APIエラーを処理し、エラーメッセージとともに`ApiFailure`を返します。


## Getting started

1.  **Add the dependency to your `pubspec.yaml` file:**

    ```yaml
    dependencies:
      postal_jp: ^<latest_version> # Replace with the latest version
    ```

2.  **Install the package:**

    ```bash
    flutter pub get
    ```

## Usage

```dart
import 'package:postal_jp/postal_jp.dart';

void main() async {
  final service = PostalJP();
  final result = await service.getAddress(postalCode: '0790177');
  switch (result) {
    case ApiSuccess(data: var addressInfoList):
      for (var address in addressInfoList) {
        print(
          'Address: ${address.address1} ${address.address2} ${address.address3}',
        );
      }
    case ApiFailure():
      print('Error: ${result.error}');
  }
}
```

