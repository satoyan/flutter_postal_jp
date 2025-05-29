import 'dart:io';

import 'package:postal_jp/src/services/address_info.dart';
import 'package:postal_jp/src/services/api_result.dart';
import 'package:postal_jp/src/services/postal_code_api_service.dart';

class PostalJP {
  late final apiService = PostalCodeApiCodeService(httpClient: HttpClient());

  /// Retrieves address information based on the provided postal code.
  ///
  /// This function queries a postal code API to find address details
  /// associated with the given postal code.
  ///
  /// Args:
  ///   postalCode (String): The postal code to search for. Must be a valid postal code format.
  ///
  /// Returns:
  ///   Future<ApiResult<List<AddressInfo>>>: An [ApiResult] containing either a list of [AddressInfo]
  ///   objects if the postal code is found, or an error if the postal code is invalid or
  ///   the API request fails.
  Future<ApiResult<List<AddressInfo>>> getAddress({
    required String postalCode,
  }) async {
    return apiService.getAddressFromPostalCode(postalCode);
  }
}
