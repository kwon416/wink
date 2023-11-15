import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class InAppWebViewScreen extends StatefulWidget {
  const InAppWebViewScreen({Key? key}) : super(key: key);

  @override
  State<InAppWebViewScreen> createState() => _InAppWebViewScreenState();
}

class _InAppWebViewScreenState extends State<InAppWebViewScreen> {
  final GlobalKey webViewKey = GlobalKey();
  // Uri myUrl = Uri.parse("https://inappwebview.dev/");
  // Uri myUrl = Uri.parse("http://localhost:8080/test");
  Uri myUrl = Uri.parse("https://d1jexlmzhrvawc.cloudfront.net/home");
  late final InAppWebViewController webViewController;
  late final PullToRefreshController pullToRefreshController;
  double progress = 0;

  InAppWebViewGroupOptions myOptions = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      javaScriptCanOpenWindowsAutomatically: true, //자바스크립트가 새창열기 자동 허용
      javaScriptEnabled: true, //자바스크립트 사용 허용
      useOnDownloadStart: true, // 다운로드 시작 이벤트를 처리하는 콜백함수 사용여부
      useOnLoadResource: true, //리소스 로딩을 관리하는 콜백함수 사용여부
      useShouldOverrideUrlLoading: true, //url 로딩을 제어하는 콜백함수 사용여부
      mediaPlaybackRequiresUserGesture: true, // 오디오 또는 비디오 자동재생 불가
      allowFileAccessFromFileURLs: true, //
      allowUniversalAccessFromFileURLs: true,
      verticalScrollBarEnabled: true, //수직 스크롤바 사용
      userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Safari/537.36',
      // userAgent: 'random'
    ),
    android: AndroidInAppWebViewOptions(
        useHybridComposition: true, //required true,
        allowContentAccess: true, //URL 액세스 활성화
        builtInZoomControls: true, //웹뷰 확대&축소 가능
        thirdPartyCookiesEnabled: true,
        allowFileAccess: true,
        supportMultipleWindows: true //onCreateWindow 사용 여부
    ),
    ios: IOSInAppWebViewOptions(
      allowsLinkPreview: false, // 링크 미리보기
      allowsInlineMediaPlayback: true,
      allowsBackForwardNavigationGestures: true,
      automaticallyAdjustsScrollIndicatorInsets: true,
      alwaysBounceVertical: true,
      scrollsToTop: true, //상태바 누르면 맨 위로
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

  Future<bool> _goBack(BuildContext context) async {
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
        title: Text('Main WebView'),
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
                // initialFile: "assets/index.html",
                initialUrlRequest: URLRequest(url: myUrl),
                initialOptions: myOptions,
                pullToRefreshController: pullToRefreshController,
                onLoadStart: (InAppWebViewController controller, uri) {
                  print('onLoadStart: $uri');
                  setState(() {myUrl = uri!;});
                },
                onLoadStop: (controller, uri) async {
                  print('onLoadStop: $uri');
                  pullToRefreshController.endRefreshing();
                  setState(() {myUrl = uri!;});
                },
                onLoadError: (controller, uri, code, message) {
                  print('onLoadError: $uri, code: $code, ErrorMessage: $message');
                  pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {pullToRefreshController.endRefreshing();}
                  setState(() {this.progress = progress / 100;});
                },
                onUpdateVisitedHistory: (controller, uri, androidIsReload) {
                  setState(() {myUrl = uri!;});
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print("[console message]: ${consoleMessage.message}");
                },
                androidOnPermissionRequest: (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var uri = navigationAction.request.url!;

                  if (![ "http", "https", "file", "chrome",
                    "data", "javascript", "about"].contains(uri.scheme)) {
                    if (await canLaunchUrl(myUrl)) {
                      // Launch the App
                      await launchUrl(
                        myUrl,
                      );
                      // and cancel the request
                      return NavigationActionPolicy.CANCEL;
                    }
                  }

                  return NavigationActionPolicy.ALLOW;
                },
                onWebViewCreated: (InAppWebViewController controller) {
                  print('onWebViewCreated: ${controller.runtimeType}');
                  webViewController = controller;
                  //자바스크립트 핸들러 등록
                  webViewController.addJavaScriptHandler(handlerName: 'handlerName', callback: (args) {
                    print(args);
                    var args1 = args.cast<int>();
                    // return {'bar': 'bar_value', 'baz': 'baz_value'};
                    int num = args1.fold(0, (previousValue, element) => previousValue + element);
                    return num;
                  });

                  webViewController.addJavaScriptHandler(
                      handlerName: 'testFunc',
                      callback: (args) {
                        print(args);
                      });

                  webViewController.addJavaScriptHandler(
                      handlerName: 'testFuncArgs',
                      callback: (args) {
                        print(args);
                      });

                  webViewController.addJavaScriptHandler(
                      handlerName: 'testFuncReturn',
                      callback: (args) {
                        print(args);
                        return 'Web Alert from flutter';
                      });

                },
                onCreateWindow: (controller, createWindowAction) async{
                  ///window.open()을 캐치한다. 팝업 또는 새 탭을 처리할 때 사용
                  print("onCreateWindow: $createWindowAction");
                  ///메소드 분리해서 재귀적으로 쓸 일이 있을까?
                  ///새창 위에 새창 위에 새창 ....
                  showGeneralDialog(
                      context: context,
                      pageBuilder: (context,_,__) {

                        return Scaffold(
                          appBar: AppBar(
                            title: Text('PopUp Window id: ${createWindowAction.windowId}'),
                            backgroundColor: colorScheme.primaryContainer,
                            leading: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                          body: InAppWebView(
                            // Setting the windowId property is important here!
                            windowId: createWindowAction.windowId,
                            initialOptions: myOptions,
                            // pullToRefreshController: PullToRefreshController(),
                            onWebViewCreated: (controller) {},
                            onConsoleMessage: (controller, consoleMessage) {
                              print('[console message] from new window: ${consoleMessage.message}');
                            },
                            onLoadStart: (controller, url) {
                              print("onLoadStart popup $url");
                            },
                            onLoadStop: (controller, url) {
                              print("onLoadStop popup $url");
                            },
                            onCloseWindow: (controller) async{
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },

                          ),
                        );
                      }
                  );
                  return true;
                },
              ),
              progress < 1
              ? LinearProgressIndicator(value: progress, color: colorScheme.primary,)
              : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
