import 'package:admin_picco/model/home_model.dart';
import 'package:admin_picco/model/user_model.dart';
import 'package:admin_picco/pages/user_page/user_controller.dart';
import 'package:admin_picco/pages/user_page/user_detail_page.dart';
import 'package:admin_picco/services/const_values.dart';
import 'package:admin_picco/services/data_service.dart';
import 'package:admin_picco/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class HousesStreamBox extends StatelessWidget {
  const HousesStreamBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user =
        context.findAncestorWidgetOfExactType<UserDetailPage>()!.user;
    var selectIndex =
        context.select((UserController value) => value.selectTitleHouse);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(FirestoreService.usersFolder)
          .doc(user.id)
          .collection(FirestoreService.homesFolder)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.only(top: heightMax(context) * 0.2),
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.data!.docs.isEmpty) {
          return _emptyHomeBody(context);
        }
        Logger().w(snapshot.data!.docs.toString());
        return selectIndex == 0 || selectIndex == 1
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                padding: const EdgeInsets.only(top: 15),
                itemBuilder: (context, index) {
                  HomeModel home = HomeModel.fromJson(snapshot.data!.docs[index]
                      .data() as Map<String, dynamic>);
                  return HouseBox(home: home);
                },
              )
            : _emptyHomeBody(context);
      },
    );
  }

  Container _emptyHomeBody(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: heightMax(context) * 0.07,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade50,
      ),
      height: heightMax(context) * 0.35,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "asset/images/empty_homes.png",
            height: heightMax(context) * 0.1,
            width: widthMax(context) * 0.1,
          ),
          const Text(
            "Объявления пока нет",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class HouseBox extends StatelessWidget {
  final HomeModel home;

  const HouseBox({Key? key, required this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 5,
      ),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //leading
          Expanded(
            flex: 1,
            child: Container(
              height: 80,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: home.houseImages.first,
                placeholder: (context, url) =>
                    const ColoredBox(color: Color(0x999f9f9f)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          home.city,
                          style: const TextStyle(
                            fontSize: 17,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        "\$${home.price}",
                        style: const TextStyle(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  Text(
                    home.district,
                    style: const TextStyle(
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "Улица ${home.street}",
                    style: const TextStyle(
                      fontSize: 11,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${home.bathCount} baths",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          "${home.bathCount} bath",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          "${home.roomsCount} rooms",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${home.houseArea} m',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 6,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).putTap(
      () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => SellerDetailPage(element: element)),
        // );
      },
    );
  }
}
