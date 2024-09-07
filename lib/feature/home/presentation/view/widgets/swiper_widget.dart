import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/app_colors.dart';
import 'package:grocery_app/core/utils/constants.dart';

class SwiperWidget extends StatelessWidget {
  SwiperWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenhight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenhight * .22,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              Constants.offerImageList[index],
              fit: BoxFit.fill,
            );
          },
          autoplay: true,
          itemCount: Constants.offerImageList.length,
          pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                  color: Colors.white, activeColor: AppColors.green)),
        ),
      ),
    );
  }
}
