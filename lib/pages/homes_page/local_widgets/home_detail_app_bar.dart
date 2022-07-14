import 'package:admin_picco/model/home_model.dart';
import 'package:admin_picco/pages/homes_page/home_detail_page.dart';
import 'package:admin_picco/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class HomeDetailPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const HomeDetailPageAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    HomeModel home =
        context.findAncestorWidgetOfExactType<HomeDetailPage>()!.home;
    bool filterIsActive =
        context.findAncestorWidgetOfExactType<HomeDetailPage>()!.filterIsActive;
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0.5,
      title: const Text(
        "Статистика",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              if (!filterIsActive)
                PopupMenuItem(
                  child: const Text(
                    "Add home",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    context.read<ProviderHomePage>().updateLoading(true);
                    await FirestoreService.storeHouse(home).then((value) {
                      context.read<ProviderHomePage>().updateLoading(false);
                      Navigator.pop(context);
                    });
                  },
                ),
              const PopupMenuItem(
                child: Text(
                  "Remove home",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ];
          },
        ),
      ],
    );
  }
}
