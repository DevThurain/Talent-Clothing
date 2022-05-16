import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talent_clothing/ui/home/widgets/category_chip.dart';

class AppBarSection extends StatefulWidget {
  final bool enoughSpace;
  final ScrollController scrollController;

  AppBarSection({required this.enoughSpace, required this.scrollController});

  @override
  State<AppBarSection> createState() => _AppBarSectionState();
}

class _AppBarSectionState extends State<AppBarSection> {
  final List<String> categoryList = ['All', 'Winter', 'Women', 'Shorts'];
  String selectedCategory = 'All';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SliverAppBar(
      collapsedHeight: 100,
      expandedHeight: 150,
      elevation: 0,
      backgroundColor: Colors.white,
      pinned: true,
      stretch: true,
      flexibleSpace: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/home_menu.svg',
                    width: 24,
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    'assets/images/home_search.svg',
                    width: 24,
                  ),
                  SizedBox(width: 24),
                  SvgPicture.asset(
                    'assets/images/home_cart.svg',
                    width: 24,
                  ),
                ],
              ),
            ),
            widget.enoughSpace
                ? Opacity(
                    opacity: widget.scrollController.hasClients ? (50 - widget.scrollController.offset) / 50 : 1.0,
                    child: SizedBox(
                      width: size.width,
                      height: widget.scrollController.hasClients ? 50 - widget.scrollController.offset : 50,
                      child: Stack(
                        children: const [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Text(
                                  'Talent Clothing',
                                  style: TextStyle(fontSize: 20, fontFamily: 'Merienda', fontWeight: FontWeight.bold),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
            Container(
              width: size.width,
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoryList
                      .map((category) => CategoryChip(
                            title: category,
                            selected: category == selectedCategory,
                            onPressed: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                          ))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
