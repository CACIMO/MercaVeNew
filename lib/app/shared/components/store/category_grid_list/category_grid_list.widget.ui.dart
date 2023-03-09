import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mercave/app/shared/utils/string/string.service.dart';

import '../../../../ui/constants.dart';

class CategoryGridListWidgetUI {
  final BuildContext context;
  final int numberColums;
  final double ratio;
  final List<dynamic> categories;
  final List<dynamic> stores;
  final Function onCategoryTapped;

  late double screenWidth;
  late double horizontalPadding;

  CategoryGridListWidgetUI({
    required this.context,
    required this.numberColums,
    required this.ratio,
    required this.categories,
    required this.stores,
    required this.onCategoryTapped,
  }) {
    _setDimensions();
  }

  void _setDimensions() {
    double viewportFraction = 0.9;
    screenWidth = MediaQuery.of(context).size.width;
    horizontalPadding = (screenWidth - screenWidth * viewportFraction) / 2;
  }

  Color? _convertColor(String? color) {
    color = color!.replaceAll("#", "");
    if (color.length == 6) {
      color = "FF$color";
    }
    if (color.length == 8) {
      return Color(int.parse("0x$color"));
    }
  }

  Widget build() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: _getGridViewWidget(),
      ),
    );
  }

  Widget _getGridViewWidget() {
    return GridView.count(
      crossAxisCount: numberColums,
      childAspectRatio: ratio,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: stores.map((store) {
        return Builder(builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              onCategoryTapped(store);
            },
            child: _getBackgroundImageDecoration(category: store),
          );
        });
      }).toList(),
    );
  }

  Widget _getBackgroundImageDecoration({Map? category}) {
    return Material(
        elevation: 5,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Container(
            decoration: BoxDecoration(
                color: _convertColor(category!["color_background"]),
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
            child: category["premium"] == "1"
                ? _getPremiumButonWidget(category: category)
                : _getStandardButonWidget(category: category)));
    /*CachedNetworkImage(
      imageUrl: category!['principal_image'],
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: _getCenterTextWidget(category: category),
      ),
      placeholder: (context, url) => Image.asset(kCustomPlaceholderCategory),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );*/
  }

  Widget _getPremiumButonWidget({Map? category}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(children: [
                Expanded(
                    flex: 2,
                    child: CachedNetworkImage(
                      width: 100,
                      height: 100,
                      imageUrl: category!["icono"],
                      placeholder: (context, url) =>
                          Image.asset(kCustomPlaceholderCategory),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )),
                Expanded(
                    flex: 8,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                            StringService.capitalize(
                                category!["dokan_data"]["store_name"]),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.white))))
              ]))
        ]);
  }

  Widget _getStandardButonWidget({Map? category}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CachedNetworkImage(
            width: 50,
            height: 50,
            imageUrl: category!["icono"],
            placeholder: (context, url) =>
                Image.asset(kCustomPlaceholderCategory),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Text(StringService.capitalize(category!["dokan_data"]["store_name"]),
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 15.0, color: Colors.white))
        ]);
  }
}
