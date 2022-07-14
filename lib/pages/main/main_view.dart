import 'package:admin_picco/pages/main/main_controller.dart';
import 'package:admin_picco/services/const_values.dart';
import 'package:admin_picco/services/log_servcie.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class MainView extends StatelessWidget {
//   const MainView({Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     Log.d("main view");
//     return ChangeNotifierProvider(
//       create: (_) => MainController(),
//       builder: (context, _) {
//         final mainController = context.watch<MainController>();
//         return ColoredBox(
//           color: pageColor,
//           child: SafeArea(
//             child: Scaffold(
//               backgroundColor: pageColor,
//               body: Stack(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: ColoredBox(
//                           color: Colors.white,
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Image.asset("asset/logo.png"),
//                                 ),
//                                 const SizedBox(height: 60.0),
//                                 ControllerButton(
//                                   icon: CupertinoIcons.person,
//                                   index: 0,
//                                   mainController: mainController,
//                                 ),
//                                 const SizedBox(height: 30.0),
//                                 ControllerButton(
//                                   icon: CupertinoIcons.home,
//                                   index: 1,
//                                   mainController: mainController,
//                                 ),
//                                 const Spacer(),
//                                 ControllerButton(
//                                   icon: CupertinoIcons.settings,
//                                   index: 2,
//                                   mainController: mainController,
//                                 ),
//                                 const SizedBox(height: 20.0),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 4,
//                         child: mainController.pages[mainController.indexPage],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class ControllerButton extends StatelessWidget {
//   final IconData icon;
//   final int index;
//   final MainController mainController;
//
//   const ControllerButton({
//     Key? key,
//     required this.icon,
//     required this.index,
//     required this.mainController,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       color:
//           mainController.indexPage != index ? Colors.grey.shade100 : mainColor,
//       padding: const EdgeInsets.all(20.0),
//       onPressed: () => context.read<MainController>().changePage(index),
//       elevation: 0.5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       child: Icon(
//         icon,
//         color: mainController.indexPage == index ? Colors.white : Colors.black,
//       ),
//     );
//   }
// }

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final remoteConfig = FirebaseRemoteConfig.instance;
  final Map<String, dynamic> availableBackgroundColors = {
    "red": Colors.red,
    "yellow": Colors.yellow,
    "blue": Colors.blue,
    "green": Colors.green,
    "white": Colors.white,
  };
  String backgroundColor = "white";

  @override
  initState() {
    super.initState();
    initConfig();
  }

  void initConfig() async {
    Log.i("message");
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 1),
        minimumFetchInterval: const Duration(seconds: 10),
      ),
    );
    Log.i("message1");

    await remoteConfig.setDefaults(const {
      "background_color": "white",
    });
    Log.i("message2");

    fetchConfig();
  }

  void fetchConfig() async {
    await remoteConfig.fetchAndActivate().then((value) => {
          setState(() {
            backgroundColor =
                remoteConfig.getString("background_color").isNotEmpty
                    ? remoteConfig.getString("background_color")
                    : "white";
          }),
          debugPrint(value.toString())
        });
  }

  uiPress() {
    // fetchConfig();
    Log.i(reverse("Jasco"));
  }

  String reverse(String s) {
    var sb = StringBuffer();
    for (var i = s.length-1; i >= 0; i--) {
      sb.writeCharCode(s.codeUnitAt(i));
    }
    return sb.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: availableBackgroundColors[backgroundColor],
      body: Center(child: Text(backgroundColor)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => uiPress(),
      ),
    );
  }
}
