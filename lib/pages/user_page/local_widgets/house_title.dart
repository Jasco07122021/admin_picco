import 'package:admin_picco/model/house_extra_model.dart';
import 'package:admin_picco/pages/user_page/user_controller.dart';
import 'package:admin_picco/services/const_values.dart';
import 'package:admin_picco/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HouseTitleBox extends StatelessWidget {
  const HouseTitleBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.0,
      child: ListView.builder(
        itemCount: HouseExtraModel.titles.length + 1,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => HousesTitle(index: index),
      ),
    );
  }
}

class HousesTitle extends StatelessWidget {
  final int index;

  const HousesTitle({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectIndex =
        context.select((UserController value) => value.selectTitleHouse);
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        backgroundColor: selectIndex == index ? mainColor : pageColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        label: Text(
          index == 0 ? "Все" : HouseExtraModel.titles[index - 1],
          style: TextStyle(
            color: selectIndex == index ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ).putTap(() {
        context.read<UserController>().updateTitleHouseIndex(index);
      }),
    );
  }
}
