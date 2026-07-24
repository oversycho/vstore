import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vstore/data/repo/banner_repository.dart';
import 'package:vstore/data/repo/product_repository.dart';
import 'package:vstore/ui/home/bloc/home_bloc.dart';

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
