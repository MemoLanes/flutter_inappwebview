import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomSchemeDemoScreen extends StatefulWidget {
  const CustomSchemeDemoScreen({super.key});

  @override
  State<CustomSchemeDemoScreen> createState() => _CustomSchemeDemoScreenState();
}

class _CustomSchemeDemoScreenState extends State<CustomSchemeDemoScreen> {
  final List<_TestResult> _results = [];
  bool _testsComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Scheme Demo'),
        actions: [
          if (_testsComplete)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  '${_results.where((r) => r.passed).length}/${_results.length} passed',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.blue.shade50,
            width: double.infinity,
            child: const Text(
              'Tests whether fetch/XHR/img/script/CSS can consume '
              'custom scheme responses.\n'
              'On iOS, fetch and XHR are expected to FAIL due to '
              'URLResponse (no status code).',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 2,
            child: _buildResultsPanel(),
          ),
          const Divider(height: 1),
          Expanded(
            flex: 3,
            child: _buildWebView(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsPanel() {
    if (_results.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Running tests...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final result = _results[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: Icon(
              result.passed ? Icons.check_circle : Icons.cancel,
              color: result.passed ? Colors.green : Colors.red,
              size: 28,
            ),
            title: Text(
              result.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            subtitle: Text(
              result.detail,
              style: TextStyle(
                fontSize: 11,
                color: result.passed ? Colors.green.shade700 : Colors.red.shade700,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }

  Widget _buildWebView() {
    return InAppWebView(
      initialFile: "test_assets/custom_scheme_demo.html",
      initialSettings: InAppWebViewSettings(
        resourceCustomSchemes: ["my-custom-scheme"],
        javaScriptEnabled: true,
      ),
      onWebViewCreated: (controller) {
        controller.addJavaScriptHandler(
          handlerName: "testResults",
          callback: (args) {
            if (args.isNotEmpty) {
              final List<dynamic> parsed = jsonDecode(args[0]);
              setState(() {
                _results.clear();
                for (final item in parsed) {
                  _results.add(_TestResult(
                    name: item['name'] as String,
                    passed: item['passed'] as bool,
                    detail: item['detail'] as String,
                  ));
                }
                _testsComplete = true;
              });
            }
          },
        );
      },
      onLoadResourceWithCustomScheme: (controller, request) async {
        final path = request.url.path;

        if (path == '/api/data') {
          final jsonBody = jsonEncode({'message': 'Hello from custom scheme', 'timestamp': DateTime.now().toIso8601String()});
          return CustomSchemeResponse(
            data: Uint8List.fromList(utf8.encode(jsonBody)),
            contentType: "application/json",
            contentEncoding: "utf-8",
          );
        }

        if (path == '/image.svg') {
          const svg = '<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100">'
              '<rect width="100" height="100" fill="#4CAF50"/>'
              '<text x="50" y="55" text-anchor="middle" fill="white" font-size="14">OK</text>'
              '</svg>';
          return CustomSchemeResponse(
            data: Uint8List.fromList(utf8.encode(svg)),
            contentType: "image/svg+xml",
            contentEncoding: "utf-8",
          );
        }

        if (path == '/script.js') {
          const js = 'window.__customSchemeScriptCallback({"loaded": true, "source": "custom-scheme"});';
          return CustomSchemeResponse(
            data: Uint8List.fromList(utf8.encode(js)),
            contentType: "application/javascript",
            contentEncoding: "utf-8",
          );
        }

        if (path == '/style.css') {
          const css = 'body { border-top: 3px solid #4CAF50; }';
          return CustomSchemeResponse(
            data: Uint8List.fromList(utf8.encode(css)),
            contentType: "text/css",
            contentEncoding: "utf-8",
          );
        }

        return null;
      },
      onConsoleMessage: (controller, consoleMessage) {
        debugPrint('[WebView Console] ${consoleMessage.message}');
      },
    );
  }
}

class _TestResult {
  final String name;
  final bool passed;
  final String detail;

  _TestResult({required this.name, required this.passed, required this.detail});
}
