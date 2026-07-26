import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vstore/common/utils.dart';
import 'package:vstore/data/product.dart';
import 'package:vstore/theme.dart';
import 'package:vstore/ui/product/details.dart';
import 'package:vstore/ui/widgets/image.dart';

class Productitem extends StatelessWidget {
  const Productitem({
    super.key,
    required this.products,
    required this.borderRadius,
  });

  final ProductEntity products;
  final BorderRadius borderRadius;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => ProductDetailsScreen(product: products),
          ),
        ),
        child: SizedBox(
          width: 176,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 176,
                    height: 189,
                    child: ImageLoadingService(
                      imageUrl: products.imageUrl,
                      borderRadius: borderRadius,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        CupertinoIcons.heart,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  products.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  products.previousPrice.withPriceLabel,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: DarkThemeColors.secondaryTextColor,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(products.price.withPriceLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
