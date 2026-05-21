import 'dart:typed_data';

import 'package:flutter_inappwebview_internal_annotations/flutter_inappwebview_internal_annotations.dart';
import '../in_app_webview/platform_webview.dart';
import 'enum_method.dart';

part 'custom_scheme_response.g.dart';

///Class representing the response returned by the [PlatformWebViewCreationParams.onLoadResourceWithCustomScheme] event.
///It allows to load a specific resource. The resource data must be encoded to `base64`.
@ExchangeableObject()
class CustomSchemeResponse_ {
  ///Data enconded to 'base64'.
  Uint8List data;

  ///Content-Type of the data, such as `image/png`.
  String contentType;

  ///Content-Encoding of the data, such as `utf-8`.
  String contentEncoding;

  ///HTTP status code (e.g. 200). When provided, platforms that support it
  ///will construct an HTTP-style response, enabling JavaScript `fetch()` and
  ///`XMLHttpRequest` to consume the result.
  ///
  ///**Supported Platforms/Implementations**:
  ///- iOS ([Official API - HTTPURLResponse](https://developer.apple.com/documentation/foundation/httpurlresponse))
  ///- MacOS ([Official API - HTTPURLResponse](https://developer.apple.com/documentation/foundation/httpurlresponse))
  int? statusCode;

  ///HTTP response headers. Used together with [statusCode] to provide
  ///full HTTP semantics for the custom scheme response.
  ///If [statusCode] is set and this is `null`, a `Content-Type` header
  ///will be automatically added from [contentType].
  ///
  ///**Supported Platforms/Implementations**:
  ///- iOS ([Official API - HTTPURLResponse](https://developer.apple.com/documentation/foundation/httpurlresponse))
  ///- MacOS ([Official API - HTTPURLResponse](https://developer.apple.com/documentation/foundation/httpurlresponse))
  Map<String, String>? headers;

  CustomSchemeResponse_({
    required this.data,
    required this.contentType,
    this.contentEncoding = 'utf-8',
    this.statusCode,
    this.headers,
  });
}
