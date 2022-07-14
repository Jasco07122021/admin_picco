import 'package:admin_picco/model/user_model.dart';
import 'package:admin_picco/pages/user_page/user_detail_page.dart';
import 'package:admin_picco/services/const_values.dart';
import 'package:flutter/material.dart';

class HousesHeaderBox extends StatelessWidget {
  const HousesHeaderBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user =
        context.findAncestorWidgetOfExactType<UserDetailPage>()!.user;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          backgroundColor: mainColor,
          radius: 50,
          child: Text(
            user.fullName?[0] ?? "A",
            style: const TextStyle(fontSize: 26.0),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _textHeader(
              text: user.fullName,
              emptyText: "Anonymous",
              isGrey: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _textHeader(
                text: user.email,
                emptyText: "Email is Empty",
                isGrey: true,
              ),
            ),
            _textHeader(
              text: user.phoneNumber,
              emptyText: "",
              isGrey: true,
            ),
          ],
        ),
      ],
    );
  }

  Text _textHeader({
    required String? text,
    required String emptyText,
    required bool isGrey,
  }) {
    return Text(
      text ?? emptyText,
      style: TextStyle(
        fontSize: !isGrey ? 18.0 : 14.0,
        fontWeight: FontWeight.w500,
        color: isGrey ? Colors.grey : Colors.black,
      ),
    );
  }
}
