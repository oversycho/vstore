import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vstore/data/repo/comment_repository.dart';

import 'package:vstore/ui/product/comment/bloc/comment_list_bloc.dart';
import 'package:vstore/ui/product/comment/comment.dart';
import 'package:vstore/ui/widgets/error.dart';

class CommentList extends StatelessWidget {
  final int productId;

  const CommentList({super.key, required this.productId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommentListBloc bloc = CommentListBloc(
          repository: commentRepository,
          productId: productId,
        );
        bloc.add(CommentListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentListSuccess) {
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return commentItem(data: state.comments[index]);
              }, childCount: state.comments.length),
            );
          } else if (state is CommentListLoading) {
            return SliverToBoxAdapter(
              child: const Center(child: CupertinoActivityIndicator()),
            );
          } else if (state is CommentListError) {
            return SliverToBoxAdapter(
              child: AppErrorrWidget(
                exception: state.exception,
                onPressed: () {
                  BlocProvider.of<CommentListBloc>(
                    context,
                  ).add(CommentListStarted());
                },
              ),
            );
          } else {
            throw Exception('state is not supported');
          }
        },
      ),
    );
  }
}
