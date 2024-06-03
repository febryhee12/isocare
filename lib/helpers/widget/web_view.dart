import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../config.dart';
import '../ui_data.dart';

// ignore: must_be_immutable
class WebWidgetView extends StatefulWidget {
  String? title;
  String? url;
  void Function()? backPress;
  Future<bool> Function()? willPopScope = () => getBack();
  WebWidgetView(
      {super.key, this.title, this.url, this.backPress, this.willPopScope});

  @override
  State<WebWidgetView> createState() => _WebWidgetViewState();
}

getBack() {
  Get.back();
}

class _WebWidgetViewState extends State<WebWidgetView> {
  late InAppWebViewController webViewController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    // Set preferred orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    // Clear preferred orientations when the screen is disposed
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.willPopScope,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Txt(
            '${widget.title}',
            const TextStyle(color: UIColor.cDark70),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: widget.backPress,
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: Stack(
          children: [
            InAppWebView(
              androidOnGeolocationPermissionsShowPrompt:
                  (InAppWebViewController controller, String origin) async {
                return GeolocationPermissionShowPromptResponse(
                    origin: origin, allow: true, retain: true);
              },
              androidOnPermissionRequest: (InAppWebViewController controller,
                  String origin, List<String> resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              initialUrlRequest: URLRequest(
                url: Uri.parse("${widget.url}"),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webViewController = controller;
              },
              onProgressChanged: (InAppWebViewController controller, int p) {
                setState(() {
                  progress = p / 100;
                });
              },
            ),
            progress < 1
                ? SizedBox(
                    height: 3,
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: kPrimaryColor,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
