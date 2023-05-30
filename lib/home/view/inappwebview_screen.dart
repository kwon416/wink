import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class InAppWebViewScreen extends StatefulWidget {
  const InAppWebViewScreen({Key? key}) : super(key: key);

  @override
  State<InAppWebViewScreen> createState() => _InAppWebViewScreenState();
}

class _InAppWebViewScreenState extends State<InAppWebViewScreen> {
  final GlobalKey webViewKey = GlobalKey();
  Uri myUrl = Uri.parse("https://youtube.com");
  late final InAppWebViewController webViewController;
  late final PullToRefreshController pullToRefreshController;
  double progress = 0;

  InAppWebViewGroupOptions myOptions = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      javaScriptCanOpenWindowsAutomatically: true,
      javaScriptEnabled: true,
      useOnDownloadStart: true,
      useOnLoadResource: true,
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: true,
      allowFileAccessFromFileURLs: true,
      allowUniversalAccessFromFileURLs: true,
      verticalScrollBarEnabled: true,
      userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Safari/537.36',
      // userAgent: 'random'
    ),
    android: AndroidInAppWebViewOptions(
        useHybridComposition: true, //required true
        allowContentAccess: true,
        builtInZoomControls: true,
        thirdPartyCookiesEnabled: true,
        allowFileAccess: true,
        supportMultipleWindows: true
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
      allowsBackForwardNavigationGestures: true,
    ),
  );

  @override
  void initState()  {
    super.initState();

    pullToRefreshController = (kIsWeb
        ? null
        : PullToRefreshController(
      options: PullToRefreshOptions(
        color: grey,
        backgroundColor: Get.theme.colorScheme.primaryContainer
      ),
      onRefresh: () async {
        if (defaultTargetPlatform == TargetPlatform.android) {
          webViewController.reload();
        } else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
          webViewController.loadUrl(urlRequest: URLRequest(url: await webViewController.getUrl()));}
      },
    ))!;
  }

  Future<bool> _goBack(BuildContext context) async{
    if(await webViewController.canGoBack()){
      webViewController.goBack();
      return Future.value(false);
    }else{
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(bottom: false,
        child: WillPopScope(
          onWillPop: () => _goBack(context),
          child: Stack(
            children: [
              InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: myUrl),
                initialOptions: myOptions,
                pullToRefreshController: pullToRefreshController,
                onLoadStart: (InAppWebViewController controller, uri) {
                  setState(() {myUrl = uri!;});
                },
                onLoadStop: (InAppWebViewController controller, uri) {
                  setState(() {myUrl = uri!;});
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {pullToRefreshController.endRefreshing();}
                  setState(() {this.progress = progress / 100;});
                },
                androidOnPermissionRequest: (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                onWebViewCreated: (InAppWebViewController controller) {
                  webViewController = controller;
                },
                onCreateWindow: (controller, createWindowRequest) async{
                  showDialog(
                    context: context, builder: (context) {
                    return AlertDialog(
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                        child: InAppWebView(
                          // Setting the windowId property is important here!
                          windowId: createWindowRequest.windowId,
                          initialOptions: InAppWebViewGroupOptions(
                            android: AndroidInAppWebViewOptions(
                              builtInZoomControls: true,
                              thirdPartyCookiesEnabled: true,
                            ),
                            crossPlatform: InAppWebViewOptions(
                                cacheEnabled: true,
                                javaScriptEnabled: true,
                                userAgent: "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36"
                            ),
                            ios: IOSInAppWebViewOptions(
                              allowsInlineMediaPlayback: true,
                              allowsBackForwardNavigationGestures: true,
                            ),
                          ),
                          onCloseWindow: (controller) async{
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),);
                  },
                  );
                  return true;
                },
              ),
              progress < 1
              ? Container(
                child: LinearProgressIndicator(value: progress, color: colorScheme.primary,),
              )
              : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
