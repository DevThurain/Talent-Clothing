import 'package:flutter/material.dart';
import 'package:talent_clothing/core/constants/app_colors.dart';
import 'package:talent_clothing/ui/home/sections/app_bar_section.dart';
import 'package:talent_clothing/ui/home/widgets/large_clothing_card.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var enoughSpace = true;
  var scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      // print('opacity ' + ((50 - scrollController.offset)/50).toString());

      if (scrollController.offset < 50.0) {
        setState(() {
          enoughSpace = true;
        });
      } else {
        setState(() {
          enoughSpace = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          AppBarSection(enoughSpace: enoughSpace, scrollController: scrollController),
          SliverToBoxAdapter(
            child: SizedBox(
              height: size.height * 0.4,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  LargeClothingCard(
                    name: 'Causual Read Dress',
                    price: '199.99',
                    image:
                        'https://images.unsplash.com/photo-1585487000160-6ebcfceb0d03?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGNsb3RoaW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=600&q=60',
                    isFav: false,
                    onFavPressed: () {},
                  ),
                  LargeClothingCard(
                    name: 'Shirt And Trouser',
                    price: '2.99',
                    image:
                        'https://images.unsplash.com/photo-1572804013427-4d7ca7268217?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTh8fG1vZGVsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=600&q=60',
                    isFav: false,
                    onFavPressed: () {},
                  ),
                  LargeClothingCard(
                    name: 'Crop Top',
                    price: '50.99',
                    image:
                        'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NjV8fG1vZGVsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=600&q=60',
                    isFav: true,
                    onFavPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 1000,
            ),
          ),
        ],
      ),
    );
  }
}
