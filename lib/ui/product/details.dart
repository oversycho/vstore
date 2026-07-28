import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vstore/common/utils.dart';
import 'package:vstore/data/product.dart';
import 'package:vstore/theme.dart';
import 'package:vstore/ui/product/comment/comment_list.dart';
import 'package:vstore/ui/widgets/image.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 70,
          child: FloatingActionButton.extended(
            onPressed: () {},
            label: Text('افزودن به سبد خرید'),
          ),
        ),
        body: CustomScrollView(
          physics: defultScrollPhysics,
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              flexibleSpace: ImageLoadingService(
                imageUrl: product.imageUrl,
                borderRadius: BorderRadius.circular(24),
              ),
              foregroundColor: LightThemeColors.primaryTextColor,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.heart)),
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
                            product.title,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(fontSize: 18),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              product.previousPrice.withPriceLabel,
                              style: Theme.of(context).textTheme.labelSmall!
                                  .apply(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                            Text(product.price.withPriceLabel),
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
                          TextButton(onPressed: () {}, child: Text('ثبت نظر')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CommentList(productId: product.id),
          ],
        ),
      ),
    );
  }
}
