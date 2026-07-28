import 'package:vstore/common/http_client.dart';
import 'package:vstore/data/comment.dart';
import 'package:vstore/data/source/comment_data_source.dart';

final commentRepository = CommentRepository(
  CommentRemoteDataSource(httpClient),
);

abstract class ICommentRepository {
  Future<List<CommentEntity>> getComments({required int productId});
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository(this.dataSource);
  @override
  Future<List<CommentEntity>> getComments({required int productId}) {
    return dataSource.getComments(productID: productId);
  }
}
