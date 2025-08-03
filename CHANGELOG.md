## 1.0.5
- Corrected English in README.md.
- Updated package description.

## 1.0.4
- Refactored API client for improved robustness and code quality.
- Removed manual test script.

## 1.0.3
- Updated Dart SDK constraint to ^3.8.1
- Updated Flutter constraint to ">=1.17.0"
- Upgraded dev dependencies:
  - flutter_lints to ^6.0.0
  - mockito to ^5.4.6
  - analyzer to ^7.4.5
- Updated Gradle wrapper to 8.4 in the example project
- Updated Android Gradle plugin to 8.3.0 in the example project
- Added .mise.local.toml file with Flutter version 3.32.4

## 1.0.2
- Update README.md

## 1.0.1
- Update README.md

## 1.0.0

- Initial release of the package.
- Added functionality to retrieve address information based on a 7-digit Japanese postal code.
- Implemented `PostalCodeService` for fetching data from the Zip Cloud API.
- Provided `AddressInfo` objects containing Japanese address components and kana readings.
- Included error handling to return `ApiFailure` with appropriate error messages.