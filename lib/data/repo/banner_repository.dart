import 'package:vstore/common/http_client.dart';
import 'package:vstore/data/banner.dart';
import 'package:vstore/data/source/banner_data_source.dart';

final bannerRepository = BannerRepository(
  BannerRemoteDataSource(httpClient: httpClient),
);

abstract class IBannerRepository {
  Future<List<BannerEntity>> getBanners();
}

class BannerRepository implements IBannerRepository {
  final IBannerDataSource dataSource;
  BannerRepository(this.dataSource);
  @override
  Future<List<BannerEntity>> getBanners() {
    return dataSource.getBanners();
  }
}
