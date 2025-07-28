// ignore_for_file: unnecessary_string_interpolations, avoid_print

import 'dart:io';

import 'package:postal_jp/src/services/api_result.dart';
import 'package:postal_jp/src/services/postal_code_api_service.dart';

void main() async {
  final service = PostalCodeApiCodeService(httpClient: HttpClient());

  final result = await service.getAddressFromPostalCode('0790177');
  switch (result) {
    case ApiSuccess():
      print('${result.data}');
    case ApiFailure():
      print('${result.error}, ${result.stackTrace}');
  }

  exit(0);
}
