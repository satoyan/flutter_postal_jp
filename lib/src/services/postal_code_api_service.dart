import 'dart:convert';
import 'dart:io';

import 'package:postal_jp/src/services/address_info.dart';
import 'package:postal_jp/src/services/api_result.dart';

/// A service class that retrieves postal code information from an external API.
class PostalCodeApiCodeService {
  static const baseUrl = 'https://zipcloud.ibsnet.co.jp/api/search?zipcode=';
  static const queryParamKey = 'zipcode';
  final HttpClient httpClient;

  /// Constructs a [PostalCodeApiCodeService].
  ///
  /// [httpClient] is the client used to make HTTP requests.
  PostalCodeApiCodeService({required this.httpClient});

  /// Retrieves address information based on the provided postal code.
  ///
  /// This function queries an external API to fetch address details
  /// associated with the given postal code.
  ///
  /// @param postalCode The postal code to search for. Must be a valid postal code string.
  /// @return A [Future] that resolves to an [ApiResult].
  ///   - If the API call is successful and the response is properly parsed,
  ///     it returns an [ApiSuccess] containing a [List] of [AddressInfo] objects.
  ///   - If the API call fails, the response status code is not OK,
  ///     or the JSON response cannot be parsed, it returns an [ApiFailure]
  ///     with an error message and optional stack trace.
  Future<ApiResult<List<AddressInfo>>> getAddressFromPostalCode(
    String postalCode,
  ) async {
    final url = Uri.parse('$baseUrl$postalCode');

    try {
      final request = await httpClient.getUrl(url);
      final response = await request.close();

      if (response.statusCode != HttpStatus.ok) {
        return ApiResult.failure(
          error: 'HTTP request failed with status: ${response.statusCode}',
        );
      }

      final responseBody = await response.transform(utf8.decoder).join();
      try {
        return switch (jsonDecode(responseBody)) {
          {'results': final List<dynamic> items} => ApiSuccess(
            items
                .map<AddressInfo?>(
                  (item) => AddressInfo.fromMap(item as Map<String, dynamic>),
                )
                .nonNulls
                .toList(),
          ),
          _ => ApiResult.failure(
            error: 'Failed to parse JSON response with $responseBody',
          ),
        };
      } catch (e, s) {
        return ApiResult.failure(
          error: 'Failed to parse JSON: $e',
          stackTrace: s,
        );
      }
    } catch (e, s) {
      return ApiResult.failure(error: 'Failed to connect: $e', stackTrace: s);
    }
  }
}
