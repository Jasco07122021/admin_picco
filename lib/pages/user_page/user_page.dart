import 'package:admin_picco/model/user_model.dart';
import 'package:admin_picco/pages/user_page/user_detail_page.dart';
import 'package:admin_picco/services/const_values.dart';
import 'package:admin_picco/services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      children: [
        const Text(
          "Users",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        TextField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            hintText: "Search",
            isCollapsed: true,
            prefixIcon: const Icon(CupertinoIcons.search),
          ),
        ),
        const SizedBox(height: 20),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirestoreService.usersFolder)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  for (int i = 0; i < snapshot.data!.docs.length; i++)
                    BoxUser(
                      index: i,
                      json:
                          snapshot.data!.docs[i].data() as Map<String, dynamic>,
                      isLast: i == snapshot.data!.docs.length - 1,
                    )
                ],
              );
            }
            return const LinearProgressIndicator();
          },
        ),
      ],
    );
  }
}

class BoxUser extends StatelessWidget {
  final int index;
  final Map<String, dynamic> json;
  final bool isLast;

  const BoxUser({
    Key? key,
    required this.index,
    required this.json,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user = UserModel.fromJson(json);
    return ListTile(
      tileColor: Colors.white,
      leading: CircleAvatar(
        backgroundColor: mainColor,
        child: Text(user.fullName?[0] ?? "A"),
      ),
      title: Text(user.fullName ?? "Anonymous"),
      subtitle: Text(user.phoneNumber ?? ""),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: index == 0 ? const Radius.circular(15.0) : Radius.zero,
          bottom: index == -1 ? const Radius.circular(15.0) : Radius.zero,
        ),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailPage(user: user),
          ),
        );
      },
    );
  }
}
