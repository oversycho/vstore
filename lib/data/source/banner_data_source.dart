import 'package:dio/dio.dart';
import 'package:vstore/data/banner.dart';
import 'package:vstore/data/common/http_response_validator.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getBanners();
}

class BannerRemoteDataSource
    with HttpResponseValidator
    implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource({required this.httpClient});
  @override
  Future<List<BannerEntity>> getBanners() async {
    final response = await httpClient.get('banners');
    validateResponse(response);
    final List<BannerEntity> banners = [];
    // ignore: avoid_function_literals_in_foreach_calls
    (response.data as List).forEach((jsonObject) {
      banners.add(BannerEntity.fromJson(jsonObject));
    });
    return banners;
  }
}
