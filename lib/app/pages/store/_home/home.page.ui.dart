import 'package:flutter/material.dart';
import 'package:mercave/app/pages/store/_home/home.controller.dart';
import 'package:mercave/app/pages/store/category/category_detail/category_detail.page.dart';
import 'package:mercave/app/shared/components/headers/address_header/address_header.widget.dart';
import 'package:mercave/app/shared/components/loaders/page_loader/page_loader.widget.dart';
import 'package:mercave/app/shared/components/store/category_grid_list/category_grid_list.widget.dart';
import 'package:mercave/app/shared/components/store/product_image_slider/product_image_slider.widget.dart';
import 'package:mercave/app/shared/components/store/product_principal_slider/product_principal_slider.widget.dart';
import 'package:mercave/app/shared/components/titles/titles.widget.dart';
import 'package:mercave/app/ui/constants.dart';

class HomePageUI {
  final BuildContext context;
  final List<dynamic> recommendedProducts;
  final List<dynamic> productsOnOffered;
  final List<dynamic> categories;
  final List<dynamic> storePremium;
  final List<dynamic> storeStandard;
  final int cartProductsQty;

  final Map? userData;
  final bool userIsLogged;
  final Function onError;
  final Function onProductTapped;
  final Function onCategoryTapped;
  final Function onHeaderTitleTapped;
  final Function onUserIconTapped;
  final Function onSearchIconTapped;
  final Function onCartIconTapped;

  bool loading;
  bool error;

  HomePageUI({
    required this.context,
    required this.recommendedProducts,
    required this.productsOnOffered,
    required this.categories,
    required this.storePremium,
    required this.storeStandard,
    this.userData,
    required this.userIsLogged,
    required this.loading,
    required this.error,
    required this.onError,
    required this.onProductTapped,
    required this.onCategoryTapped,
    required this.onHeaderTitleTapped,
    required this.onUserIconTapped,
    required this.onSearchIconTapped,
    required this.onCartIconTapped,
    required this.cartProductsQty,
  });

  Widget build() {
    if (loading || error) {
      return PageLoaderWidget(
        error: error,
        onError: () async {
          await onError();
        },
      );
    }

    return WillPopScope(
      onWillPop: () async {
        return HomeController().quitApp(context: context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _getAppBar(),
        body: _getBody(),
      ),
    );
  }

  AppBar _getAppBar() {
    String neighborhood = 'Seleccione el barrio';
    String address = 'Ingrese la dirección';

    if (userData != null) {
      if (userData!['neighborhood'] != null &&
          userData!['neighborhood'] != '') {
        neighborhood = userData!['neighborhood'];
      }

      if (userData!['type_of_road'] != null) {
        address = userData!['type_of_road'] +
            ' ' +
            userData!['plate_part_1'] +
            ' # ' +
            userData!['plate_part_2'] +
            ' -' +
            userData!['plate_part_3'];
      }
    }

    return AppBar(
      backgroundColor: Colors.white,
      title: AddressHeaderWidget(
        title: neighborhood,
        subtitle: address,
        userData: userData,
        userIsLogged: userIsLogged,
        onHeaderTitleTapped: onHeaderTitleTapped,
        onUserIconTapped: onUserIconTapped,
        onCartIconTapped: onCartIconTapped,
        onSearchIconTapped: onSearchIconTapped,
        cartProductsQty: cartProductsQty,
        showAnimatedWhatsApp: true,
        enableGoBackButton: false,
      ),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          /* Visibility(
            visible: recommendedProducts.length > 0,
            child: _getPrincipalSliderOfFeaturedProductsWidget(context),
          ),
          _getImageSliderOfProductsOnOfferedWidget(context),*/
          _getGridImageListOfCategoriesWidget(context)
        ],
      ),
    );
  }

  Widget _getPrincipalSliderOfFeaturedProductsWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        TitlesWidget(
          leftTitle: kCustomRecommendedText,
          rightTitle: kCustomViewAllText,
          onRightTitleTapped: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryDetailPage(
                  categoryParam: null,
                  showAllRecommendedProducts: true,
                  showAllOnOfferedProducts: false,
                ),
              ),
            );
          },
        ),
        ProductPrincipalSliderWidget(
          products: recommendedProducts,
          onProductTapped: (product) {
            onProductTapped(product);
          },
        ),
      ],
    );
  }

  Widget _getImageSliderOfProductsOnOfferedWidget(BuildContext context) {
    return Visibility(
      visible: productsOnOffered.length > 0,
      child: Column(
        children: <Widget>[
          TitlesWidget(
            leftTitle: kCustomOnOfferedText,
            rightTitle: kCustomViewAllText,
            onRightTitleTapped: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryDetailPage(
                    categoryParam: null,
                    showAllRecommendedProducts: false,
                    showAllOnOfferedProducts: true,
                  ),
                ),
              );
            },
          ),
          Visibility(
            visible: productsOnOffered.length > 0,
            child: ProductImageSliderWidget(
              products: productsOnOffered,
              onProductTapped: (product) {
                onProductTapped(product);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getGridImageListOfCategoriesWidget(BuildContext context) {
    return Column(children: <Widget>[
      CategoryGridListWidget(
          categories: categories,
          stores:storePremium,
          ratio: 3,
          numberColums: 1,
          onCategoryTapped: (category) {
            onCategoryTapped(category);
          }),
      TitlesWidget(leftTitle: kCustomMarkets),
      CategoryGridListWidget(
          categories: categories,
          stores:storeStandard,
          ratio: 1.5,
          numberColums: 2,
          onCategoryTapped: (category) {
            onCategoryTapped(category);
          })
    ]);
  }
}
