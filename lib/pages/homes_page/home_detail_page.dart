import 'package:admin_picco/model/home_model.dart';
import 'package:admin_picco/model/house_extra_model.dart';
import 'package:admin_picco/pages/homes_page/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'local_widgets/home_detail_app_bar.dart';

class HomeDetailPage extends StatelessWidget {
  final HomeModel home;
  final bool filterIsActive;

  const HomeDetailPage(
      {Key? key, required this.home, required this.filterIsActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProviderHomePage(),
      builder: (context, _) => Scaffold(
        appBar: const HomeDetailPageAppBar(),
        body: Stack(
          children: [
            Selector(
              selector: (context, ProviderHomePage provider) =>
                  provider.isLoading,
              builder: (context, bool value, _) => value
                  ? const LinearProgressIndicator()
                  : const SizedBox.shrink(),
            ),
            ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              children: [
                ///main fields
                text(title: "City: ", text: home.city),
                text(title: "District: ", text: home.district),
                text(title: "Street: ", text: home.street),
                text(title: "Price: ", text: "\$${home.price}"),
                text(title: "Definition: ", text: home.definition),
                text(title: "Rooms Count: ", text: home.roomsCount),
                text(title: "Beds Count: ", text: home.bedsCount),
                text(title: "Bath Count: ", text: home.bathCount),
                text(title: "House Area: ", text: home.houseArea),
                text(title: "Pushed Date: ", text: home.pushedDate),
                text(title: "Sell type: ", text: home.sellType),

                ///images
                SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    itemBuilder: (context, index) => boxHouseImages(
                      home.houseImages[index],
                    ),
                  ),
                ),

                ///facility
                for (int i = 0; i < home.houseFacilities.length; i++)
                  textFacility(home.houseFacilities[i], i),

                ///extra fields
                text(title: "All Views: ", text: "${home.allViews}"),
                text(title: "SMS Count: ", text: "${home.smsCount}"),
                text(title: "Calls Count: ", text: "${home.callsCount}"),
                text(title: "Deep link: ", text: home.deepLink!),
                text(title: "Id: ", text: home.id!),
                text(title: "UserId: ", text: home.userId),
                // text(title: "UserId: ", text: home.),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget textFacility(bool isTrue, int index) {
    if (isTrue) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Text(
          HouseExtraModel.facilities[index],
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Padding text({required String title, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RichText(
        text: TextSpan(
          text: title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          children: [
            TextSpan(
              text: text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card boxHouseImages(String image) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 200.0,
        child: Image.network(
          image,
          fit: BoxFit.cover,
          loadingBuilder: (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}

