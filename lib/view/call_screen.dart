import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class PrebuiltCallPage extends StatefulWidget {
  const PrebuiltCallPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PrebuiltCallPageState();
}

class PrebuiltCallPageState extends State<PrebuiltCallPage> {
  // ignore: prefer_typing_uninitialized_variables
  //var id='33';
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getUniqueUserId().then((value) {
  //     setState(() {
  //       id = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return
        //  id == null
        //     ? const Scaffold(
        //         body: Center(child: CircularProgressIndicator.adaptive()),
        //       )
        //     :
        SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 2118224311,
        appSign:
            'e5d1afded9bec734ef78ac272583ceae5bdeaed6273c0e25c02a35917629829b',

        userID: "12",

        userName: "d",
        callID: "234",
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
        // config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        //   ..onOnlySelfInRoom = (context) {
        //     Navigator.of(context).pop();
        //   },
      ),
    );
  }
}
