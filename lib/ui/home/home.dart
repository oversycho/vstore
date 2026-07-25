import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vstore/common/utils.dart';
import 'package:vstore/data/product.dart';

import 'package:vstore/data/repo/banner_repository.dart';
import 'package:vstore/data/repo/product_repository.dart';
import 'package:vstore/theme.dart';
import 'package:vstore/ui/home/bloc/home_bloc.dart';
import 'package:vstore/ui/widgets/image.dart';

import 'package:vstore/ui/widgets/slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
          bannerRepository: bannerRepository,
          productRepository: productRepository,
        );
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  itemCount: 7,

                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Container(
                          height: 56,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/img/vstore_logo.png',
                            fit: BoxFit.fitHeight,
                            height: 50,
                          ),
                        );
                      case 2:
                        return BannerSlider(banners: state.banners);
                      case 3:
                        return _HorizontalProductList(
                          title: 'جدید ترین',
                          onTap: () {},
                          product: state.latestProducts,
                        );
                      case 4:
                        return _HorizontalProductList(
                          title: 'پر بازدید ترین',
                          onTap: () {},
                          product: state.latestProducts,
                        );
                      default:
                        return Container();
                    }
                  },
                );
              } else if (state is HomeLoading) {
                return Center(child: CupertinoActivityIndicator());
              } else if (state is HomeError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(state.exception.message),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                      },
                      child: Text('تلاش مجدد'),
                    ),
                  ],
                );
              } else {
                throw Exception(' State is not Supported');
              }
            },
          ),
        ),
      ),
    );
  }
}

class _HorizontalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductEntity> product;
  const _HorizontalProductList({
    required this.title,
    required this.onTap,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              TextButton(onPressed: onTap, child: Text('مشاهده همه')),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            physics: defultScrollPhysics,
            itemCount: product.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 8, right: 8),
            itemBuilder: (context, index) {
              final products = product[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: 176,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 176,
                            height: 189,
                            child: ImageLoadingService(
                              imageUrl: products.imageUrl,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                CupertinoIcons.heart,
                                size: 24,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          products.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          products.previousPrice.withPriceLabel,
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                color: DarkThemeColors.secondaryTextColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(products.price.withPriceLabel),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
