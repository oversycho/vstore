import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vstore/data/repo/banner_repository.dart';
import 'package:vstore/data/repo/product_repository.dart';
import 'package:vstore/ui/home/bloc/home_bloc.dart';

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
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 100),
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Image.asset(
                          'assets/img/vstore_logo.png',
                          height: 65,
                        );
                      case 1:
                        return Container();
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
