import 'package:admin_picco/model/user_model.dart';
import 'package:admin_picco/pages/user_page/local_widgets/houses_stream_box.dart';
import 'package:admin_picco/pages/user_page/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'local_widgets/house_title.dart';
import 'local_widgets/houses_header.dart';

class UserDetailPage extends StatelessWidget {
  final UserModel user;

  const UserDetailPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserController(),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
            title: Text(user.fullName ?? "Anonymous"),
          ),
          body: ListView(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            children: const [
              HousesHeaderBox(),
              SizedBox(height: 30.0),
              Divider(),
              SizedBox(height: 20.0),
              Text(
                "Houses",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Text("10 house"),
              SizedBox(height: 20.0),
              HouseTitleBox(),
              HousesStreamBox(),
            ],
          ),
        );
      },
    );
  }
}
