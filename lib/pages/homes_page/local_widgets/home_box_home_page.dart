import 'package:admin_picco/model/home_model.dart';
import 'package:admin_picco/pages/homes_page/home_detail_page.dart';
import 'package:admin_picco/pages/homes_page/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomesBoxHomePage extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isFirst;
  final bool isLast;

  const HomesBoxHomePage({
    Key? key,
    required this.item,
    required this.isFirst,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = HomeModel.fromJson(item);
    bool filterIsActive =
        context.select((ProviderHomePage value) => value.filterName) ==
            "Active";
    return ListTile(
      tileColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(homeModel.houseImages[0]),
      ),
      title: Row(
        children: [
          Expanded(child: Text(homeModel.city)),
          Text("\$${homeModel.price}"),
        ],
      ),
      subtitle: Text(homeModel.street),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(15.0) : Radius.zero,
          bottom: isLast ? const Radius.circular(15.0) : Radius.zero,
        ),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeDetailPage(
              home: homeModel,
              filterIsActive: filterIsActive,
            ),
          ),
        );
      },
    );
  }
}
