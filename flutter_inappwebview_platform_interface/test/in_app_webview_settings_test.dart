import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_inappwebview_platform_interface/flutter_inappwebview_platform_interface.dart';

void main() {
  test('round-trips shouldInterceptRequestUrlPrefixes', () {
    final settings = InAppWebViewSettings(
      shouldInterceptRequestUrlPrefixes: const [
        'https://memolanes.local/api/',
        'https://memolanes.local/assets/',
      ],
    );

    final roundTripped = InAppWebViewSettings.fromMap(settings.toMap())!;

    expect(
      roundTripped.shouldInterceptRequestUrlPrefixes,
      settings.shouldInterceptRequestUrlPrefixes,
    );
  });

  test(
    'preserves null and empty prefix-list semantics through serialization',
    () {
      expect(
        InAppWebViewSettings.fromMap(
          InAppWebViewSettings().toMap(),
        )!.shouldInterceptRequestUrlPrefixes,
        isNull,
      );
      expect(
        InAppWebViewSettings.fromMap(
          InAppWebViewSettings(
            shouldInterceptRequestUrlPrefixes: const [],
          ).toMap(),
        )!.shouldInterceptRequestUrlPrefixes,
        isEmpty,
      );
    },
  );
}
