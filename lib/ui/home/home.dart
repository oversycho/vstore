import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vstore/common/utils.dart';
import 'package:vstore/data/product.dart';
import 'package:vstore/data/repo/banner_repository.dart';
import 'package:vstore/data/repo/product_repository.dart';
import 'package:vstore/ui/home/bloc/home_bloc.dart';
import 'package:vstore/ui/product/product.dart';
import 'package:vstore/ui/widgets/error.dart';
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
                  physics: defultScrollPhysics,
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
                return AppErrorrWidget(
                  exception: state.exception,
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                  },
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
              return Productitem(
                products: products,
                borderRadius: BorderRadius.circular(15),
              );
            },
          ),
        ),
      ],
    );
  }
}
