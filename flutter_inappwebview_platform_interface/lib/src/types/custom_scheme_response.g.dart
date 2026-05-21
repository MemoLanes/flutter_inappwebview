// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_scheme_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class representing the response returned by the [PlatformWebViewCreationParams.onLoadResourceWithCustomScheme] event.
///It allows to load a specific resource. The resource data must be encoded to `base64`.
class CustomSchemeResponse {
  ///Content-Encoding of the data, such as `utf-8`.
  String contentEncoding;

  ///Content-Type of the data, such as `image/png`.
  String contentType;

  ///Data enconded to 'base64'.
  Uint8List data;

  ///HTTP response headers. Used together with [statusCode] to provide
  ///full HTTP semantics for the custom scheme response.
  ///If [statusCode] is set and this is `null`, a `Content-Type` header
  ///will be automatically added from [contentType].
  ///
  ///**Supported Platforms/Implementations**:
  ///- iOS ([Official API - HTTPURLResponse](https://developer.apple.com/documentation/foundation/httpurlresponse))
  ///- MacOS ([Official API - HTTPURLResponse](https://developer.apple.com/documentation/foundation/httpurlresponse))
  Map<String, String>? headers;

  ///HTTP status code (e.g. 200). When provided, platforms that support it
  ///will construct an HTTP-style response, enabling JavaScript `fetch()` and
  ///`XMLHttpRequest` to consume the result.
  ///
  ///**Supported Platforms/Implementations**:
  ///- iOS ([Official API - HTTPURLResponse](https://developer.apple.com/documentation/foundation/httpurlresponse))
  ///- MacOS ([Official API - HTTPURLResponse](https://developer.apple.com/documentation/foundation/httpurlresponse))
  int? statusCode;
  CustomSchemeResponse({
    this.contentEncoding = 'utf-8',
    required this.contentType,
    required this.data,
    this.headers,
    this.statusCode,
  });

  ///Gets a possible [CustomSchemeResponse] instance from a [Map] value.
  static CustomSchemeResponse? fromMap(
    Map<String, dynamic>? map, {
    EnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = CustomSchemeResponse(
      contentType: map['contentType'],
      data: Uint8List.fromList(map['data'].cast<int>()),
      headers: map['headers']?.cast<String, String>(),
      statusCode: map['statusCode'],
    );
    if (map['contentEncoding'] != null) {
      instance.contentEncoding = map['contentEncoding'];
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({EnumMethod? enumMethod}) {
    return {
      "contentEncoding": contentEncoding,
      "contentType": contentType,
      "data": data,
      "headers": headers,
      "statusCode": statusCode,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'CustomSchemeResponse{contentEncoding: $contentEncoding, contentType: $contentType, data: $data, headers: $headers, statusCode: $statusCode}';
  }
}
