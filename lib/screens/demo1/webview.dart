import 'package:chat_gpt_demo/screens/demo1/gpt_demo.dart';
import 'package:chat_gpt_demo/screens/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {
  const Webview({super.key});
  @override
  State<StatefulWidget> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  final cookieManager = WebviewCookieManager();

  @override
  void initState() {
    super.initState();
    // cookieManager.clearCookies();
  }

  void _handleLoad(String value) async {
    final gotCookies = await cookieManager.getCookies(chatUrl);
    String sessionToken = "";
    String clearToken = "";

    //Get sessionToken and clearToken from web cookie
    for (var item in gotCookies) {
      if (item.name == "__Secure-next-auth.session-token") {
        sessionToken = item.value;
      }
      if (item.name == "cf_clearance") {
        clearToken = item.value;
      }
    }
    if (sessionToken.isNotEmpty && clearToken.isNotEmpty) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => GptChatDemo(
                sessionToken: sessionToken,
                clearToken: clearToken,
              )));
    }
  }

  Widget _webView() {
    return SizedBox(
        height: MediaQuery.of(context).size.height - 60,
        child: WebView(
          userAgent: 'random',
          initialUrl: chatUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {},
          onPageFinished: _handleLoad,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _webView());
  }
}
