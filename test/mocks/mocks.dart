import 'dart:io';

import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<HttpClient>(),
  MockSpec<HttpClientRequest>(),
  MockSpec<HttpClientResponse>(),
])
void dummy() {
  //
}
