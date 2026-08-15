import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vstore/common/utils.dart';
import 'package:vstore/data/product.dart';
import 'package:vstore/data/source/cart_data_source.dart';
import 'package:vstore/theme.dart';
import 'package:vstore/ui/product/bloc/product_bloc.dart';
import 'package:vstore/ui/product/comment/comment_list.dart';
import 'package:vstore/ui/widgets/image.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  StreamSubscription<ProductState>? statesubscription;
  final GlobalKey<ScaffoldMessengerState> _scafoldKey = GlobalKey();
  @override
  void dispose() {
    statesubscription?.cancel();
    _scafoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (context) {
          final bloc = ProductBloc(cartReposiorty);
          statesubscription = bloc.stream.listen((state) {
            if (state is ProductAddToCartSuccess) {
              _scafoldKey.currentState?.showSnackBar(
                SnackBar(content: Text(' محصول به سبد خرید اضافه شد ')),
              );
            } else if (state is ProductAddToCartError) {
              _scafoldKey.currentState?.showSnackBar(
                SnackBar(content: Text(state.exception.message)),
              );
            }
          });
          return bloc;
        },
        child: ScaffoldMessenger(
          key: _scafoldKey,
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              width: MediaQuery.of(context).size.width - 70,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return FloatingActionButton.extended(
                    onPressed: () {
                      BlocProvider.of<ProductBloc>(
                        context,
                      ).add(CartAddButtonClick(widget.product.id));
                    },
                    label: state is ProductAddToCartButtonLoading
                        ? CupertinoActivityIndicator(color: Colors.white)
                        : Text('افزودن به سبد خرید'),
                  );
                },
              ),
            ),
            body: CustomScrollView(
              physics: defultScrollPhysics,
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width * 0.8,
                  flexibleSpace: ImageLoadingService(
                    imageUrl: widget.product.imageUrl,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  foregroundColor: LightThemeColors.primaryTextColor,
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.heart),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.title,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge!.copyWith(fontSize: 18),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  widget.product.previousPrice.withPriceLabel,
                                  style: Theme.of(context).textTheme.labelSmall!
                                      .apply(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                                Text(widget.product.price.withPriceLabel),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'بهترین محصولات خارجی در بازار های مد و استایل با واردات مستقیم از کشور مبدا فقط در  ویژن استور  با کمترین قیمت و با ضمانت کامل بازگشت وجه  با پشتیبانی 24 ساعته .  ',
                            style: TextStyle(height: 1.5),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'نظرات کاربران',
                                style: Theme.of(context).textTheme.titleSmall!
                                    .apply(
                                      color: DarkThemeColors.secondaryTextColor,
                                    ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('ثبت نظر'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CommentList(productId: widget.product.id),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
