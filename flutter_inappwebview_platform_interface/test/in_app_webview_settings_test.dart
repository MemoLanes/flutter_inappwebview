import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_inappwebview_platform_interface/flutter_inappwebview_platform_interface.dart';

void main() {
  group('topScrollEdgeEffectHidden', () {
    test('defaults to false without changing the native default', () {
      final settings = InAppWebViewSettings();

      expect(settings.topScrollEdgeEffectHidden, false);
      expect(settings.toMap()['topScrollEdgeEffectHidden'], false);
    });

    test('round-trips true, false, and null and preserves copies', () {
      for (final value in <bool?>[true, false, null]) {
        final settings = InAppWebViewSettings(topScrollEdgeEffectHidden: value);
        final roundTripped = InAppWebViewSettings.fromMap(settings.toMap())!;

        expect(settings.toMap()['topScrollEdgeEffectHidden'], value);
        expect(roundTripped.topScrollEdgeEffectHidden, value);
        expect(settings.copy().topScrollEdgeEffectHidden, value);
      }
    });

    test('serializes both directions of a settings update', () {
      final settings = InAppWebViewSettings();

      settings.topScrollEdgeEffectHidden = true;
      expect(settings.toMap()['topScrollEdgeEffectHidden'], true);
      settings.topScrollEdgeEffectHidden = false;
      expect(settings.toMap()['topScrollEdgeEffectHidden'], false);
    });
  });

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
