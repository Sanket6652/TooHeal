import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tooheal/constant/global_constant.dart';
import 'package:tooheal/services/login_service.dart';
import 'package:tooheal/view/home_screen.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
final navigatorKey = GlobalKey();
Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();

  /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
   final prefs = await SharedPreferences.getInstance();
  final cacheUserID = prefs.get(cacheUserIDKey) as String? ?? '';
  if (cacheUserID.isNotEmpty) {
    currentUser.id = cacheUserID;
    currentUser.name = 'user_$cacheUserID';
  }

  /// 1/5: define a navigator key
  final navigatorKey = GlobalKey<NavigatorState>();

  /// 2/5: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MyApp(navigatorKey: navigatorKey));
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    if (currentUser.id.isNotEmpty) {
      onUserLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      initialRoute:
          currentUser.id.isEmpty ? PageRouteNames.login : PageRouteNames.home,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),

      /// 3/5: register the navigator key to MaterialApp
      navigatorKey: widget.navigatorKey,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            child!,

            /// support minimizing
            ZegoUIKitPrebuiltCallMiniOverlayPage(
              contextQuery: () {
                return widget.navigatorKey.currentState!.context;
              },
            ),
          ],
        );
      },
    );
  }
}
