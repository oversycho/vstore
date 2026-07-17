import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vstore/common/exception.dart';
import 'package:vstore/data/banner.dart';
import 'package:vstore/data/product.dart';
import 'package:vstore/data/repo/banner_repository.dart';
import 'package:vstore/data/repo/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository;
  final IProductRepository productRepository;
  HomeBloc({required this.bannerRepository, required this.productRepository})
    : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        try {
          emit(HomeLoading());
          final banners = await bannerRepository.getBanners();
          final latestProducts = await productRepository.getProducts(
            ProductSort.latest,
          );
          final popularProducts = await productRepository.getProducts(
            ProductSort.popular,
          );
          emit(
            HomeSuccess(
              banners: banners,
              latestProducts: latestProducts,
              popularProducts: popularProducts,
            ),
          );
        } catch (e) {
          emit(
            HomeError(
              exception: e is AppException
                  ? e
                  : AppException(message: 'خطایی رخ داده مجددا نلاش کنید'),
            ),
          );
        }
      }
    });
  }
}
