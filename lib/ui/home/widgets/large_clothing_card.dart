import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talent_clothing/core/constants/app_colors.dart';

class LargeClothingCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final bool isFav;
  final Function onFavPressed;

  LargeClothingCard(
      {required this.image, required this.name, required this.price, required this.isFav, required this.onFavPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.4,
      height: size.height * 0.4,
      // color: Colors.red,
      margin: EdgeInsets.only(top: 12, bottom: 12, left: 12),
      child: Column(
        children: [
          Expanded(
            // child: Stack(
            //   children: [
            //     Align(
            //       alignment: Alignment.topRight,
            //       child: GestureDetector(
            //           onTap: () {
            //             onFavPressed();
            //           },
            //           child: Padding(
            //             padding: const EdgeInsets.all(16.0),
            //             child: SvgPicture.asset(
            //               isFav ? 'assets/images/heart_active.svg' : 'assets/images/heart_inactive.svg',
            //               color: isFav ? AppColors.makeup : AppColors.black,
            //               width: 24,
            //             ),
            //           )),
            //     )
            //   ],
            // ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                      onTap: () {
                        onFavPressed();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          isFav ? 'assets/images/heart_active.svg' : 'assets/images/heart_inactive.svg',
                          color: isFav ? AppColors.makeup : AppColors.black,
                          width: 20,
                        ),
                      )),
                )
              ],
            ),
            // child: Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(20)),
            //     image: DecorationImage(
            //       image: NetworkImage(image),
            //     )
            //   ),
            // ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(color: AppColors.darkGrey),
                ),
                SizedBox(height: 8),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: '\$ ', style: TextStyle(color: AppColors.makeup)),
                  TextSpan(text: price, style: TextStyle(color: AppColors.black)),
                ]))
              ],
            ),
          )
        ],
      ),
    );
  }
}
