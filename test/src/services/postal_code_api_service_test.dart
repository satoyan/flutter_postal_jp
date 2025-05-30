// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postal_jp/src/services/address_info.dart';
import 'package:postal_jp/src/services/api_result.dart';
import 'package:postal_jp/src/services/postal_code_api_service.dart';

import '../../mocks/mocks.mocks.dart';

void main() {
  final mockHttpClient = MockHttpClient();

  test('returns ApiSuccess with address info on successful API response',
      () async {
    final mockRequest = MockHttpClientRequest();
    final mockResponse = MockHttpClientResponse();

    when(mockHttpClient.getUrl(any)).thenAnswer((_) async => mockRequest);
    when(mockRequest.close()).thenAnswer((_) async => mockResponse);
    when(mockResponse.statusCode).thenReturn(HttpStatus.ok);
    when(mockResponse.transform(any)).thenAnswer((_) => Stream<String>.value('''
{
  "message": null,
  "results": [
{
  "address1": "東京都",
  "address2": "千種区",
  "address3": "千種",
  "kana1": "トウキョウト",
  "kana2": "チヨダク",
  "kana3": "チヨダ",
  "prefcode": "13",
  "zipcode": "1000001"
}
  ],
  "status": 200
}
  '''));

    final service = PostalCodeApiCodeService(httpClient: mockHttpClient);
    final result = await service.getAddressFromPostalCode('1000001');
    switch (result) {
      case ApiFailure():
        print(result.error);
      default:
        break;
    }

    expect(result, isA<ApiSuccess<List<AddressInfo>>>());
    expect((result as ApiSuccess<List<AddressInfo>>).data.length, 1);
    expect((result).data.first.address1, '東京都');
  });

  test('returns ApiFailure on API error', () async {
    when(mockHttpClient.getUrl(any)).thenThrow(
        SocketException("Failed host lookup: 'zipcloud.ibsnet.co.jp'"));

    final service = PostalCodeApiCodeService(httpClient: mockHttpClient);
    final result = await service.getAddressFromPostalCode('1000001');

    expect(result, isA<ApiFailure<List<AddressInfo>>>());
    expect((result as ApiFailure<List<AddressInfo>>).error,
        "Failed to connect: SocketException: Failed host lookup: 'zipcloud.ibsnet.co.jp'");
  });

  test('returns empty list when API returns no data', () async {
    final mockHttpClient = MockHttpClient();
    final mockRequest = MockHttpClientRequest();
    final mockResponse = MockHttpClientResponse();

    when(mockHttpClient.getUrl(any)).thenAnswer((_) async => mockRequest);
    when(mockRequest.close()).thenAnswer((_) async => mockResponse);
    when(mockResponse.statusCode).thenReturn(HttpStatus.ok);
    when(mockResponse.transform(any)).thenAnswer((_) => Stream<String>.value('''
{
  "message": null,
  "results": [],
  "status": 200
}
  '''));

    final service = PostalCodeApiCodeService(httpClient: mockHttpClient);
    final result = await service.getAddressFromPostalCode('1000001');

    expect(result, isA<ApiSuccess<List<AddressInfo>>>());
    expect((result as ApiSuccess<List<AddressInfo>>).data, isEmpty);
  });

  test('returns ApiFailure on unexpected API response format', () async {
    final mockHttpClient = MockHttpClient();
    final mockRequest = MockHttpClientRequest();
    final mockResponse = MockHttpClientResponse();

    when(mockHttpClient.getUrl(any)).thenAnswer((_) async => mockRequest);
    when(mockRequest.close()).thenAnswer((_) async => mockResponse);
    when(mockResponse.statusCode).thenReturn(HttpStatus.ok);
    when(mockResponse.transform(any)).thenAnswer((_) => Stream<String>.value('''
{
"message": null,
"unexpected_key": [],
"status": 200
}
'''));

    final service = PostalCodeApiCodeService(httpClient: mockHttpClient);
    final result = await service.getAddressFromPostalCode('1000001');

    expect(result, isA<ApiFailure<List<AddressInfo>>>());
    expect((result as ApiFailure<List<AddressInfo>>).error,
        startsWith('Failed to parse JSON response'));
  });
}
