import 'package:admin_picco/pages/homes_page/provider.dart';
import 'package:admin_picco/services/const_values.dart';
import 'package:admin_picco/services/data_service.dart';
import 'package:admin_picco/services/log_servcie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'local_widgets/home_box_home_page.dart';

class HomesPage extends StatelessWidget {
  const HomesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProviderHomePage(),
      builder: (context, _) {
        Log.i("home page");
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          children: [
            const Text(
              "Homes",
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: const [
                  HouseFilter(text: "Active"),
                  HouseFilter(text: "Waiting"),
                ],
              ),
            ),
            Selector(
              selector: (context, ProviderHomePage providerHomePage) =>
                  providerHomePage.filterName,
              builder: (BuildContext context, String value, _) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(
                        value == "Active"
                            ? FirestoreService.homesFolder
                            : FirestoreService.adminFolder,
                      )
                      .doc("buy_houses")
                      .collection("house")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                    if (snapshots.hasData) {
                      return Column(
                        children: [
                          for (int i = 0; i < snapshots.data!.docs.length; i++)
                            HomesBoxHomePage(
                              item: snapshots.data!.docs[i].data()
                                  as Map<String, dynamic>,
                              isFirst: i == 0,
                              isLast: i == snapshots.data!.docs.length - 1,
                            ),
                        ],
                      );
                    }
                    return const LinearProgressIndicator();
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class HouseFilter extends StatelessWidget {
  final String text;

  const HouseFilter({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector(
      selector: (context, ProviderHomePage providerHomePage) =>
          providerHomePage.filterName,
      builder: (BuildContext context, String value, _) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<ProviderHomePage>().updateHomeFilter(text);
            },
            child: Container(
              alignment: Alignment.center,
              height: 35.0,
              decoration: BoxDecoration(
                color: value == text ? mainColor : Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: value == text ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
