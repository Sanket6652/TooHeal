// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:faker/faker.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tooheal/constant/global_constant.dart';
import 'package:tooheal/services/login_service.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// Project imports:

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController singleInviteeUserIDTextCtrl =
      TextEditingController();
  final TextEditingController groupInviteeUserIDsTextCtrl =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Your Phone Number: ${currentUser.id}'),
                  logoutButton(),
                ],
              ),
              call(),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutButton() {
    return Ink(
      width: 35,
      height: 35,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.redAccent,
      ),
      child: IconButton(
        icon: const Icon(Icons.exit_to_app_sharp),
        iconSize: 20,
        color: Colors.white,
        onPressed: () {
          logout().then((value) {
            onUserLogout();

            Navigator.pushNamed(
              context,
              PageRouteNames.login,
            );
          });
        },
      ),
    );
  }

  Widget call() {
    late TextEditingController inviteeUsersIDTextCtrl;
    
    final List<Map<String, dynamic>> userData = [
      {
        "id": 918,
        "username": "Sakshi divedi",
        "small_description": "peer pressure",
        "description":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
        "call_charges": "10"
      },
      {
        "id": 123,
        "username": "Nikhil Gupta",
        "small_description": "Loneliness",
        "description":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
        "call_charges": "10"
      },
      {
        "id": 456,
        "username": "Sakshi divedi",
        "small_description": "peer pressure",
        "description":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
        "call_charges": "10"
      }
    ];
    

    return Center(
      child: ListView.builder(
        itemCount: userData.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(),
                      Column(
                        children: [
                          Text(userData[index]["username"]),
                          Text(userData[index]["small_description"]),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      sendCallButton(
                        isVideoCall: false,
                        inviteeUsersIDTextCtrl: userData[index]["id"].toString(),
                        onCallFinished: onSendCallInvitationFinished,
                      ),
                      sendCallButton(
                        isVideoCall: true,
                        inviteeUsersIDTextCtrl: userData[index]["id"].toString(),
                        onCallFinished: onSendCallInvitationFinished,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
    // return Column(
    //   children: [
    //     Row(
    //       children: [
    //         const SizedBox(width: 20),
    //         ...userInfo,
    //         Expanded(child: Container()),
    // sendCallButton(
    //   isVideoCall: false,
    //   inviteeUsersIDTextCtrl: inviteeUsersIDTextCtrl,
    //   onCallFinished: onSendCallInvitationFinished,
    // ),
    // sendCallButton(
    //   isVideoCall: true,
    //   inviteeUsersIDTextCtrl: inviteeUsersIDTextCtrl,
    //   onCallFinished: onSendCallInvitationFinished,
    // ),
    //     const SizedBox(width: 20),
    //   ],
    // ),
    //     const Padding(
    //       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
    //       child: Divider(height: 1.0, color: Colors.grey),
    //     ),
    //   ],
    // );
  }

  void onSendCallInvitationFinished(
    String code,
    String message,
    List<String> errorInvitees,
  ) {
    if (errorInvitees.isNotEmpty) {
      var userIDs = '';
      for (var index = 0; index < errorInvitees.length; index++) {
        if (index >= 5) {
          userIDs += '... ';
          break;
        }

        final userID = errorInvitees.elementAt(index);
        userIDs += '$userID ';
      }
      if (userIDs.isNotEmpty) {
        userIDs = userIDs.substring(0, userIDs.length - 1);
      }

      var message = "User doesn't exist or is offline: $userIDs";
      if (code.isNotEmpty) {
        message += ', code: $code, message:$message';
      }
      showToast(
        message,
        position: StyledToastPosition.top,
        context: context,
      );
    } else if (code.isNotEmpty) {
      showToast(
        'code: $code, message:$message',
        position: StyledToastPosition.top,
        context: context,
      );
    }
  }
}

Widget inviteeIDFormField({
  required TextEditingController textCtrl,
  List<TextInputFormatter>? formatters,
  String hintText = '',
  String labelText = '',
}) {
  const textStyle = TextStyle(fontSize: 12.0);
  return Expanded(
    flex: 100,
    child: SizedBox(
      height: 30,
      child: TextFormField(
        style: textStyle,
        controller: textCtrl,
        inputFormatters: formatters,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: textStyle,
          labelText: labelText,
          labelStyle: textStyle,
          border: const OutlineInputBorder(),
        ),
      ),
    ),
  );
}

Widget sendCallButton({
  required bool isVideoCall,
  required String inviteeUsersIDTextCtrl,
  void Function(String code, String message, List<String>)? onCallFinished,
}) {
  
     final invitees =
          getInvitesFromTextCtrl(inviteeUsersIDTextCtrl);
      return ZegoSendCallInvitationButton(
        isVideoCall: isVideoCall,
        invitees: invitees,
        resourceID: 'zego_data',
        iconSize: const Size(40, 40),
        buttonSize: const Size(50, 50),
        onPressed: onCallFinished,
      );
   
}

List<ZegoUIKitUser> getInvitesFromTextCtrl(String textCtrlText) {
  final invitees = <ZegoUIKitUser>[];

  final inviteeIDs = textCtrlText.trim().replaceAll('，', '');
  inviteeIDs.split(',').forEach((inviteeUserID) {
    if (inviteeUserID.isEmpty) {
      return;
    }

    invitees.add(ZegoUIKitUser(
      id: inviteeUserID,
      name: 'user_$inviteeUserID',
    ));
  });

  return invitees;
}
