import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vstore/data/banner.dart';
import 'package:vstore/ui/widgets/image.dart';

class BannerSlider extends StatelessWidget {
  final PageController _controller = PageController();
  final List<BannerEntity> banners;
  BannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            itemBuilder: (context, index) => _Slide(banner: banners[index]),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: banners.length,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                  spacing: 4.0,
                  radius: 4.0,
                  dotWidth: 20.0,
                  dotHeight: 5.0,
                  paintStyle: PaintingStyle.fill,
                  strokeWidth: 1.5,
                  dotColor: const Color.fromARGB(255, 150, 147, 147),
                  activeDotColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final BannerEntity banner;
  const _Slide({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 12, right: 12),
      child: ImageLoadingService(
        imageUrl: banner.imageUrl,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}
