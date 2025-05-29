import 'dart:convert';
import 'dart:io';

import 'package:postal_jp/src/services/address_info.dart';
import 'package:postal_jp/src/services/api_result.dart';

class PostalCodeApiCodeService {
  static const baseUrl = 'https://zipcloud.ibsnet.co.jp/api/search?zipcode=';
  static const queryParamKey = 'zipcode';
  final HttpClient httpClient;

  PostalCodeApiCodeService({
    required this.httpClient,
  });

  Future<ApiResult<List<AddressInfo>>> getAddressFromPostalCode(
      String postalCode) async {
    final url = Uri.parse('$baseUrl$postalCode');

    try {
      final request = await httpClient.getUrl(url);
      final response = await request.close();

      if (response.statusCode != HttpStatus.ok) {
        return ApiResult.failure(
            error: 'HTTP request failed with status: ${response.statusCode}');
      }

      final responseBody = await response.transform(utf8.decoder).join();
      try {
        // print(jsonDecode(responseBody));
        return switch (jsonDecode(responseBody)) {
          {
            'results': final List<dynamic> items,
          } =>
            ApiSuccess(items
                .map<AddressInfo?>(
                  (item) => switch (item) {
                    {
                      'address1': _,
                      'address2': _,
                      'address3': _,
                      'kana1': _,
                      'kana2': _,
                      'kana3': _,
                      'prefcode': _,
                      'zipcode': _,
                    } =>
                      AddressInfo.fromMap(item as Map<String, dynamic>),
                    _ => null,
                  },
                )
                .nonNulls
                .toList()),
          _ => ApiResult.failure(
              error: 'Failed to parse JSON response with $responseBody'),
        };
      } catch (e, s) {
        return ApiResult.failure(
          error: 'Failed to parse JSON: $e',
          stackTrace: s,
        );
      }
    } catch (e, s) {
      return ApiResult.failure(
        error: 'Failed to connect: $e',
        stackTrace: s,
      );
    }
  }
}
