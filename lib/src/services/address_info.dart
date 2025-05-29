class AddressInfo {
  AddressInfo({
    this.address1,
    this.address2,
    this.address3,
    this.kana1,
    this.kana2,
    this.kana3,
    this.prefcode,
    this.postalCode,
  });

  final String? address1;
  final String? address2;
  final String? address3;
  final String? kana1;
  final String? kana2;
  final String? kana3;
  final String? prefcode;
  final String? postalCode;

  /// Creates an `AddressInfo` object from a map.
  ///
  /// The map should have keys corresponding to the fields of `AddressInfo`.
  ///
  /// @param map A map containing the data to populate the `AddressInfo` object.
  ///   The map should have the following keys:
  ///     - 'address1': The first address line.
  ///     - 'address2': The second address line.
  ///     - 'address3': The third address line.
  ///     - 'kana1': The first address line in kana.
  ///     - 'kana2': The second address line in kana.
  ///     - 'kana3': The third address line in kana.
  ///     - 'prefcode': The prefecture code.
  ///     - 'zipcode': The postal code.
  ///
  /// @return An `AddressInfo` object populated with the data from the map.
  factory AddressInfo.fromMap(Map<String, dynamic> map) {
    return AddressInfo(
      address1: map['address1'],
      address2: map['address2'],
      address3: map['address3'],
      kana1: map['kana1'],
      kana2: map['kana2'],
      kana3: map['kana3'],
      prefcode: map['prefcode'],
      postalCode: map['zipcode'],
    );
  }

  /// Converts the `AddressInfo` object to a map.
  ///
  /// @return A map containing the data from the `AddressInfo` object.
  ///   The map will have the following keys:
  ///     - 'address1': The first address line.
  ///     - 'address2': The second address line.
  ///     - 'address3': The third address line.
  ///     - 'kana1': The first address line in kana.
  ///     - 'kana2': The second address line in kana.
  ///     - 'kana3': The third address line in kana.
  ///     - 'prefcode': The prefecture code.
  ///     - 'zipcode': The postal code.
  Map<String, dynamic> toMap() {
    return {
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'kana1': kana1,
      'kana2': kana2,
      'kana3': kana3,
      'prefcode': prefcode,
      'zipcode': postalCode,
    };
  }

  @override
  String toString() {
    return '${toMap()}';
  }
}
